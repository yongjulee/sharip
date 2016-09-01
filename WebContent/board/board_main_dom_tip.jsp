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
	background-image: url("<%=path%>/img/dom.jpg");
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
		<h3>숙소편</h3>		
	</div>
	
	

<h3 style="margin-left:200px; margin-top:50px; color:rgb(50,50,50)">Tip 1. 여행이 처음이라면 현지인이 운영하는 민박이나 게스트하우스, 호스텔로!</h3>
<div class="text-wrap" id="content" >
<div class="container"  style="margin-top:20px; margin-bottom:20px; width:800px"> 


<p style=color:rgb(60,60,60) >
	각 나라마다, 현지인 게스트하우스에서 부터, 한국인이 운영하는 민박 등 다양한 <strong>게스트하우스</strong>가 있는데,
  호텔보다 가격도 저렴하고, 식사제공이나, 여행정보를 받을수 있는 장점과, 또한 다른 여행자들을 쉽게 <br/> 
  만날수 있는 장점이 있습니다.
  되도록이면 1일~2일정도는 게스트하우스 이용을 통해 변화된 여행정보를 수집하고, 
  많은 전세계 여행자들을 통해 동행 구하기, 투어 죠인 등을 알아보시는 것이 좋습니다.

</p>

</div>
</div>

<h3 style="margin-left:200px; margin-top:50px; color:rgb(50,50,50)">Tip 2 여러 사이트를 비교해보자</h3>
<div class="text-wrap" id="content" >
<div class="container"  style="margin-top:50px; margin-bottom:50px; width:800px"> 


<p style=color:rgb(60,60,60) >
호텔을 선택하고 나서 여러 사이트를 돌아다니며 <strong>가격을 비교</strong>해보세요 
조금 번거로울 수 있겠지만 적게는 몇천 원에서 크게는 몇만 원까지 절약 할 수 있어 
예약 전 꼭 한번은 확인하는 것을 권고드립니다.
- 여러 사이트를 돌아다니는 번거로움을 해결한 호텔 가격비교 사이트<strong>PINCAKE, Hotels Combined</strong> 등 
호텔 가격비교 사이트를 이용하면 마우스 클릭만으로 여러 사이트의 가격을 비교 할 수 있어 
예약 전 3분만 투자를 하면 적지 않은 비용을 절약 할 수 있습니다.
</p>

</div>
</div>

<h3 style="margin-left:200px; margin-top:50px; color:rgb(50,50,50)">Tip 3 숙소 역 경매 사이트를 이용하기</h3>
<div class="text-wrap" id="content" >
<div class="container"  style="margin-top:50px; margin-bottom:50px; width:800px"> 


<p style=color:rgb(60,60,60) >
다음은 정해진 예산은 있지만, 이 예산을 뛰어넘는(?) 곳으로 예약하고 싶은 욕심 많은 
당신을 위해 추천해드리는 숙소 역 경매 사이트 <strong>프라이스라인</strong> 입니다.
숙소 역 경매란 말 그대로 호텔의 급과 본인이 희망하는 금액을 적으면, 
사이트에서 호텔을 매칭 해주는 것을 말합니다. 매칭되어 정해진 호텔은 랜덤이라서 
특별히 원하는 곳이 되지 않았더라도 <strong>선 결제</strong>되기 때문에 취소하기가 매우 어려워요.
따라서 신중하게 신청을 해야 합니다. 하지만, 잘만 매칭되면 하루에 50만원 하는 호텔이
13만원으로 쭉쭉 내려가는 대박을 건질 수도 있답니다.
</p>

</div>
</div>	
	
	
</body>
</html>
