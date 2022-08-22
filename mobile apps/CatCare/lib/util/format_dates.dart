

import 'package:intl/intl.dart';

dateFormat(DateTime dateTime){
  return DateFormat('dd,MMMM yyyy').format(dateTime).toString();
}
getMonthName(DateTime dateTime){
  return DateFormat('MMMM').format(dateTime).toString();
}