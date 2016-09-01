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
	String index_path = request.getContextPath() + "/index.jsp";
	String CheckMail_path = request.getContextPath() + "/CheckMail.do";
	String mypage = request.getContextPath() + "/my_page.do";
	String mypage_modify = request.getContextPath() + "/user/userinfo_modify.jsp";
	
	String img_path = request.getContextPath();
	String user_mail = (String)session.getAttribute("user_mail");
	String user_name = (String)session.getAttribute("user_name");
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
	.side-menu1 {
		position : relative;
		width : 300px;
		margin: 85px;
    	display: inline-block;
	}
	.side-menu2 {
		position : absolute;
		width : 600px;
		margin: 85px;
    	display: inline-block;
	}
	.panel {
		margin: -123px -70px;
   		text-align : center;
	}
	.panel-border {
		border: 1px solid #bdbdbd;
	}
	.box {
		margin-top: 30px;
		margin-bottom: 30px;
	}
	.container-fluid {
      padding-top : 50px;
      padding-bottom : 120px;
  	}
	.bg-container-fluid {
      padding-top : 100px;
      padding-bottom : 143px;
  	}
  	.container-frame {
  		margin : 10px 80px;
  	}
  	.navbar {
  		margin-bottom : 0px;
  		height : 56px;
  	}
  	.navbar-img {
  		width : 145px;
  		margin : -7px;
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
  	.check-info{
		height: 27px;
		margin-top: 6px;
	}
	div.nav-bd{
  		border-color: #e7e7e7;
  	}
</style>
<script>
	function checkUserName(){
		var str_len, c, i;
		var user_name = $("#user_name").val();
	
	    for(str_len=i=0;c=user_name.charCodeAt(i++);str_len+=c>>11?2:c>>7?2:1);
	
		if(user_name == ""){
			$("#check_name").text("이름을 입력해주세요");
			$("#check_name").css("color", "red");
			return false;
		}
		else if(str_len>50){
			$("#check_name").text("이름이 너무 깁니다 50자 이하로 적어주세요");
			$("#check_name").css("color", "red");
			return false;
		}
		else{
			var reg_name = /^[a-z|A-Z|가-힣][a-z|A-Z|가-힣| ]*[a-z|A-Z|가-힣]$/;
	  		if(user_name.search(reg_name) == -1){
	  			$("#check_name").text("올바른 이름을 입력해주세요");
	  			$("#check_name").css("color", "red");
	  			return false;
	  		}
	  		else{
	  			$("#check_name").text("올바른 이름입니다");
	  			$("#check_name").css("color", "green");
	  		}
	  	}
	
		return true;
	}
	
	function checkUserMail(callback){
		var user_mail = $("#user_mail").val();
		var reg_mail = /^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{2,5}$/;
/* 		if(user_mail == ""){
			$("#check_mail").text("이메일을 입력하세요.");
			$("#check_mail").css("color", "red");
			return false;
		} else if(user_mail.length > 50){
			$("#check_mail").text("아이디가 너무 깁니다.");
			$("#check_mail").css("color", "red");
			return false;
		} else if(user_mail.search(reg_mail) == -1){
			$("#check_mail").text("이메일 형식이 올바르지 않습니다.");
			$("#check_mail").css("color", "red");
			return false;
		} else{ */
			var param = {
				user_mail : user_mail
			};
			$.ajax({
				url : "<%=CheckMail_path%>",
				type : "post",
				dataType : "text",
				data : param,
				success : function(data){
					var result = false;
/* 					if(data == 1){
						$("#check_mail").text("중복된 이메일이 존재합니다");
			  			$("#check_mail").css("color", "red");
					} else if(data == 2){
						$("#check_mail").text("사용가능한 이메일입니다");
			  			$("#check_mail").css("color", "green");
						result =  true;
					} */
					if(typeof callback === 'function'){
						callback(result);
					}
				}
			});
		/* } */
	}
	
	function checkUserPw(){
		var user_pw = $("#user_pw").val();
		
		if(user_pw == ""){
			$("#check_pw").text("비밀번호를 입력해주세요");
  			$("#check_pw").css("color", "red");
			return false;
		} else if(user_pw.length < 6){
			$("#check_pw").text("비밀번호의 길이를 6자 이상으로 적어주세요");
  			$("#check_pw").css("color", "red");
			return false;
		} else if(user_pw.length > 100){
			$("#check_pw").text("비밀번호의 길이를 100자 이하로 적어주세요");
  			$("#check_pw").css("color", "red");
			return false;
		}
		$("#check_pw").text("적합합니다.");
		$("#check_pw").css("color", "green");
		return true;
	}
	
	function checkUserPw2(){
		var user_pw = $("#user_pw").val();
		var user_pw2 = $("#user_pw2").val();
		
		if(user_pw2 == ""){
			$("#check_pw2").text("비밀번호 확인을 입력해주세요");
  			$("#check_pw2").css("color", "red");
			return false;
		} else if(user_pw != user_pw2){
			$("#check_pw2").text("비밀번호가 다릅니다");
  			$("#check_pw2").css("color", "red");			
			return false;
		}
		$("#check_pw2").text("비밀번호가 일치합니다.");
		$("#check_pw2").css("color", "green");
		return true;
	}
	
	function checkUserInfo(user_form){
		var ck_pw = checkUserPw();
		var ck_pw2 = checkUserPw2();
		var ck_name = checkUserName();
		
		$("#user_name").focus();

		if(ck_name==true && ck_pw2==true && ck_pw==true){
			user_form.submit();
		}
		else if(!ck_name) $("#user_name").focus();
		else if(!ck_pw) $("#user_pw").focus();
		else if(!ck_pw2) $("#user_pw2").focus();
	}
	
	var check_img = false;
	
	$(function(){
 		$("#user_pic").change(function(event){
 			var extension = $("#user_pic").val();
 			extension = extension.slice(extension.indexOf(".") + 1).toLowerCase();
 			if($("#user_pic").val() == ""){
 				check_img = false;
 				alert("사진을 올려주세요.");
 				event.preventDefault();
 			}
 			else if(extension!="jpg" && extension!="png" && extension!="gif" && extension!="jpeg"){
 				check_img = false;
 				alert("jpg, jpeg, gif, png형식의 이미지 파일을 올려주세요.");
 				event.preventDefault();
 			}
 			else{
 				check_img = true;
 			}
		}); 
	})
	
	function check_submit(){
		if(check_img == true){
			return true;
		} else{
			return false;
		}
	}

</script>
</head>
<body class="body">
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
					<a href="<%=index_path%>">
						<img class="img navbar-img" src="../img/shagrey.png" width="90px">
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
								<%=user_name%><span class="glyphicon glyphicon-chevron-down"></span>
							</a>
							<ul class="dropdown-menu">
								<li><a href="<%=logout_path%>">로그아웃</a></li>
							</ul>
						</span>	
					</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="container-fluid" style = "height : 700px">
		<div class="container-frame">
			<aside class="side-menu1">
				<div class="panel panel-border panel-default">
					<div class='panel-heading'>
						<div><img class="img profile-image" width="102px" src="<%=path%>/upload/<%=user_img%>" /></div>
						<p><%=user_name%></p>
						<a href='<%=logout_path%>'><span class="glyphicon glyphicon-log-out"></span>
							로그아웃
						</a>
					</div>
					<div class='panel-body'>
						<!-- 메뉴 활성화시 class에 active 사용 -->
						<nav class='nav-menu clear-wrap'>
							<ul class="nav nav-pills nav-stacked">
								<li>
								<a href="<%=mypage%>">내가 쓴글 정보</a>
								</li>
							</ul>
						</nav>
					</div>
					<div class='panel-body'>
						<nav class='nav-menu clear-wrap'>
							<ul class="nav nav-pills nav-stacked">
								<li class="active"><a href="mypage_userinfo_modify.jsp">회원정보 수정</a></li>
							</ul>
						</nav>
					</div>
				</div>
			</aside>
			<div class="side-menu2">
				<div class='panel panel-border'>
					<div class="row box">
						<div class="col-sm-1"></div>
						<div class="col-sm-10">
							<c:url var="path" value="/userinfo_pic_modify.do"/>	
							<form class="form-horizontal" 
								  action="${path}" method="post" role="form"
								  enctype="multipart/form-data" onsubmit = "return check_submit();">
								<img class="img-circle img-responsive" width="100" 
									 height="50" src="<%=path%>/upload/<%=user_img%>"/><br/>
								<div class="form-group">
							   		<label class="control-label" for="user_pic"></label>
									<div class="col-sm-5 check-info">
								   		<input type='file' name="user_pic" id="user_pic" class="form-control"
								   	           accept="image/*"value="<%=user_img%>" />
									</div>
									<input type="submit" id="user_pic" value="프로필사진 수정"/>
								</div>
							</form>
							<c:url var="path" value="/userinfo_modify.do"/>	
							<form id="user_id" class="form-horizontal" name="user_form" 
								  action="${path}" method="post" role="form">	
								<div class="form-group">
									<div class="col-sm-12 check-info"></div>
									<label class="control-label col-sm-3" for="user_name">이   름( * ) : </label>
									<div class="col-sm-9">
										<input type="text" class="form-control" id="user_name" name="user_name" autocomplete="off" onblur="checkUserName()" value="<%=user_name%>"/>
									</div>
									<div class="col-sm-12 check-info" id="check_name"></div>
								</div>
								<div class="form-group">
									<label class="control-label col-sm-3" for="user_email">이메일 주소( * ) : </label>
									<div class="col-sm-9">
										<input type="email" class="form-control" id="user_mail" autocomplete="off" value="<%=user_mail%>" readonly/>
									</div>
									<div class="col-sm-12 check-info" id="check_mail"></div>
								</div>
								<div class="form-group">
									<label class="control-label col-sm-3" for="user_pw">비밀번호( * ) : </label>
									<div class="col-sm-9">
										<input type="password" class="form-control" id="user_pw" name="user_pw" autocomplete="off" onblur="checkUserPw()"/>
									</div>
									<div class="col-sm-12 check-info" id="check_pw"></div>
								</div>
								<div class="form-group">
									<label class="control-label col-sm-3" for="user_pw">비밀번호 확인( * ) : </label>
									<div class="col-sm-9">
										<input type="password" class="form-control" id="user_pw2" autocomplete="off"
											   onblur="checkUserPw2()"/>
									</div>
									<div class="col-sm-12 check-info" id="check_pw2"></div>
								</div>
								<button type="button" class="btn btn-success" onclick="checkUserInfo(user_form)">정보수정 확인</button>
							<!-- </table> -->
							</form>
							<a href="mypage_userout.jsp">계정탈퇴</a>
						</div>
						<div class="col-sm-1"></div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Footer -->
	<footer class="bg-container-fluid bg text-center">
	  <p>Copyright by YongJao Lei, Made By Team 0552</p> 
	</footer>
</body>
</html>