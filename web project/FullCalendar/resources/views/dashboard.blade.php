
<link rel="stylesheet" type="text/css" href="/css/custom.css" />

<x-app-layout>

    <x-slot name="header_content">
		
        <h1>Welcome to time management application </h1>
       
        <div class="section-header-breadcrumb">
			
            <div class="breadcrumb-item active"><a href="#">Dashboard</a></div>
            <div class="breadcrumb-item"><a href="#">Layout</a></div>
            <div class="breadcrumb-item">Default Layout</div>
        </div>
    </x-slot>

    <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
      
    </div>
	
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
	<div>
	<h1 style=" font-size: 40px;" >Welcome to our time management application </h1>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
	<br>
	<br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    
    <!DOCTYPE html>
<html>

<head>


	<link rel="stylesheet" type="text/css" href="clock.css">
	<style type="text/css">
	

<style>
	.h1 {
  font-size: 400px;
}
.body{
	width: 100vw;
	height: 100vh;
	overflow: hidden;
	background: linear-gradient(45deg, #2ecc71, #16a085);
}

.clock{
	position: relative;
	width: 500px;
	height: 500px;
	overflow: hidden;
	border-radius: 250px;
	border: 10px solid #111;
	background-color: #fff;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

.clock:after{
	content: '';
	position: absolute;
	width: 100%;
	height: 100%;
	top: 0;
	left: 0;
	background: linear-gradient(285deg, rgba(0, 0, 0, 0.175) 50%, rgba(0, 0, 0, 0.1) 50%);
}

.clock:before{
	content: '';
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 20px;
	height: 20px;
	background-color: black;
	border-radius: 50%;
}

.num{
	position: absolute;
	width: 100%;
	height: 100%;
	top: 0;
	left: 0;
	text-align: center;
	font-size: 2rem;
	font-weight: 700;
	padding: 18px;
}

.num:after{
	content: '';
	position: absolute;
	top: 0;
	left: 50%;
	transform: translateX(-50%);
	width: 5px;
	height: 15px;
	background-color: black;
}

.num1{
	transform: rotate(30deg);
}
.num1 div{
	transform: rotate(-30deg);
}

.num2{
	transform: rotate(60deg);
}
.num2 div{
	transform: rotate(-60deg);
}

.num3{
	transform: rotate(90deg);
}
.num3 div{
	transform: rotate(-90deg);
}

.num4{
	transform: rotate(120deg);
}
.num4 div{
	transform: rotate(-120deg);
}

.num5{
	transform: rotate(150deg);
}
.num5 div{
	transform: rotate(-150deg);
}

.num6{
	transform: rotate(180deg);
}
.num6 div{
	transform: rotate(-180deg);
}

.num7{
	transform: rotate(210deg);
}
.num7 div{
	transform: rotate(-210deg);
}

.num8{
	transform: rotate(240deg);
}
.num8 div{
	transform: rotate(-240deg);
}

.num9{
	transform: rotate(270deg);
}
.num9 div{
	transform: rotate(-270deg);
}

.num10{
	transform: rotate(300deg);
}
.num10 div{
	transform: rotate(-300deg);
}

.num11{
	transform: rotate(330deg);
}
.num11 div{
	transform: rotate(-330deg);
}

.hand{
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
}

.hand div{
	position: absolute;
	bottom: 50%;
	left: 50%;
	transform: translateX(-50%);
	background-color: #000;
}

.sec{
	width: 1px;
	height: 40%;
}

.min{
	height: 38%;
	width: 4px;
	border-radius: 2px;
}

.hour{
	height: 28%;
	width: 8px;
	border-radius: 4px;
}

	</style>
</head>
<body>
	<div class="clock">
		<div class="num num1">
			<div>1</div>
		</div>
		<div class="num num2">
			<div>2</div>
		</div>
		<div class="num num3">
			<div>3</div>
		</div>
		<div class="num num4">
			<div>4</div>
		</div>
		<div class="num num5">
			<div>5</div>
		</div>
		<div class="num num6">
			<div>6</div>
		</div>
		<div class="num num7">
			<div>7</div>
		</div>
		<div class="num num8">
			<div>8</div>
		</div>
		<div class="num num9">
			<div>9</div>
		</div>
		<div class="num num10">
			<div>10</div>
		</div>
		<div class="num num11">
			<div>11</div>
		</div>
		<div class="num num12">
			<div>12</div>
		</div>

		<div class="hand" id="sec">
			<div class="sec"></div>
		</div>
		<div class="hand" id="min">
			<div class="min"></div>
		</div>
		<div class="hand" id="hour">
			<div class="hour"></div>
		</div>
    </div>
    
   
	<script >
		const secDiv = document.getElementById('sec');
const minDiv = document.getElementById('min');
const hourDiv = document.getElementById('hour');

setInterval(updateClock, 1000);

function updateClock(){
	let date = new Date();
	let sec = date.getSeconds() / 60;
	let min = (date.getMinutes() + sec) / 60;
	let hour = (date.getHours() + min) / 12;

	secDiv.style.transform = "rotate(" + (sec * 360) + "deg)";
	minDiv.style.transform = "rotate(" + (min * 360) + "deg)";
	hourDiv.style.transform = "rotate(" + (hour * 360) + "deg)";
}

updateClock();
	</script>
</body>

</html>  


   
</x-app-layout>



