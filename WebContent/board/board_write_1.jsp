<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.addHeader("Cache-Control", "no-store");
	response.setDateHeader("Expires", 1L);

	String path = request.getContextPath();
	String user_img = (String)session.getAttribute("user_pic");
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<meta name="viewport" 
      content="width=device-width, initial-scale=1">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<!-- Latest compiled JavaScript -->
<link rel="stylesheet" href="<%=path%>/css/style.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script src="<%=path%>/js/functions.js"></script>

<style>
.box {
	margin-top: 150px;
}
.signup-title {
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
.bound{
	padding: 50px;
	border: 1px solid #d0d0d0;
}
ul{
	margin: 0px;
	padding: 0px;
	list-style: none;
}
a:hover{
	text-decoration: none;
}

</style>


</head>

<script type="text/javascript">
	$(function(){
		getSession(); //세션 스토리지 데이터 가져오기
	})

function save(next){
	var str_len, c, i;
	var board_title = $("#board_title").val();
	
	for(str_len=i=0;c=board_title.charCodeAt(i++);str_len+=c>>11?2:c>>7?2:1);
	if(str_len>50){
		alert("제목이 너무 깁니다.");
		$("#board_title").focus();
	} else if($("#board_title").val().checkOnlySpace() == false){
		//세션 스토리지에 저장
		window.sessionStorage.title = $("#board_title").val();
	}	

	var continent = document.getElementById('continent')
	var continent_value = continent.value;
	if($("#continent").val() != ""){
		//세션 스토리지에 저장
		sessionStorage.setItem('continent',continent_value);
	}	
	
	var travel = document.getElementById('travel')
	var travel_value = travel.value;
	if($("#travel").val() != ""){
		//세션 스토리지에 저장
		sessionStorage.setItem('travel',travel.value);
	//	console.log($("#travel"))
	}	
	
	var board_content = document.getElementById('board_content')
	var board_content_value = board_content.value;
	
	for(str_len=i=0;c=board_content_value.charCodeAt(i++);str_len+=c>>11?2:c>>7?2:1);
	if(str_len>1000){
		alert("내용이 너무 깁니다.");
		$("#board_content").focus();
	} else if($("#board_content").val().checkOnlySpace() == false){
		//세션 스토리지에 저장
		sessionStorage.setItem('content',board_content_value);
	}
	
	if(next == true){
		location.href = "write2.do";
	}
}

function getSession(){
	$("#board_title").val(window.sessionStorage.title);
	$("#continent").val(window.sessionStorage.continent);
	$("#travel").val(window.sessionStorage.travel);
	$("#board_content").val(window.sessionStorage.content);
	
}
	
	
	




</script>

<body>
<div class="container">
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
					<li><a href="<%=path%>/my_page.do">마이페이지</a></li>
					<li><a href="<%=path%>/logout.do">로그아웃</a></li>
					<li class="pf"><img class="pf" src="<%=path%>/upload/<%=user_img%>"></li>
				</ul>
			</div>
	
		</div>
	</nav>

	<!-- 처음 -->
		<div class="box">
			<div class="col-sm-8 bound">
						<h4 class="signup-title">여행 <span style="color: #38a3dc;">일지</span> 작성</h4>
						<div class="signup-modal-description">내가 알려주고 싶은 나만의 여행지를 소개해 주세요. SHARIP</div>
						<div class="signup-or-dotted-line"></div>
						<!-- 중간 -->
					<div class="panel-body">
						<form class="form-horizontal">
							<div class="form-group">
								<div class="col-sm-8">
									<input type="text" class="form-control" id="board_title" name="board_title" placeholder="여행 제목" autocomplete="off"/>
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-4">
									<select class="form-control" id="continent">
										<option value="">대륙</option>
										<option value="asia">아시아</option>
										<option value="north america">북아메리카</option>
										<option value="south america">남아메리카</option>
										<option value="europe">유럽</option>
										<option value="oceania">오세아니아</option>
										<option value="africa">아프리카</option>
									</select>
								</div>
								<div class="col-sm-4">
									<select class="form-control" id="travel">
										<option value="">여행 목적</option>
										<option value="food">음식</option>
										<option value="culture">문화</option>
										<option value="nature">자연</option>
										<option value="shopping">쇼핑</option>
										<option value="rest">휴양</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-8">
									<textarea class="form-control" id="board_content" name="board_content" placeholder="여행 내용" style="height: 150px; resize: none;"></textarea>
								</div>
							</div>
							<input type="button" class="btn btn-primary"  value="다음 단계로 넘어가기" onclick= "save(true)"> 							
						</form>
					</div>
			</div>
			<div class="col-sm-1"></div>
				<div class="col-sm-3">
					<div>
						<div class="bound" style="padding: 20px;">
							<ul>
								<li>
									<h4>여행 기본 정보</h4>
								</li>
								<li>
									<h4><a href="<%=path%>/write2.do" onclick="save4();">여행 사진</a></h4>
								</li>
								<li>
									<h4><a href="<%=path%>/write3.do" onclick="save4();">여행 장소</a></h4>
								</li>
								<li>
									<h4><a href="<%=path%>/write4.do" onclick="save4();">여행 팁</a></h4>
								</li>
							</ul>
						</div>
						<div class="bound" style="margin-top: 20px; padding: 20px;">
							<img src="<%=path%>/img/answer_icon.png"/> 여행 팁
							<br/><br/>
							- 나만의 창의적인 제목을 작성해 주세요.<br/><br/>
							- 대륙과 여행 목적을 선택해 주세요.<br/><br/>
							- 상세한 여행 내용에 대한 설명을 최대한 자세히 적어 주세요.
						</div>
					</div>
				</div>
		</div>
	</div>
</body>
</html>