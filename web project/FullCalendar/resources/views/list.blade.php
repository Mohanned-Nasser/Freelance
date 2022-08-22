
 <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>Page Title</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel='stylesheet' type='text/css' media='screen' href='main.css'>
    <script src='main.js'></script>


<style type="text/css">
a:hover {
  color: red;
  background-color: #03bafc;
}


.button {
  transition: 0.3s;
  font: bold 15px Arial;
  text-decoration: none;
  background-color: #a2e0f6;
  color: #333333;
  padding: 2px 6px 2px 6px;
  border-top: 2px solid #CCCCCC;
  border-right: 2px solid #333333;
  border-bottom: 2px solid #333333;
  border-left: 2px solid #CCCCCC;
  
  
}
.center {
  margin: auto;
  width: 60%;
  border: 3px solid #73AD21;
  padding: 10px;
}
.tg  {border-collapse:collapse;border-spacing:0;     box-shadow:
0 2.8px 2.2px rgba(0, 0, 0, 0.034),
0 6.7px 5.3px rgba(0, 0, 0, 0.048),
0 12.5px 10px rgba(0, 0, 0, 0.06),
0 22.3px 17.9px rgba(0, 0, 0, 0.072),
0 41.8px 33.4px rgba(0, 0, 0, 0.086),
0 100px 80px rgba(0, 0, 0, 0.12);}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-2fxc{background-color:#a2e0f6;border-color:inherit;font-weight:bold;text-align:center;vertical-align:middle}
.tg .tg-upr4{background-color:#A2E0F6;border-color:inherit;font-weight:bold;text-align:center;vertical-align:top}
.tg .tg-0pky{border-color:inherit;text-align:left;vertical-align:top}
.tg .tg-mfxt{background-color:#ffffff;border-color:inherit;text-align:center;vertical-align:middle}
</style>
<table class="tg" style="margin: auto; 'undefined;table-layout: fixed; width: 943px; margin-left:auto;margin-right:auto;">
<colgroup>

<col style="width: 50px">
<col style="width: 550px">
<col style="width: 170px">
<col style="width: 170px">
<col style="width: 170px">
<col style="width: 100px">
</colgroup>

<thead>
  <tr>
    
    <th class="tg-2fxc">ID</th>
    <th class="tg-2fxc">Title</th>
    <th class="tg-2fxc">Start</th>
    <th class="tg-2fxc">End</th>
    <th class="tg-2fxc">Last Update</th>
    <th class="tg-2fxc">Update Event</th>
    <th class="tg-2fxc">Delete Event</th>
    
  </tr>
</thead>


<tbody>


@foreach ($events as $item)
  <tr>
  
    <td class="tg-mfxt">{{ $item['id'] }}</td>
    <td class="tg-mfxt">{{ $item['title'] }}</td>
    <td class="tg-mfxt">{{ $item['start'] }}</td>
    <td class="tg-mfxt">{{ $item['end'] }}</td>
    <td class="tg-mfxt">{{ $item['updated_at'] }}</td>
    <td class="tg-mfxt" ><a href="{{'edit/'.$item['id']}}" class="button">edit</a>
    <td class="tg-mfxt" ><a href="{{'delete/'.$item['id']}}" class="button">Delete</a>      
                  
    
  </tr>
 
  @endforeach
  
</tbody>
</table>















