<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.addHeader("Cache-Control", "no-store");
	response.setDateHeader("Expires", 1L);
	
	String path = request.getContextPath();
	String user_img = (String)session.getAttribute("user_pic");
	String img_path = request.getContextPath() + "/img/";
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<meta name="viewport" 
      content="width=device-width, initial-scale=1">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="<%=path%>/css/style.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script src="<%=path%>/js/functions.js"></script>

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
div.r-box{
	border: 1px solid #DDDDDD;
}
</style>
</head>
<script>

	$(function(){
		getSession(); //세션 스토리지 데이터 가져오기
		
		$("#title").val(sessionStorage.title);
		$("#continent").val(sessionStorage.continent);
		$("#travel").val(sessionStorage.travel);
		$("#content").val(sessionStorage.content);
		$("#img_src0").val(sessionStorage.img_src0);
		$("#img_src1").val(sessionStorage.img_src1);
		$("#img_src2").val(sessionStorage.img_src2);
		for(var i=3, k=3; i<10; i++){
			if(sessionStorage.getItem("img_src" + i) != null){
				$("#img_src" + k++).val(sessionStorage.getItem("img_src" + i));
			}
		}
		$("#lat").val(sessionStorage.lat);
		$("#lng").val(sessionStorage.lng);
		$("#loc").val(sessionStorage.loc);
		$("#air").val(sessionStorage.air);
		$("#dom").val(sessionStorage.dom);
		$("#bag").val(sessionStorage.bag);
		$("#att").val(sessionStorage.att);
		$("#etc").val(sessionStorage.etc);
	})


	function save4(){
		var str_len, c, i;

		var board_air = $("#board_air").val();
		for(str_len=i=0;c=board_air.charCodeAt(i++);str_len+=c>>11?2:c>>7?2:1);
		if(str_len>200){
			alert("행공tip이 너무 깁니다.");
			$("#board_air").focus();
		} else if($("#board_air").val() == ""){
			sessionStorage.removeItem("air");
		} else if($("#board_air").val().checkOnlySpace() == false){
			//세션 스토리지에 저장
			window.sessionStorage.air = $("#board_air").val();
		}
		
		var board_dom = $("#board_dom").val();
		for(str_len=i=0;c=board_dom.charCodeAt(i++);str_len+=c>>11?2:c>>7?2:1);
		if(str_len>200){
			alert("숙소tip이 너무 깁니다.");
			$("#board_dom").focus();
		} else if($("#board_dom").val() == ""){
			sessionStorage.removeItem("dom");
		} else if($("#board_dom").val().checkOnlySpace() == false){
			//세션 스토리지에 저장
			window.sessionStorage.dom = $("#board_dom").val();
		}
		
		var board_bag = $("#board_bag").val();
		for(str_len=i=0;c=board_bag.charCodeAt(i++);str_len+=c>>11?2:c>>7?2:1);
		if(str_len>200){
			alert("필수품tip이 너무 깁니다.");
			$("#board_bag").focus();
		} else if($("#board_bag").val() == ""){
			sessionStorage.removeItem("bag");
		} else if($("#board_bag").val().checkOnlySpace() == false){
			//세션 스토리지에 저장
			window.sessionStorage.bag = $("#board_bag").val();
		}

		var board_att = $("#board_att").val();
		for(str_len=i=0;c=board_att.charCodeAt(i++);str_len+=c>>11?2:c>>7?2:1);
		if(str_len>200){
			alert("필수품tip이 너무 깁니다.");
			$("#board_att").focus();
		} else if($("#board_att").val() == ""){
			sessionStorage.removeItem("att");
		} else if($("#board_att").val().checkOnlySpace() == false){
			//세션 스토리지에 저장
			window.sessionStorage.att = $("#board_att").val();
		}
		
		var board_etc = $("#board_etc").val();
		for(str_len=i=0;c=board_etc.charCodeAt(i++);str_len+=c>>11?2:c>>7?2:1);
		if(str_len>200){
			alert("필수품tip이 너무 깁니다.");
			$("#board_etc").focus();
		} else if($("#board_etc").val() == ""){
			sessionStorage.removeItem("etc");
		} else if($("#board_etc").val().checkOnlySpace() == false){
			//세션 스토리지에 저장
			window.sessionStorage.etc = $("#board_etc").val();
		}
	}
	
	function getSession(){
		$("#board_air").val(window.sessionStorage.air);
		$("#board_dom").val(window.sessionStorage.dom);
		$("#board_bag").val(window.sessionStorage.bag);
		$("#board_att").val(window.sessionStorage.att);
		$("#board_etc").val(window.sessionStorage.etc);
	}
	
	function checkValues(){
		save4();
		
		if($("#title").val() == ""){
			alert("여행 제목 필요");
			return false;
		} else if($("#continent").val() == ""){
			alert("대륙 선택 요망");
			return false;
		} else if($("#travel").val() == ""){
			alert("여행 목적 선택 요망");
			return false;
		} else if($("#content").val() == ""){
			alert("여행 내용 필요");
			return false;
		} else if($("#img_src0").val() == ""){
			alert("여행 사진 최소 3개 필요");
			return false;
		} else if($("#img_src1").val() == ""){
			alert("여행 사진 최소 3개 필요");
			return false;
		} else if($("#img_src2").val() == ""){
			alert("여행 사진 최소 3개 필요");
			return false;
		} else if($("#lat").val() == ""){
			alert("여행 위치 필요");
			return false;
		} else if($("#lng").val() == ""){
			alert("여행 위치 필요");
			return false;
		} else if($("#loc").val() == ""){
			alert("여행 위치 필요");
			return false;
		}
		sessionStorage.removeItem("title");
		sessionStorage.removeItem("continent");
		sessionStorage.removeItem("travel");
		sessionStorage.removeItem("content");
		sessionStorage.removeItem("img_num");
		sessionStorage.removeItem("img_src0");
		sessionStorage.removeItem("img_src1");
		sessionStorage.removeItem("img_src2");
		sessionStorage.removeItem("img_src3");
		sessionStorage.removeItem("img_src4");
		sessionStorage.removeItem("img_src5");
		sessionStorage.removeItem("img_src6");
		sessionStorage.removeItem("img_src7");
		sessionStorage.removeItem("img_src8");
		sessionStorage.removeItem("img_src9");
		sessionStorage.removeItem("lat");
		sessionStorage.removeItem("lng");
		sessionStorage.removeItem("loc");
		sessionStorage.removeItem("air");
		sessionStorage.removeItem("dom");
		sessionStorage.removeItem("bag");
		sessionStorage.removeItem("att");
		sessionStorage.removeItem("etc");
		return true;
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
						<h4 class="signup-modal-title">여행 <span style="color: #38a3dc;">일지</span> 작성</h4>
						<div class="signup-modal-description">내가 알려주고 싶은 나만의 여행지를 소개해 주세요. SHARIP</div>
						<div class="signup-or-dotted-line"></div>
						<!-- 중간 -->
					<div class="panel-body">
						<form action="<%=path%>/board_write.do" method="POST" onsubmit="return checkValues();">
							<div class="form-group">
								<div class="col-sm-11">
									<img class="img" src="<%=img_path%>tip_icon1.png"width="30px" height="30px" ondragstart="return false">항공	Tip
									<input type="text" class="form-control" id="board_air" name="board_air" placeholder="나만의 항공 팁을 작성해주세요" autocomplete="off"/>
						
									<img class="img" src="<%=img_path%>tip_icon2.png" width="30px"height="30px" ondragstart="return false">숙소 Tip
									<input type="text" class="form-control" id="board_dom" name="board_dom" placeholder="나만의 숙소 팁을 작성해주세요" autocomplete="off"/>
								
									<img class="img" src="<%=img_path%>tip_icon3.png" width="30px" height="30px" ondragstart="return false">필수품 Tip	
									<input type="text" class="form-control" id="board_bag" name="board_bag" placeholder="나만의 필수품 팁을 작성해주세요" autocomplete="off"/>
									
									<img class="img" src="<%=img_path%>tip_icon4.png" width="30px" height="30px" ondragstart="return false">주의사항 Tip	
									<input type="text" class="form-control" id="board_att" name="board_att" placeholder="여행시 주의사항을 작성해주세요" autocomplete="off"/>
									
									<img class="img" src="<%=img_path%>tip_icon5.png" width="30px" height="30px" ondragstart="return false">기타 Tip	
									<input type="text" class="form-control" id="board_etc" name="board_etc" placeholder=" 기타 팁을 작성해주세요" autocomplete="off"/>
								</div>
							</div>
							<input id="title" name="title" type="hidden"/>
							<input id="continent" name="continent" type="hidden"/>
							<input id="travel" name="travel" type="hidden"/>
							<input id="content" name="content" type="hidden"/>
							<input id="img_src0" name="img_src" type="hidden"/>
							<input id="img_src1" name="img_src" type="hidden"/>
							<input id="img_src2" name="img_src" type="hidden"/>
							<input id="img_src3" name="img_src" type="hidden"/>
							<input id="img_src4" name="img_src" type="hidden"/>
							<input id="img_src5" name="img_src" type="hidden"/>
							<input id="img_src6" name="img_src" type="hidden"/>
							<input id="img_src7" name="img_src" type="hidden"/>
							<input id="img_src8" name="img_src" type="hidden"/>
							<input id="img_src9" name="img_src" type="hidden"/>
							<input id="lat" name="lat" type="hidden"/>
							<input id="lng" name="lng" type="hidden"/>
							<input id="loc" name="loc" type="hidden"/>
							
							<button type="submit" class="btn btn-primary" style="margin-left: 15px; margin-top: 20px;">
								<img src="<%=path%>/img/upload_icon.png"/>    게시글 등록
							</button>
						</form>
					</div>
			</div>
			<div class="col-sm-1"></div>
			<div class="col-sm-3">
				<div>
					<div class="bound" style="padding: 20px;">
						<ul>
							<li>
								<h4><a href="<%=path%>/write1.do" onclick="save4();">여행 기본 정보</a></h4>
							</li>
							<li>
								<h4><a href="<%=path%>/write2.do" onclick="save4();">여행 사진</a></h4>
							</li>
							<li>
								<h4><a href="<%=path%>/write3.do" onclick="save4();">여행 장소</a></h4>
							</li>
							<li>
								<h4>여행 팁</h4>
							</li>
						</ul>
					</div>
					<div class="bound" style="margin-top: 20px; padding: 20px;">
						<img src="<%=path%>/img/answer_icon.png"/> 여행 팁
						<br/><br/>
						- 항공사, 가격, 환승 등의 유용한 정보를 작성해 주세요.<br/><br/>
						- 좋은 사람들, 좋은 위치, 아름다운 숙소 등의 정보를 작성해 주세요.<br/><br/>
						- 이것만은 꼭 가져가야 하는 중요한 필수품목을 작성해 주세요.<br/><br/>
						- 여행시 주의사항에 대해서 작성해 주세요.<br/><br/>
						- 기타, 알려주고 싶은 정보들에 대해서 작성해 주세요.
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>