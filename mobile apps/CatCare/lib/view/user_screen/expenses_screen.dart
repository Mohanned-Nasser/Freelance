import 'package:catcare/model/expense_model.dart';
import 'package:catcare/util/format_dates.dart';
import 'package:catcare/widgets/custom_loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../util/alerts.dart';
import '../../util/app_color.dart';
import '../../util/app_style.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../drawer_screen.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({Key? key}) : super(key: key);

  @override
  _ExpensesScreenState createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey(); // add this

  final DateRangePickerController _controller = DateRangePickerController();
  DateTime? _date;

  @override
  void initState() {
    _date = DateTime.now();
    setState(() {
      txtDate.text =dateFormat(_date!);
    });
  }

  final txtDate = TextEditingController();
  final txtItem = TextEditingController();
  final txtCost = TextEditingController();

  int addRadio = 0;
  int listRadio = 1;
  int radioGroup = 0;
  double total=0.00;
  List<DataRow> allRows=[];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      decoration: gradientBackground(),
      child: Scaffold(
        key: _key,
        backgroundColor: Colors.transparent,
        endDrawer: DrawerScreen(),
        appBar: customAppBar(
            context: context,
            title: 'EXPENSES',
            drawerAction: () {
              _key.currentState!.openEndDrawer();
            }),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SfDateRangePicker(
                backgroundColor: AppColors.appWhiteColor,
                selectionColor: AppColors.appOrangeColor,
                onSelectionChanged: selectionChanged,
                controller: _controller,
                headerStyle: DateRangePickerHeaderStyle(
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                          value: addRadio,
                          groupValue: radioGroup,
                          onChanged: (val) {
                            setState(() {
                              radioGroup = val as int;
                            });
                          }),
                      Text('Add Expenses',style: epilogueTextStyle(fontSize: 14.sp)),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                    width: 10.w,
                    child: VerticalDivider(
                      thickness: 2,
                    ),
                  ),
                  Row(
                    children: [
                      Radio(
                          value: listRadio,
                          groupValue: radioGroup,
                          onChanged: (val) {
                            setState(() {
                              radioGroup = val as int;
                            });
                          }),
                      Text('List Expenses',style: epilogueTextStyle(fontSize: 14.sp)),
                    ],
                  ),
                ],
              ),

              // show add expense container only if selected
              Visibility(
                visible: radioGroup==0,
                child: Container(
                  color: AppColors.appGreyColor,
                  padding: EdgeInsets.all(28.h),
                  child: Column(
                    children: [
                      customTextField(
                          controller: txtDate, label: "Date", enable: false),
                      customTextField(controller: txtItem, label: "Item"),
                      customTextField(
                          controller: txtCost,
                          label: "Cost",
                          keyboard: TextInputType.numberWithOptions(
                              signed: true, decimal: true)),
                      SizedBox(
                        height: 20.h,
                      ),
                      customButton(text: "Add  to expenses", action: () {
                        addExpense();
                      }),
                    ],
                  ),
                ),
              ),


              // show table of expenses

              Visibility(
                visible: radioGroup==1,
                child: Container(
                  height: 300.h,
                  color: AppColors.appGreyColor,
                  padding: EdgeInsets.all(28.h),
                  child: StreamBuilder<QuerySnapshot>(
                    stream:ExpenseModel.getExpenseOfMonth(_date!),
                    builder: (context,snapshot) {
                      if(!snapshot.hasData){
                        return Center(child: Text('Getting Expenses.....'));
                      }
                      if(snapshot.data!.size==0){
                        return Center(child: Text('No expense yet',style: fredokaTextStyle(),));
                      }
                      var allDoc=snapshot.data!.docs;
                      List<ExpenseModel> expenses=[];
                      allRows.clear();
                      total=0;

                      for(var doc in allDoc){
                        var model=ExpenseModel.fromJson(doc.data() as Map<String,dynamic>);
                        expenses.add(model);
                      }
                      for(var expense in expenses){
                        total=total+expense.cost!;
                        allRows.add(
                          DataRow(cells: [
                            DataCell(Text('${expense.cost}',style: epilogueTextStyle(fontSize: 14.sp))),
                            DataCell(Text('${expense.item}',style: epilogueTextStyle(fontSize: 14.sp))),
                          ]),
                        );
                      }
                      allRows.add(totalRow());
                      return _createDataTable(context);
                    }
                  )
                ),
              ),

            ],
          ),
        ),
      ),
    ));
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    SchedulerBinding.instance.addPostFrameCallback((duration) {
      setState(() {
        _date = args.value;
        txtDate.text = dateFormat(_date!);
      });
    });
  }


  Widget _createDataTable(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text('Current Month - ${getMonthName(_date!)}',style: fredokaTextStyle(fontSize: 15.sp),),
          DataTable(columns: _createColumns(), rows: _createRows()),
        ],
      ),
    );
  }
  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Cost \$',style: epilogueTextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),)),
      DataColumn(label: Text('Items',style: epilogueTextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),)),
    ];
  }
  List<DataRow> _createRows() {
    return allRows;
  }

  totalRow(){
    return DataRow(cells: [
      DataCell(Text('Total : ${total}',style: epilogueTextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold))),
      DataCell(Text('')),
    ]);
  }


  String? item;
  double? cost;

  getValues() {
    item = txtItem.text;
    cost = double.parse(txtCost.text.isEmpty ? '0.00' : txtCost.text);
  }

  isEmpty() {
    if (item!.isEmpty||txtCost.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  addExpense() async {
    getValues();
    if (isEmpty()) {
      MyAlerts.showInfoBox(context, "Please fill all details");
    } else {
      customLoadingIndicator(context, text: "Adding Expense...");
      ExpenseModel expenseModel = ExpenseModel(
          item: item,
          expenseDate: Timestamp.fromDate(_date!),
          cost: cost);
      bool result = await expenseModel.addExpenses(context: context);
      if (result) {
        Navigator.pop(context);
        MyAlerts.showInfoBox(context, "Expense Added Successfully.");
      }
    }
  }
}
