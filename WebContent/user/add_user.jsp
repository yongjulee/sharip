<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.addHeader("Cache-Control", "no-store");
	response.setDateHeader("Expires", 1L);
	
	String path = request.getContextPath();
%>
<% String add_user_path = request.getContextPath() + "/add_user.do";%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>0552 Sample Template</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<link href="http://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
</head>
<style>
.box {
	margin-top: 150px;
}
.signup-modal-title {
    font-size: 50px;
    line-height: 60px;
    color: #666;
    margin: 0;
    margin-bottom: 15px;
}
.signup-modal-description {
    font-size: 18px;
    line-height: 26px;
    color: #999;
    margin-bottom: 24px;
}
.signup-login-between {
    font-size: 18px;
    line-height: 26px;
    color: #999;
    margin-top: 24px;
}
.signup-or-dotted-line {
    border-bottom: 2px solid #ebebeb;
}
.signup-login {
    color: #a90315;
    font-weight: bold;
}
div.check-info{
	height: 15px;
	margin-top: 5px;
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

</style>

<script>
	var valid_color = "green";
	var invalid_color = "red";
	
	function checkUserMail(callback){
		var result_mail = false;
		var user_mail = $("#user_mail").val();
		var reg_mail = /^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{2,5}$/;

		if(user_mail == ""){
			$("#check_mail").text("이메일 주소를 입력해주세요.");
			$("#check_mail").css("color", invalid_color);
			return false;
		} else if(user_mail.length > 50){
			$("#check_mail").text("이메일 주소가 너무 깁니다.");
			$("#check_mail").css("color", invalid_color);
			return false;
		} else if(user_mail.search(reg_mail) == -1){
			$("#check_mail").text("올바르지 못한 이메일 주소입니다.");
			$("#check_mail").css("color", invalid_color);
			return false;
		} else{
			var param = {
				user_mail : user_mail
			};
			$.ajax({
				url : "CheckMail.do",
				type : "post",
				dataType : "text",
				data : param,
				success : function(data){
					if(data == 1){
						$("#check_mail").text("이미 존재하는 이메일 주소입니다.");
						$("#check_mail").css("color", invalid_color);
					} else if(data == 2){
						$("#check_mail").text("사용가능한 이메일 주소입니다.");
						$("#check_mail").css("color", valid_color);
						result_mail = true;
					}
					if(typeof callback === 'function'){
						callback(result_mail);
					}
				}
			});
		}
	}
	
	function checkUserPw(){
		var user_pw = $("#user_pw").val();
		
		if(user_pw == ""){
			$("#check_pw").text("비밀번호를 입력해주세요.");
			$("#check_pw").css("color", invalid_color);
			return false;
		} else if(user_pw.length < 6){
			$("#check_pw").text("비밀번호가 너무 짧습니다.");
			$("#check_pw").css("color", invalid_color);
			return false;
		} else if(user_pw.length > 100){
			$("#check_pw").text("비밀번호가 너무 깁니다.");
			$("#check_pw").css("color", invalid_color);
			return false;
		}
		$("#check_pw").text("적합합니다.");
		$("#check_pw").css("color", valid_color);
		return true;
	}
	
	function checkUserPw2(){
		var user_pw = $("#user_pw").val();
		var user_pw2 = $("#user_pw2").val();
		
		if(user_pw2 == ""){
			$("#check_pw2").text("비밀번호를 확인해주세요.");
			$("#check_pw2").css("color", invalid_color);
			return false;
		} else if(user_pw != user_pw2){
			$("#check_pw2").text("비밀번호가 일치하지 않습니다.");
			$("#check_pw2").css("color", invalid_color);
			return false;
		}
		$("#check_pw2").text("비밀번호가 일치합니다.");
		$("#check_pw2").css("color", valid_color);
		return true;
	}
	
	function checkUserName(){
		var str_len, c, i;
		var user_name = $("#user_name").val();
	
	    for(str_len=i=0;c=user_name.charCodeAt(i++);str_len+=c>>11?2:c>>7?2:1);
	
		if(user_name == ""){
			$("#check_name").text("이름을 입력해주세요.");
			$("#check_name").css("color", invalid_color);
			return false;
		}
		else if(str_len>50){
			$("#check_name").text("이름이 너무 깁니다.");
			$("#check_name").css("color", invalid_color);
			return false;
		}
		else{
			var reg_name = /^[a-z|A-Z|가-힣][a-z|A-Z|가-힣| ]*[a-z|A-Z|가-힣]$/;
	  		if(user_name.search(reg_name) == -1){
	  			$("#check_name").text("올바른 이름을 입력해주세요.");
	  			$("#check_name").css("color", invalid_color);
	  			return false;
	  		}
	  		else{
	  			$("#check_name").text("올바른 이름입니다.");
	  			$("#check_name").css("color", valid_color);
	  		}
	  	}
	
		return true;
	}
	
	function checkUserInfo(user_form){
		var ck_pw = checkUserPw();
		var ck_pw2 = checkUserPw2();
		var ck_name = checkUserName();

		$("#user_mail").focus();
		checkUserMail(function(ck_mail){
			if(ck_name==true && ck_pw2==true && ck_pw==true && ck_mail==true){
				user_form.submit();
			}
			else if(!ck_mail) $("#user_mail").focus();
			else if(!ck_pw) $("#user_pw").focus();
			else if(!ck_pw2) $("#user_pw2").focus();
			else if(!ck_name) $("#user_name").focus();
		});
	}
</script>

<body>
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

			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav navbar-right">
				</ul>
			</div>


		</div>
	</nav>
	<div class="container">
	<!-- 처음 -->
		<div class="box">
			<div class="col-sm-2"></div>
			<div class="col-sm-8">
						<h4 class="signup-modal-title">회원가입</h4>
						<div class="signup-modal-description">내가 가고싶은 곳, 내가 알려주고 싶은곳을 위한 커뮤니티. SHARIP</div>
						<div class="signup-or-dotted-line"></div>
						<!-- 중간 -->
					<div class="panel-body">
						<form name="user_form" class="form-horizontal" role="form" method="post" action="<%=add_user_path%>">
							<div class="form-group">
								<div class="col-sm-9">
									<input type="text" class="form-control" id="user_mail" name="user_mail" placeholder="이메일 주소" autocomplete="off" onblur="checkUserMail();"/>
								</div>
								<div class="col-sm-9 check-info" id="check_mail"></div>
							</div>
							
							<div class="form-group">
								<div class="col-sm-9">
									<input type="password" class="form-control" id="user_pw" name="user_pw" placeholder="비밀번호" onblur="checkUserPw();"/>
								</div>
								<div class="col-sm-9 check-info" id="check_pw"></div>
							</div>
							<div class="form-group">
								<div class="col-sm-9">
									<input type="password" class="form-control" id="user_pw2" name="user_pw2" placeholder="비밀번호 확인" onblur="checkUserPw2();"/>
								</div>
								<div class="col-sm-9 check-info" id="check_pw2"></div>
							</div>
							<div class="form-group">
								<div class="col-sm-9">
									<input type="text" class="form-control" id="user_name" name="user_name" placeholder="이름" autocomplete="off" onblur="checkUserName();"/>
								</div>
								<div class="col-sm-9 check-info" id="check_name"></div>
							</div>
							<input type="hidden" id="check_value" value="0"/>
							<!-- 마지막 -->
							<div style="text-align: left">
								<input type="button" class="btn btn-success" value="가입하기" onclick="checkUserInfo(user_form);"/>
							</div>
						</form>
					</div>
			</div>
			<div class="col-sm-2"></div>
		</div>
	</div>
</body>
</body>
</html>