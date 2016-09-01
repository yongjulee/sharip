<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	String user_name = (String)session.getAttribute("user_name");
	String user_img = (String)session.getAttribute("user_pic");
	
	boolean is_login = false;
	if(user_mail != null && user_name != null){
		is_login = true;
	}
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>메인 페이지</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<link href="http://fonts.googleapis.com/css?family=Montserrat"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
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
	margin-top: 75px;
}

.bg-1 {
	background-image: url("img/paris.jpg");
	background-size: cover;
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
	padding: 0px;
	margin-bottom: 30px;
}

.bg-4 {
	background-color: #424242;
	color: #fff;
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
</head>

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
			url : "check_login.do",
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
	
	function checkValues(){
		if($("#continent").val() == "" || $("#travel").val() == ""){
			return false;
		}
		return true;
	}

</script>

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
				<img src="img/shagrey.png" />
			</div>
			<%
			if(is_login == false){
			%>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav navbar-right">
					<li class="li-nb"><a href="<%=path%>/write1.do">글쓰기</a></li>
					<li class="li-nb"><a href="<%=path%>/join_sharip.do">회원가입</a></li>
					<li class="li-nb"><a href="#" data-toggle="modal" data-target="#myModal">로그인</a></li>
				</ul>
			</div>
			<%
			} else{
			%>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav navbar-right">
					<li class="li-nb"><a href="<%=path%>/write1.do">글쓰기</a></li>
					<li class="li-nb"><a href="<%=path%>/my_page.do">마이페이지</a></li>
					<li class="li-nb"><a href="<%=logout_path%>">로그아웃</a></li>
					<li class="li-nb" class="pf"><img class="pf" src="<%=path%>/upload/<%=user_img%>"></li>
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
	<div class="container-fluid bg-1 text-center" style="height: 600px;">
		<h2 class="margin" style="font-size: 60px;"><strong>당신의 여행지를 알려주세요</strong></h2>
		<h3>나만 알던 비밀 여행지 <span style="color: #38a3dc;">SHARIP</span></h3>
			<!-- Search Bar -->
			<div class="container search-bar">
				<form action="board_main.do" method="GET" onsubmit="return checkValues();">
					<div class="col-sm-3"></div>
					<div class="form-group col-sm-2 padding-none">
						<select id="continent" name="continent" class="form-control" style="border-radius: 0px;">
							<option value="">대륙</option>
							<option value="north america">북미</option>
							<option value="south america">남미</option>
							<option value="europe">유럽</option>
							<option value="asia">아시아</option>
							<option value="oceania">오세아니아</option>
							<option value="africa">아프리카</option>
						</select>
					</div>
					<div class="form-group col-sm-2 padding-none">
						<select id="travel" name="travel" class="form-control" style="border-radius: 0px;">
							<option value="">여행 목적</option>
							<option value="food">음식</option>
							<option value="culture">문화</option>
							<option value="natrue">자연</option>
							<option value="shopping">쇼핑</option>
							<option value="rest">휴양</option>
						</select>
					</div>
					<div class="col-sm-2 padding-none">
						<button type="submit" class="btn btn-primary btn-block" style="vertical-align: top; border-radius: 0px;">여행 검색</button>	
					</div>
				</form>
			</div>
	</div>

	<!-- Second Container -->
	<div class="panel bg-2 text-center">
		<h3 class="margin" style="color: #38a3dc;">Share + Trip = ShaRip</h3>
		<p>나만 알고 있던 소중한 여행지를 공유해 주세요</p>
		<p>나의 취향에 딱 맞는 여행지를 발굴하세요</p>
	</div>

	<!-- Container (Services Section) -->
	<div id="services" class="container-fluid bg-2 text-center">
		<h2 class="margin" style="margin-bottom: 10px;">여행의 <span style="color: #38a3dc;">목적</span></h2>
		<br>
		<div class="row slideanim">
			<div class="col-sm-4">
				<img src="<%=path%>/img/main_icon1.png"/>
				<h4>음식</h4>
				<p>FOOD</p>
			</div>
			<div class="col-sm-4">
				<img src="<%=path%>/img/main_icon2.png"/>
				<h4>자연</h4>
				<p>NATURE</p>
			</div>
			<div class="col-sm-4">
				<img src="<%=path%>/img/main_icon3.png"/>
				<h4>쇼핑</h4>
				<p>SHOPPING</p>
			</div>
		</div>
		<br> <br>
		<div class="row slideanim">
			<div class="col-sm-4">
				<img src="<%=path%>/img/main_icon4.png"/>
				<h4>문화</h4>
				<p>CULTURE</p>
			</div>
			<div class="col-sm-4">
				<img src="<%=path%>/img/main_icon5.png"/>
				<h4>휴양</h4>
				<p>VACATION</p>
			</div>
			<div class="col-sm-4">
				<img src="<%=path%>/img/main_icon6.png"/>
				<h4 style="color: #303030;">SHARIP</h4>
				<p>내가 원하는 여행을 찾아서</p>
			</div>
		</div>
	</div>

	<!-- Third Container (Grid) -->
	<div class="bg-3 text-center">
		<h2 class="margin" style="margin-bottom: 0px;">여행을 위한 <span style="color: #38a3dc;">정보</span></h2>
		<br>
		<div class="row">
			<div class="col-sm-4">
				<img src="img/tip1.jpg" class="img-responsive margin"
					style="width: 100%" alt="Image">
				<h3>금주의 <span style="color: #38a3dc;">BEST</span> 게시물</h3>
			</div>
			<div class="col-sm-4">
				<a href="<%=path%>/board/board_main_air_tip.jsp">
				<img src="img/tip2.jpg" class="img-responsive margin"
					style="width: 100%" alt="Image">
				</a>
				<h3><span style="color: #38a3dc;">항공</span> 정보</h3>
			</div>
			<div class="col-sm-4">
				<a href="<%=path%>/board/board_main_dom_tip.jsp">
				<img src="img/tip3.jpg" class="img-responsive margin"
					style="width: 100%" alt="Image">
				</a>
				<h3><span style="color: #38a3dc;">숙소</span> 정보</h3>
				
			</div>
		</div>
	</div>

	<!-- Footer -->
	<footer class="container-fluid bg-4 text-center">
		<p>
			Copyright by YongJao Lei, Made By Team 0552
		</p>
	</footer>

</body>
</html>
