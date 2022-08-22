<!DOCTYPE html>
<html>
    <style>
        div {text-align: center; 
        
        }
        .box {
  box-shadow:
  0 2.8px 2.2px rgba(0, 0, 0, 0.034),
  0 6.7px 5.3px rgba(0, 0, 0, 0.048),
  0 12.5px 10px rgba(0, 0, 0, 0.06),
  0 22.3px 17.9px rgba(0, 0, 0, 0.072),
  0 41.8px 33.4px rgba(0, 0, 0, 0.086),
  0 100px 80px rgba(0, 0, 0, 0.12);

  
  
  min-height: 200px;
  width: 65vw;
  margin: 100px auto;
  border-radius: 5px;
  
  
  
  
  
  
}
.bg{
    background-color:rgb(139, 209, 252); opacity:0.8;
   
}
        
        </style>
<body>
<div>
<div class = box>
    <div class = bg>
    <br>
<h2>Add Event</h2>
<br>
<br>



<form action="insertEvent" method="POST">
@csrf 

  <label for="fname" style="font-size:20pt";>Title:</label>
  <input type="text" id="title" name="title" size="20" style="font-size:15pt"; >
  
  <label for="lname" style="font-size:20pt">Start Date:</label>
  <input type="datetime-local" id="start" name="start" style="font-size:15pt";>
  
  <label for="lname" style="font-size:20pt">End  Date:</label>
  <input type="datetime-local" id="end" name="end"style="font-size:15pt"; >
  
<br>
<br>
<br>
 <button type="submit" class="btn btn-primary btn-info">ADD EVENT  <span class="glyphicon glyphicon-cloud-upload" ></span></button>
</form> 
<br>

</div>
</div>
</div>











</body>
</html>
