<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.addHeader("Cache-Control", "no-store");
	response.setDateHeader("Expires", 1L);
	
	String path = request.getContextPath();
	String logout_path = request.getContextPath() + "/logout.do";
	
	String user_mail = (String)session.getAttribute("user_mail");
	String user_name = (String)session.getAttribute("user_mail");
	String user_img = (String)session.getAttribute("user_pic");
	
	boolean is_login = false;
	if(user_mail != null && user_name != null){
		is_login = true;
	} else{
		response.sendRedirect(request.getContextPath() + "/index.jsp");
	}
%> 
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title></title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<style>
	.body {
		background-color : #eee;
	}
	.menu {
		position : relative;
		width : 600px;
		margin: 245px;
    	display: inline-block;
	}
	.panel {
		margin: -63px -118px -127px;
   		text-align : center;
	}
	.panel-border {
		border: 1px solid #bdbdbd;
	}
	.box {
		margin: -110px;
		padding : 200px;
	}

	.bg-container-fluid {
      padding-top : 100px;
      padding-bottom : 143px;
  	}
  	.container-frame {
  		margin : 10px 300px;
  	}
  	.navbar {
  		margin-bottom : 0px;
  		padding-bottom : 2px;
  		padding-top : 2px;
  	}
  	.navbar-img {
  		width : 145px;
  		margin : -9px;
  	}
  	.navbar-inverse {
  		background-color : #F5F5F5;
  	}
  	.navbar-brand {
  		padding : 7px;
  	}
  	.bg { 
      background-color: #424242;
      color: #fff;
  	}
  	.img {
  		border-radius : 50px;
  	}
  	.content-area{
  		margin : 10px 50px;
  	}
</style>
</head>
<body>
	<div class="navbar navbar-inverse nav-bd">
		<div class="container">
			<div class="navbar-header">
				<!-- id가 c1인 메뉴 부분을 펼칠 수 있도록
				    버튼을 설정한다 -->
				<button class="navbar-toggle"
				        data-toggle="collapse"
				        data-target="#c1">
				        <span class="icon-bar"></span>
				        <span class="icon-bar"></span>
				        <span class="icon-bar"></span>
				</button>
				<div class="navbar-brand">
					<a href="../index.jsp">
						<img class="img navbar-img" src="../img/shagrey.png" width="100px">
					</a>
				</div>
			</div>
			<div class="collapse navbar-collapse" id="c1">
				<ul class="nav navbar-nav navbar-right">
					<li>
						<span>
							<img class="img profile-image" width="50px" src="<%=path%>/upload/<%=user_img%>" />
						</span>
						<span>
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">
								장환원<span class="glyphicon glyphicon-chevron-down"></span>
							</a>
						</span>
						<ul class="dropdown-menu">
							<li><a href="<%=logout_path%>">로그아웃</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="menu">
			<div class="panel panel-border panel-default">
				<div class='row box'>
					<div class="col-sm-3"></div>
					<div class="col-sm-6">
						<img src="../img/alert.png" width="300px"/>
						<p>정말로 탈퇴하시는 겁니까??</p>
						<c:url var="path" value="/deleteUserInfo.do"/>
						<form id="user_mail" class="form-horizontal" name="user_mail"
							  action="${path}" method="post" role="form">
							<div class="form-group">
								<input id="user_mail" name="user_mail" type="submit" class="btn btn-primary form-control" value="탈퇴"/>
							</div>
						</form>
						<p></p>
					</div>
					<div class="col-sm-3"></div>							
				</div>
			</div>
		</div>
	</div>

	<!-- Footer -->
	<footer class="bg-container-fluid bg text-center">
	  <p>Copyright by YongJao Lei, Made By Team 0552</a></p> 
	</footer>
</body>
</html>