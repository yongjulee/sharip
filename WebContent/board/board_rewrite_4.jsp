<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bean.*" %>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.addHeader("Cache-Control", "no-store");
	response.setDateHeader("Expires", 1L);
	
	String path = request.getContextPath();
	String user_img = (String)session.getAttribute("user_pic");
	String img_path = request.getContextPath() + "/img/";
	
	String board_idx = request.getParameter("board_idx");
	BoardBean board_bean = (BoardBean)request.getAttribute("board_bean");
	
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
<link rel="stylesheet" href="<%=path%>/css/style.css">
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
</style>
</head>

<script>

	$(function(){
		$("#board_air").val("<%=board_bean.getBoard_air()%>");
		$("#board_dom").val("<%=board_bean.getBoard_dom()%>");
		$("#board_bag").val("<%=board_bean.getBoard_bag()%>");
		$("#board_att").val("<%=board_bean.getBoard_att()%>");
		$("#board_etc").val("<%=board_bean.getBoard_etc()%>");
	})

	function checkValues(){
		var str_len, c, i;

		var board_air = $("#board_air").val();
		for(str_len=i=0;c=board_air.charCodeAt(i++);str_len+=c>>11?2:c>>7?2:1);
		if(str_len>200){
			alert("행공tip이 너무 깁니다.");
			$("#board_air").focus();
			return false;
		} else if($("#board_air").val().checkOnlySpace() == true){
			$("#board_air").val("");
		}
		
		var board_dom = $("#board_dom").val();
		for(str_len=i=0;c=board_dom.charCodeAt(i++);str_len+=c>>11?2:c>>7?2:1);
		if(str_len>200){
			alert("숙소tip이 너무 깁니다.");
			$("#board_dom").focus();
			return false;
		} else if($("#board_dom").val().checkOnlySpace() == true){
			$("#board_dom").val("");
		}
		
		var board_bag = $("#board_bag").val();
		for(str_len=i=0;c=board_bag.charCodeAt(i++);str_len+=c>>11?2:c>>7?2:1);
		if(str_len>200){
			alert("필수품tip이 너무 깁니다.");
			$("#board_bag").focus();
			return false;
		} else if($("#board_bag").val().checkOnlySpace() == true){
			$("#board_bag").val("");
		}

		var board_att = $("#board_att").val();
		for(str_len=i=0;c=board_att.charCodeAt(i++);str_len+=c>>11?2:c>>7?2:1);
		if(str_len>200){
			alert("필수품tip이 너무 깁니다.");
			$("#board_att").focus();
			return false;
		} else if($("#board_att").val().checkOnlySpace() == true){
			$("#board_att").val("");
		}
		
		var board_etc = $("#board_etc").val();
		for(str_len=i=0;c=board_etc.charCodeAt(i++);str_len+=c>>11?2:c>>7?2:1);
		if(str_len>200){
			alert("필수품tip이 너무 깁니다.");
			$("#board_etc").focus();
			return false;
		} else if($("#board_etc").val().checkOnlySpace() == true){
			$("#board_etc").val("");
		}
		
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
						<h4 class="signup-modal-title">여행 일지 작성</h4>
						<div class="signup-modal-description">내가 알려주고 싶은 나만의 여행지를 소개해 주세요. SHARIP</div>
						<div class="signup-or-dotted-line"></div>
						<!-- 중간 -->
					<div class="panel-body">
						<form action="<%=path%>/rewrite_complete.do" method="POST" onsubmit="return checkValues();">
							<div class="form-group">
								<div class="col-sm-11">
									<img class="img" src="<%=img_path%>tip_air.gif"width="30px" height="30px" ondragstart="return false">항공	Tip
									<input type="text" class="form-control" id="board_air" name="board_air" placeholder="나만의 항공 팁을 작성해주세요" autocomplete="off"/>
						
									<img class="img" src="<%=img_path%>tip_dom.png" width="30px"height="30px" ondragstart="return false">숙소 Tip
									<input type="text" class="form-control" id="board_dom" name="board_dom" placeholder="나만의 숙소 팁을 작성해주세요" autocomplete="off"/>
								
									<img class="img" src="<%=img_path%>tip_bag.png" width="30px" height="30px" ondragstart="return false">필수품 Tip	
									<input type="text" class="form-control" id="board_bag" name="board_bag" placeholder="나만의 필수품 팁을 작성해주세요" autocomplete="off"/>
									
									<img class="img" src="<%=img_path%>tip_att.png" width="30px" height="30px" ondragstart="return false">주의사항 Tip	
									<input type="text" class="form-control" id="board_att" name="board_att" placeholder="여행시 주의사항을 작성해주세요" autocomplete="off"/>
									
									<img class="img" src="<%=img_path%>tip_etc.png" width="30px" height="30px" ondragstart="return false">기타 Tip	
									<input type="text" class="form-control" id="board_etc" name="board_etc" placeholder=" 기타 팁을 작성해주세요" autocomplete="off"/>
								</div>
							</div>
							<input type="hidden" name="page" value="4">
							<input type="hidden" name="board_idx" value="<%=board_idx%>">
							
							<input type="submit" class="btn btn-primary" value="제출하기">
						</form>
					</div>
			</div>
			<div class="col-sm-1"></div>
			<div class="col-sm-3">
				<div>
					<div class="bound" style="padding: 20px;">
						<ul>
							<li>
								<h4><a href="<%=path%>/rewrite1.do?board_idx=<%=board_idx%>" onclick="save4();">여행 기본 정보</a></h4>
							</li>
							<li>
								<h4><a href="<%=path%>/rewrite2.do?board_idx=<%=board_idx%>" onclick="save4();">여행 사진</a></h4>
							</li>
							<li>
								<h4><a href="<%=path%>/rewrite3.do?board_idx=<%=board_idx%>" onclick="save4();">여행 장소</a></h4>
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