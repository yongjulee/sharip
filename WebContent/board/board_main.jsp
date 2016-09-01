<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="bean.*" %>
<%@ page import="java.util.ArrayList" %>
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
	
	String continent_name = request.getParameter("continent");
	String travel_name = request.getParameter("travel");
	
	ArrayList<BoardBean> board_list = (ArrayList<BoardBean>)request.getAttribute("board_bean");
	
	boolean is_login = false;
	if(user_mail != null && user_name != null){
		is_login = true;
	}
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>글 목록 페이지</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=path%>/css/style.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script src="<%=path%>/js/functions.js"/></script>
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
	margin-top: 80px;
}

.container-fluid {
	padding-top: 100px;
	padding-bottom: 150px;
}
.search-bar {
	position: relative;
	padding-top: 25px;
	padding-bottom: 25px;
	margin-top: 60px;
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
div.mouse-over:hover{
	opacity: 0.7;
}
.bg-1 {
	background-image: url("<%=path%>/img/newyork.jpg");
	background-size: cover;
	background-repeat: no-repeat;
	background-position: center;
	background-color: #cccccc;
	opacity: 0.8;
}

.bg-2 {
	color: #555555;
}

.panel-footer {
	font-size: 12px;
	color: #141414;
	text-align: center;
}
.panel-success{
	position: relative;
}

.bg-4 {
	background-color: #424242;
	color: #fff;
}

.container-fluid {
	padding-top: 125px;
	padding-bottom: 175px;
}

.padding-none {
	padding: 0px;
}

.btn-primary.btn {
	background-color: black;
	color: #fff;
}

.img-wrapping {
	position: absolute;
	top: 63%;
	right: 15%;
	width: 60px;
	height: 60px;
	vertical-aligh: center;
	border: 3px solid;
	border-color: #d3d3d3;
}
.no-content {
	text-align: center;
	color: #38a3dc;
	margin-bottom: 100px;
}
</style>
</head>

<script>
	$(function(){
		var continent_name = "<%=continent_name%>";
		var travel_name = "<%=travel_name%>";
		
		$("#continent").val(continent_name);
		$("#travel").val(travel_name);
		
		if(continent_name == "north america"){
			$("#title1").text("북아메리카");
		} else if(continent_name == "south america"){
			$("#title1").text("남아메리카");
		} else if(continent_name == "europe"){
			$("#title1").text("유럽");
		} else if(continent_name == "asia"){
			$("#title1").text("아시아");
		} else if(continent_name == "oceania"){
			$("#title1").text("오세아니아");
		} else if(continent_name == "africa"){
			$("#title1").text("아프리카");
		}
		
		if(travel_name == "food"){
			$("#title2").text("음식");
		} else if(travel_name == "culture"){
			$("#title2").text("문화");
		} else if(travel_name == "nature"){
			$("#title2").text("자연");
		} else if(travel_name == "shopping"){
			$("#title2").text("쇼핑");
		} else if(travel_name == "rest"){
			$("#title2").text("휴양");
		}
	})
	
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
				<a href="<%=path%>/index.jsp">
					<img src="img/shagrey.png" />
				</a>
			</div>
			<%
			if(is_login == false){
			%>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="<%=path%>/write1.do">글쓰기</a></li>
					<li><a href="<%=path%>/join_sharip.do">회원가입</a></li>
					<li><a href="#" data-toggle="modal" data-target="#myModal">로그인</a></li>
				</ul>
			</div>
			<%
			} else{
			%>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="<%=path%>/write1.do">글쓰기</a></li>
					<li><a href="<%=path%>/my_page.do">마이페이지</a></li>
					<li><a href="<%=path%>/logout.do">로그아웃</a></li>
					<li class="pf"><img class="pf" src="<%=path%>/upload/<%=user_img%>"></li>
				</ul>
			</div>
			<% } %>
			
			<%-- 
			<div class="navbar-header" id="logo">
				<a href="<%=path%>/index.jsp">
					<img src="<%=path%>/img/shagrey.png" />
				</a>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="<%=path%>/write1.do">글쓰기</a></li>
					<li><a href="<%=add_user_page%>">회원가입</a></li>
					<li><a href="#" data-toggle="modal" data-target="#myModal">로그인</a></li>
				</ul>
			</div>
			--%>
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

	<!-- Search Container -->
	<div class="container-fluid bg-1 text-center" style="height: 600px;">
		<h2 id="title1" style="font-size: 50px;"></h2>
		<h3 id="title2" style="font-size: 30px;"></h3>

		<!-- Search Bar -->
		<div class="container search-bar">
			<form action="<%=path%>/board_main.do" method="GET" onsubmit="return checkValues();">
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
						<option value="nature">자연</option>
						<option value="shopping">쇼핑</option>
						<option value="rest">휴양</option>
					</select>
				</div>
				<div class="col-sm-2 padding-none">
					<button type="submit" class="btn btn-primary btn-block"
						style="vertical-align: top; border-radius: 0px;">여행 검색</button>
				</div>
			</form>
		</div>
	</div>

	<!-- 글 목록 창 -->
	<div class="container">
		<div class="row margin2">
			<%if(board_list.isEmpty()){ %>
			<div class="no-content" >
				<h1>내용이 없습니다</h1>
				<h3>첫번째로 여행지를 등록해 주세요!</h3>
			</div>
			<%} else{ %>
			<c:forEach var="board_bean" items="${requestScope.board_bean}">
				<div class="col-sm-4 mouse-over">
					<div class="panel panel-success">
					<a href="read.do?board_idx=${board_bean.board_idx}">
						<div class="panel-header">
							<img src="<%=path%>/upload/${board_bean.board_img1}" class="img-responsive"
								style="width: 100%; height: 300px;" alt="Image"> 
							<img src="<%=path%>/upload/${board_bean.user_pic}" class="img-circle img-wrapping" />
						</div>
					</a>
						<div class="panel-body bg-2">
							
							<h3>${board_bean.board_title}</h3>	
							<script>
								$("#title").val(convertTagString(""));
							</script>
						</div>
							<div class="panel-footer bg-2">
									${board_bean.board_loc} | ${board_bean.travel_name} | ${board_bean.continent_name}
							</div>
						
					</div>
				</div>
			</c:forEach>
			<%} %>
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
