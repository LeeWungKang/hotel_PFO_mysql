<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link href="./css/mainSection.css" rel="stylesheet">
</head>
<body>

	<div class="section">
					
		<input type="radio" name="slide" id="slide01" checked="checked">
		<input type="radio" name="slide" id="slide02"> 
		<input type="radio" name="slide" id="slide03">
	
		<div class="slideWrap">
			<ul class="slideList">
				<li>
					<a> 
					<label for="slide03" class="left"></label>
						<img src="./img/main01.jpg"> 
					<label for="slide02" class="right"></label>
					</a>
				</li>
				<li>
					<a> 
					<label for="slide01" class="left"> </label>
						 <img src="./img/main02.jpg"> 
					<label for="slide03" class="right"></label>
					</a>
				</li>
				<li>
					<a> 
					<label for="slide02" class="left"> </label>
					 	<img src="./img/main03.jpg">
					<label for="slide01" class="right"></label>
					</a>
				</li>
			</ul>
		</div>

	</div>



</body>
</html>