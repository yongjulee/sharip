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
	
	String shagrey = request.getContextPath() + "/img/shagrey.png";

	String mypage_modify = request.getContextPath() + "/user/mypage_userinfo_modify.jsp";
	String mypage = request.getContextPath() + "/mypage.do";

	String user_mail = (String)session.getAttribute("user_mail");
	String user_name = (String)session.getAttribute("user_name");
	String user_img = (String)session.getAttribute("user_pic");
	String board_title = (String)session.getAttribute("board_title");
	Integer board_idx = (Integer)session.getAttribute("board_idx");
	
	String idx_str = request.getParameter("page_num");
	int idx_num = 1;
	if(idx_str != null){
		idx_num = Integer.parseInt(idx_str);
	}

	int board_num = 1;
	for(int i=1; i<idx_num; i++){
		board_num += 10;
	}
	
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
<c:url var="read_path" value="/read.do"/>
<script>
	$(function(){
		// 인디케이터에 페이지 표시 설정
		$("#page_indicator > li:nth-child(${requestScope.page_num})").addClass("active");
		// 글의 항목을 클릭했을 때 처리
		$("#board_list > tbody > tr").click(function(){
			// dataset에 설정되어 있는 글 번호를 가지고 온다.
			// 태그객체.data.이름
			var idx = $(this).data("idx");
			location.href
				= "${read_path}?board_idx=" + idx
				+ "&page_num=${requestScope.page_num}";
		});
	});
</script>
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
		margin: -63px -70px -127px;
   		text-align : center;
	}
	.panel-border {
		border: 1px solid #bdbdbd;
	}
	.box {
		margin-top: 10px;
	}
	.container-fluid {   
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
  	div.nav-bd{
  		border-color: #e7e7e7;
  	}
</style>
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
						<img class="img navbar-img" src="<%=shagrey%>" width="100px">
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
						<a href="<%=logout_path%>"><span class = "glyphicon glyphicon-log-out"></span>
							로그아웃
						</a>
					</div>
					<div class='panel-body'>
						<!-- 메뉴 활성화시 class에 active 사용 -->
						<nav class='nav-menu clear-wrap'>
							<ul class="nav nav-pills nav-stacked">
								<li class="active"><a href="<%=mypage%>">내가 쓴글 정보</a></li>
							</ul>
						</nav>
					</div>
					<div class='panel-body'>
						<nav class='nav-menu clear-wrap'>
							<ul class="nav nav-pills nav-stacked">
								<a href="<%=mypage_modify%>"> 회원정보 수정</a>
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
							<h1><%=user_name%>님 반갑습니다</h1>
							<table class="table table-hover" id="board_list">
								<thead>
									<tr>
										<th class="panel" width="20%">글번호</th>
										<th class="panel">제목</th>
										<th class="panel" width="30%">작성자</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="board_bean" items="${requestScope.board_list}">
										<tr data-idx="${board_bean.board_idx}">
											<td><%=board_num++%></td>
											<td>${board_bean.board_title}</td>
											<td><%=user_name%></td>
										</tr>	
									</c:forEach>		   	   						   	   							   	   						   	   
								</tbody>
							</table>
							<%-- 페이지 번호 --%>
							<div style="text-align:center">
								<ul class="pagination" id="page_indiator">
									<li>
										<a href="#" aria-label="Previous">
											<span aria-hidden="true">&laquo;</span>
										</a>
									</li>
									<li>
										<c:forEach var="i" begin="1" end="${requestScope.page_cnt}">
											<c:url var="path" value="/my_page.do">
												<c:param name="page_num" value="${i}"/>
											</c:url>
											<a href="${path}">${i}</a>
										</c:forEach>
									</li>
									<li>
										<a href="#" aria-label="Next">
											<span aria-hidden="true">&raquo;</span>
										</a>
									</li>
								</ul>
							</div>
						</div>
						<div class="col-sm-1"></div>
					</div>
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