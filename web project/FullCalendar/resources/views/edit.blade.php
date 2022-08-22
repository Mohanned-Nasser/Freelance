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
  
  background-color:rgb(139, 209, 252); opacity:0.8;
  
  
  
  
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

button:hover {
  color: green;
  background-color: #03bafc;
}
</style>


<div class = box>
<div>
<br> 
<h1>Update Event </h1>
<form action="/edit"method="POST">
@csrf
<input type="hidden" name="id" value="{{$data['id']}}">

<input type="text" name="title" size="20" style="font-size:15pt" value="{{$data['title']}}"> <br> <br>
<input type="text" name="start" size="20" style="font-size:15pt" value="{{$data['start']}}"> <br> <br>
<input type="text" name="end" size="20" style="font-size:15pt" value="{{$data['end']}}"> <br> <br>
<button type="submit" size="20" style="font-size:15pt" class="button">Update</button>
<br> <br>
</form>
</dive>
</dive>