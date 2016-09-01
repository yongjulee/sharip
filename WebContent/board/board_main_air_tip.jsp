<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.addHeader("Cache-Control", "no-store");
	response.setDateHeader("Expires", 1L);
	
	String path = request.getContextPath();
	String add_user_page = request.getContextPath() + "/add_user.jsp";
	String logout_path = request.getContextPath() + "/logout.do";
	String mypage_page = request.getContextPath() + "/user/mypage.jsp";
	String write_page = request.getContextPath() + "/board/board_write_1.jsp";
	
	String user_mail = (String)session.getAttribute("user_mail");
	String user_name = (String)session.getAttribute("user_mail");
	String user_img = (String)session.getAttribute("user_pic");
	
	boolean is_login = false;
	if(user_mail != null && user_name != null){
		is_login = true;
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<style>
body {
	font: 20px Montserrat, sans-serif;
	line-height: 1.8;
	color: #f5f6f7;
}

p {
	font-size: 16px;
}

.margin {
	margin-bottom: 30px;
}

.margin2 {
	margin-top: 45px;
}

.search-bar {
	position: relative;
	padding-top: 25px;
	padding-bottom: 25px;
}

.bg-1 {
	background-image: url("<%=path%>/img/tip_air1.jpg");
	background-size:cover;
	background-repeat: no-repeat;
	background-position: center;
	background-color: #cccccc;
	opacity: 0.8;
}




.bg-2 {
	color: #555555;
}

.bg-3 {
	background-color: #ffffff;
	color: #555555;
}

.bg-4 {
	background-color: #424242;
	color: #fff;
}

.bd-1{
color:
}
.container-fluid {
	padding-top: 100px;
	padding-bottom: 150px;
}

.navbar {
	padding-top: 2px;
	padding-bottom: 2px;
	border: 0;
	border-radius: 0;
	margin-bottom: 2px;
	font-size: 12px;
	letter-spacing: 5px;
	background-color: #f9f9f9;
}

.navbar-nav  li a:hover {
	color: #1abc9c !important;
}

.panel {
	margin: 10px 40px 10px 40px;
}

.padding-none {
	padding: 0px;
}
.btn-primary.btn {
    border-color: #ff5a5f;
    border-bottom-color: black;
    background-color: black;
    color: #fff;
}
img.pf{
	width: 40px;
	height: 40px;
	border: 1px solid #E8E8E8;
	margin: 5px 15px;
}
li.pf{
	height: 50px;
}
</style>

<script>
	$(function(){
		$("#user_mail").keydown(function(e){
			if(e.keyCode == 13){
				loginCheck();
			}
		});
		$("#user_pw").keydown(function(e){
			if(e.keyCode == 13){
				loginCheck();
			}
		});
	});
	
	function loginCheck(){
		var param = {
			user_mail : $("#user_mail").val(),
			user_pw : $("#user_pw").val()
		};
		$.ajax({
			url : "<%=path%>/check_login.do",
			type : "post",
			dataType : "text",
			data : param,
			success : function(login_state){
				if(login_state == 1){
					location.reload();
				} else if(login_state == 2){
					$("#pw_state").text("");
					$("#mail_state").text("존재하지 않는 이메일 주소입니다.");
					$("#user_mail").focus();
				} else if(login_state == 3){
					$("#mail_state").text("");
					$("#pw_state").text("비밀번호가 일치하지 않습니다.");
					$("#user_pw").focus();
				}
			}
		});
	}

</script>


</head>
<body>
<!-- Navbar -->
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
			</div>
			
			<div class="navbar-header" id="logo">
				<a href="<%=path%>/index.jsp">
					<img src="<%=path%>/img/shagrey.png" />
				</a>
			</div>
			<%
			if(is_login == false){
			%>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="<%=write_page%>">글쓰기</a></li>
					<li><a href="<%=add_user_page%>">회원가입</a></li>
					<li><a href="#" data-toggle="modal" data-target="#myModal">로그인</a></li>
				</ul>
			</div>
			<%
			} else{
			%>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="<%=write_page%>">글쓰기</a></li>
					<li><a href="<%=mypage_page%>">마이페이지</a></li>
					<li><a href="<%=logout_path%>">로그아웃</a></li>
					<li class="pf"><img class="pf" src="<%=path%>/upload/<%=user_img%>"></li>
				</ul>
			</div>
			<% } %>
		</div>
	</nav>

	<!-- Modal -->
	<div id="myModal" class="modal fade bg-2" style="margin-top: 125px"
		role="dialog" aria-labelledby="myForgetModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title text-center">Login</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="email" class="rs-only">E-Mail</label> 
						<input type="email" id="user_mail" name="user_mail" class="form-control" placeholder="somebody@example.com">
						<div id="mail_state" class="login-state"></div>
					</div>
					<div class="form-group">
						<label for="key" class="rs-only">Password</label> 
						<input type="password" id="user_pw" name="user_pw" class="form-control"placeholder="password">
						<div id="pw_state" class="login-state"></div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-info btn-block" onclick="loginCheck();">로그인</button>
				</div>
				<div
					style="text-align: right; font-size: small; margin-right: 10px; margin-bottom: 5px;">
					<a href="<%=add_user_page%>">회원가입</a>
				</div>
			</div>
		</div>
	</div>
		<!-- First Container -->
	<div class="container-fluid bg-1 text-center">
		<h1 class="margin">유용한 해외여행 팁</h1>
		<h3>항공편</h3>		
	</div>
	
	

<h3 style="margin-left:200px; margin-top:50px; color:rgb(50,50,50)">
Tip 1
똑똑한 항공권 예매 법</h3>
<div class="text-wrap" id="content" >
<div class="container"  style="margin-top:50px; margin-bottom:50px; width:800px"> 


<p style=color:rgb(60,60,60) >
 카약신공
<strong>‘해외출발 항공편을 이용해 저렴한 가격 혹은 비슷한 가격으로 여러 번 여행하는 것’</strong>을 
일명 ‘카약신공’이라고 하는데 그 카약신공을 가능하게 하는 사이트가 바로 카약닷컴입니다. 
여행 기간을 길게 잡고 가는 경우, 출발지로 선택한 곳도 여행할 수 있다는 장점이 있습니다.
</p>

</div>
</div>

<h3 style="margin-left:200px; margin-top:50px; color:rgb(50,50,50)">Tip 2 화요일 오후에 항공권을 구매하자</h3>
<div class="text-wrap" id="content" >
<div class="container"  style="margin-top:50px; margin-bottom:50px; width:800px"> 
<p style=color:rgb(60,60,60) >
<strong>화요일 오후</strong>가 저렴한 항공권구매의 최적의 시기라는 이론이 있다.
실제로 대부분의 항공사가 매주 화요일에 주말마감 할인항공권을 내놓는 것은 사실이며, 
통계적으로도 항공요금은 화요일 오후에 하락하는 경향을 보인다. 이는 많은 항공사들이 
월요일 저녁부터 경쟁사들과 판매경쟁을 벌이기 시작하여 <strong>화요일 오후 3시경</strong> 가장 낮은 
경쟁가격을 내놓기 때문이다.
</p>
</div>
</div>

<h3 style="margin-left:200px; margin-top:50px; color:rgb(50,50,50)">Tip 3 왕복티켓이 아닌 편도구간 예약을 활용하자</h3>
<div class="text-wrap" id="content" >
<div class="container"  style="margin-top:50px; margin-bottom:50px; width:800px"> 
<p style=color:rgb(60,60,60) >
때에 따라서 서로 다른 항공사에서 출도착 편의 <strong>편도티켓을 각각 구매</strong>하는 
편이 한 항공사에서 왕복티켓을 구매하는 것보다 저렴하다.(예를들면 에든버러에서 
파리로 가는 라이언에어 편도티켓을 구매한 후 이지젯을 이용하여 돌아오는 
비행기를 구매하는 방법) 이는 당신의 스케줄을 더욱 탄력적으로 이용할 수 있게 
해줄 뿐만 아니라, 원하는 시간에 더욱 저렴한 요금으로 이동할 수 있게 해줄 것이다.
</p>

</div>
</div>	
	
	
</body>
</html>
