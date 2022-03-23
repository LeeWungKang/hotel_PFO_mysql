<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<style type="text/css">
/* body {
	color: #5D5F63;
	background: #293949;
	font-family: 'Open Sans', sans-serif;
	padding: 0;
	margin: 0;
	text-rendering: optimizeLegibility;
	-webkit-font-smoothing: antialiased;
}

.sidebar-toggle {
	margin-left: -240px;
}

.sidebar {
	width: 240px;
	height: 100%;
	background: #293949;
	position: absolute;
	-webkit-transition: all .3s ease-in-out;
	-moz-transition: all .3s ease-in-out;
	-o-transition: all .3s ease-in-out;
	-ms-transition: all .3s ease-in-out;
	transition: all .3s ease-in-out;
	z-index: 100; # leftside-navigation { ul, ul ul { margin : -2px 0 0;
	padding: 0;
}

}
}
ul {li { list-style-type:none;
	border-bottom: 1px solid rgba(255, 255, 255, .05);
	&.
	active
	{
	&
	>
	a
	{
	color
	:
	#1abc9c;
}

}
}
}
ul {
	display: block;
}

}
a {
	color: #aeb2b7;
	text-decoration: none;
	display: block;
	padding: 18px 0 18px 25px;
	font-size: 12px;
	outline: 0;
	-webkit-transition: all 200ms ease-in;
	-moz-transition: all 200ms ease-in;
	-o-transition: all 200ms ease-in;
	-ms-transition: all 200ms ease-in;
	transition: all 200ms ease-in;
	&:
	hover
	{
	color
	:
	#1abc9c;
}

}
span {
	display: inline-block;
}

i {
	width: 20px;
	.
	fa-angle-left
	,
	.fa-angle-right
	{
	padding-top
	:
	3px;
}

}
ul ul {
	display: none; li { background : #23313f;
	margin-bottom: 0;
	margin-left: 0;
	margin-right: 0;
	border-bottom: none; a { font-size : 12px;
	padding-top: 13px;
	padding-bottom: 13px;
	color: #aeb2b7;
} */

/* -------------------------------= */


/*  */
.snip1284 {
  font-family: 'Raleway', Arial, sans-serif;
  text-align: center;
  text-transform: uppercase;
  font-weight: 500;
  letter-spacing: 1px;
}
.snip1284 * {
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  -webkit-transition: all 0.35s ease;
  transition: all 0.35s ease;
}
.snip1284 li {
  display: inline-block;
  list-style: outside none none;
  margin: 0.5em 1.2em;
  padding: 0;
}
.snip1284 a {
  padding: 0 0.6em;
  color: rgba(255, 255, 255, 0.5);
  position: relative;
  text-decoration: none;
}
.snip1284 a:before,
.snip1284 a:after {
  width: 3px;
  height: 0;
  position: absolute;
  content: '';
  -webkit-transition: all 0.35s ease;
  transition: all 0.35s ease;
  background-color: #1abc9c;
}
.snip1284 a:before {
  top: 0;
  right: 0;
}
.snip1284 a:after {
  bottom: 0;
  left: 0;
}
.snip1284 a:hover,
.snip1284 .current a {
  color: #ffffff;
}
.snip1284 a:hover:before,
.snip1284 .current a:before,
.snip1284 a:hover:after,
.snip1284 .current a:after {
  height: 100%;
}


</style>

</head>
<body>


	<h2>2번쨰</h2>

	<nav>
		<ul class="snip1284">
			<li><a href="index.jsp?filePath=mainSection">Home</a></li> 
			<li><a href="RoomInfo?roomseq=1"> Room </a></li>
			<li><a href="index.jsp?filePath=./room/rservation"> Rservation </a></li>
			<li><a href="index.jsp?filePath=location"> Location </a></li>
			<li><a href="#">Products</a></li>
			<li><a href="#">Contact</a></li>
		</ul>
	</nav>







<!-- 
	<aside class="sidebar">
		<div id="leftside-navigation" class="nano">
			<ul class="nano-content">


				<li class="sub-menu active"><a href="javascript:void(0);"><i
						class="fa fa-envelope"></i><span>Mail</span><i
						class="arrow fa fa-angle-right pull-right"></i></a>
					<ul>
						<li class="active"><a href="mail-inbox.html">Inbox</a></li>
						<li><a href="mail-compose.html">Compose Mail</a></li>
					</ul></li>
				<li class="sub-menu"><a href="javascript:void(0);"><i
						class="fa fa-bar-chart-o"></i><span>Charts</span><i
						class="arrow fa fa-angle-right pull-right"></i></a>
					<ul>
						<li><a href="charts-chartjs.html">Chartjs</a></li>
						<li><a href="charts-morris.html">Morris</a></li>
						<li><a href="charts-c3.html">C3 Charts</a></li>
					</ul></li>
				<li class="sub-menu"><a href="javascript:void(0);"><i
						class="fa fa-map-marker"></i><span>Maps</span><i
						class="arrow fa fa-angle-right pull-right"></i></a>
					<ul>
						<li><a href="map-google.html">Google Map</a></li>
						<li><a href="map-vector.html">Vector Map</a></li>
					</ul></li>
				<li class="sub-menu"><a href="javascript:void(0);"><i
						class="fa fa-file"></i><span>Pages</span><i
						class="arrow fa fa-angle-right pull-right"></i></a>
					<ul>
						<li><a href="pages-blank.html">Blank Page</a></li>
						<li><a href="pages-login.html">Login</a></li>
						<li><a href="pages-sign-up.html">Sign Up</a></li>
					</ul></li>
			</ul>
		</div>
	</aside>

 -->
	<!----------------------------------------  -->


	<script type="text/javascript">
		$("#leftside-navigation .sub-menu > a").click(
				function(e) {
					$("#leftside-navigation ul ul").slideUp(), $(this).next()
							.is(":visible")
							|| $(this).next().slideDown(), e.stopPropagation()
				})
				
				
/* $('li').on('click', function(){
  $(this).addClass('current'); 
})
 
				
$("").mouseleave(
  function () {
    $(this).removeClass("current");
  }
);
		 */
		 
		 //클릭시 current 엑티브 기능 활성화.  다른 메뉴클릭시 변화.
		$(document).ready(function(){
			$('li').each(function(index){
				$(this).attr('menu-index', index);
			}).click(function(){
				var index = $(this).attr('menu-index');
				$('li[menu-index =' + index + ']').addClass('current');
				$('li[menu-index !=' + index + ']').removeClass('current');
			});


		});		
		
		
		
		
	</script>

</body>
</html>