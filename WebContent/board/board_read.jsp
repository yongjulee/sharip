<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="bean.*" %>
<%@ page import="java.util.ArrayList" %>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.addHeader("Cache-Control", "no-store");
	response.setDateHeader("Expires", 1L);
	
	String path = request.getContextPath();
	String img_path = request.getContextPath() + "/img/";
	BoardBean board_bean = (BoardBean)request.getAttribute("board_bean");
	int board_idx = Integer.parseInt(request.getParameter("board_idx"));
	String user_img = (String)session.getAttribute("user_pic");
	String user_name = (String)session.getAttribute("user_name");
	
	boolean is_login = false;
	String user_mail = (String)session.getAttribute("user_mail");
	if(user_mail != null) is_login = true;
	
	ArrayList<ReplyBean> reply_list = (ArrayList<ReplyBean>)request.getAttribute("reply_list");
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
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title></title>

    <!-- Bootstrap Core CSS - Uses Bootswatch Flatly Theme: http://bootswatch.com/flatly/ -->
   

    <!-- Custom CSS -->
    <link href="css/freelancer.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="http://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href="http://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">
	<link href="<%=path%>/css/style.css" rel="stylesheet" type="text/css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>	
	<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&region=KR"></script>
	<script src="<%=path%>/js/functions.js"></script>
</head>

<style>
	.carousel-control.left {
	    background-image: linear-gradient(to right,rgba(0,0,0,0) 0,rgba(0,0,0,0) 100%);
	    background-repeat: repeat-x;
	}
	.carousel-control.right {
	    background-image: linear-gradient(to right,rgba(0,0,0,0) 0,rgba(0,0,0,0) 100%);
	    background-repeat: repeat-x;
	}
	div.reply{
		padding-bottom: 50px;
	}
	img.reply-img{
		height: 50px;
		width: 50px;
		border: 1px solid #DDDDDD;
	}
	div.r-ele{
		display: inline-block;
		padding: 0px 5px 0px 5px;
	}
	textarea.rp-contents{
		resize: none;
		height: 30px;
		min-width: 500px;
	}
	div.r-ctns-sec{
		width: 500px;
		word-break: break-word;
		background-color: #F1F1F1;
		padding: 5px;
	}
	li.np{
		margin-top: 10px;
	}
	
	pre{
		background-color:rgba(245,245,245,0);
		border: 0px;
	}


</style>

<script>

	var user_mail = "<%=user_mail%>";
	var infowindow;
	var marker;
	$(function(){
		initMap();
		initLocation();
		
		var reply_param = new Array();
		<%
		int num = 0;
		for(ReplyBean reply_bean : reply_list){%>
		reply_param[<%=num++%>] = {
			idx: "<%=reply_bean.getReply_idx()%>", 
			user_mail: "<%=reply_bean.getUser_mail()%>",
			user_name: "<%=reply_bean.getUser_name()%>",
			user_img: "<%=reply_bean.getUser_pic()%>",
			contents: "<%=reply_bean.getReply_content()%>",
			date: "<%=reply_bean.getReply_date()%>"
		};
		<%}%>
		appendReply(reply_param);
		
		var shift_down = false;
		$("#reply_contents").on('keydown', function(event){
			var kCode = event.keyCode;
			if(kCode == 16){
				shift_down = true;
			}
		});
		
		$("#reply_contents").on('keyup', function(event){
			var kCode = event.keyCode;
			if(kCode == 16){
				shift_down = false;
			}
		});
		
		
		$("#reply_contents").on('keyup', function(event){
			var kCode = event.keyCode;
			if(event.keyCode == 13 && shift_down == false){
				insert_reply();
			}
		});
	});
	function initLocation(){
		if(marker) marker.setMap(null);
		var lat = "<%=board_bean.getBoard_lat()%>";
		var lng = "<%=board_bean.getBoard_lng()%>";
		var loc = "<%=board_bean.getBoard_loc()%>";
		if(lat && lng && loc){
			latLng = new google.maps.LatLng(lat, lng);
			marker = new google.maps.Marker({
				map: map,
				draggable: false,
				position: latLng
			});
			map.panTo(latLng);
			
			infowindow.setContent('<div>' + loc + '</div>');
		    infowindow.open(map, marker);
		}
		
		marker.addListener('click', function(){
			infowindow.open(map, marker);
		});
	}
	
	function initMap() {
	    map = new google.maps.Map(document.getElementById('map'), {
	      center: new google.maps.LatLng(36.5, 128),
	      zoom: 6
	    });

	    infowindow = new google.maps.InfoWindow();
	    marker = new google.maps.Marker({
	      map: map,
	      anchorPoint: new google.maps.Point(0, -29)
	    });
	  }
	
	
	function insert_reply(){
		var cnts = $("#reply_contents").val();
		var param = {
			contents: cnts,
			board_idx: "<%=board_idx%>"
		};
		
		$.ajax({
			url : "insert_reply.do",
			type : "post",
			dataType : "text",
			data : param,
			success : function(reply_idx){
				var reply_param = new Array();
				reply_param[0] = {
					idx: reply_idx.trim(),
					user_mail: "<%=user_mail%>",
					user_name: "<%=user_name%>",
					user_img: "<%=user_img%>",
					contents: cnts,
					date: ""
				};
				appendReply(reply_param);
				$("#reply_contents").val("");
			}
		});
	}
	
	
	function appendReply(params){
		console.log(params.length);
		for(var i=0; i<params.length; i++){
			var tags = "<li id='rp" + params[i].idx + "' class='np'>"
							+"<div class='r-ele'>"
								+"<img class='reply-img' src='<%=path%>/upload/" + params[i].user_img + "'>"
							+"</div>"
							+"<div class='r-ele'>"
								+"<span class='reply-name'>" + params[i].user_name + "</span>"
							+"</div>"
							+"<div class='r-ele r-ctns-sec'>"
								+"<span>" + convertTagString(params[i].contents).replace(/\+/g, ' ') + "</span>"
							+"</div>";
			if(user_mail == params[i].user_mail){
				tags += "<div class='r-ele'>"
							+"<a href='#' onclick='deleteReply(" + params[i].idx + "); return false;'>댓글 삭제</a>"
						+"</div>"
			}
			tags += "</li>"
			
			$("#new_reply").append(tags);
		}
	}
	
	function deleteReply(idx){
		var param = {
			user_mail: "<%=user_mail%>",
			reply_idx: idx
		};
		
		$.ajax({
			url : "delete_reply.do",
			type : "post",
			dataType : "text",
			data : param,
			success : function(){
				removeReply(idx);
			}
		});
	}
	
	function removeReply(idx){
		$("#rp" + idx).remove();
	}
	
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
					<a href="<%=path%>/join_sharip.do">회원가입</a>
				</div>
			</div>
		</div>
	</div>


<!-- READ  -->	
<!-- 1. 제목 ------------------------------------------------------------>
<div class= "container" style="text-align: center; margin-top: 70px;">
	<h2 id='board_title'>${requestScope.board_bean.board_title}</h2>
	<p id='board_date' style="color:rgb(192,192,192);"> ${requestScope.board_bean.user_name} | ${requestScope.board_bean.user_mail} | ${requestScope.board_bean.board_date}</p>
	<hr class="star-primary-left" width="800">
 </div>

<!-- 2. 내용 ------------------------------------------------------------> 



<!-- 1)사진 -->
 <div class="col-lg-8 col-lg-offset-2">
	<div class="container" style="width:600px;height:400px;margin-top:30px;">
                           
<div id="myCarousel" class="carousel slide" data-interval="3000" data-ride="carousel">
<!-- this DIV use for carousel indicators for slider-->
<ol class="carousel-indicators">
<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
<li data-target="#myCarousel" data-slide-to="1"></li>
<li data-target="#myCarousel" data-slide-to="2"></li> 
<%
	String img4 = board_bean.getBoard_img4();
	System.out.println("4번이미지 : "+img4);
	if(img4 != null){ 
		%>
		<li data-target="#myCarousel" data-slide-to="3"></li> 
<% }
	%>
	
<%
	String img5 = board_bean.getBoard_img5();
	if(img5 != null){ 
		%>
		<li data-target="#myCarousel" data-slide-to="4"></li> 
<% }
	%>

<%
	String img6 = board_bean.getBoard_img6();
	if(img6 != null){ 
		%>
		<li data-target="#myCarousel" data-slide-to="5"></li> 
<% }
	%>
	<%
	String img7 = board_bean.getBoard_img7();
	if(img7 != null){ 
		%>
		<li data-target="#myCarousel" data-slide-to="6"></li> 
<% }
	%>
	<%
	String img8 = board_bean.getBoard_img8();
	if(img8 != null){ 
		%>
		<li data-target="#myCarousel" data-slide-to="7"></li> 
<% }
	%>
	<%
	String img9 = board_bean.getBoard_img9();
	if(img9 != null){ 
		%>
		<li data-target="#myCarousel" data-slide-to="8"></li> 
<% }
	%>
	<%
	String img10 = board_bean.getBoard_img10();
	if(img10 != null){ 
		%>
		<li data-target="#myCarousel" data-slide-to="9"></li> 
<% }
	%>
</ol>
<!--Wrapper for carousel items which are show in output form-->

<div class="carousel-inner" style="align-content: center;">

<!--this is first slider page-->
<div class="active item" >
<img src="<%=path%>/upload/${board_bean.board_img1}" style="width:600px;height:400px;" />
</div>

<!-- this is second slider page-->
<div class="item">
<img src="<%=path%>/upload/${board_bean.board_img2}" style="width:600px;height:400px;"/>
</div>

<!-- this is third slider page-->
<div class="item">
<img src="<%=path%>/upload/${board_bean.board_img3}" style="width:600px;height:400px;"/>
</div>


<!-- this is 4 slider page------------------------------------------------>

<% if(img4 != null){ %>
		<div class="item">
		<img src="<%=path%>/upload/${board_bean.board_img4}" style="width:600px;height:400px;"/>
		</div>
<% }%>

<%
	if(img5 != null){ 
		%>
		<div class="item">
		<img src="<%=path%>/upload/${board_bean.board_img5}" style="width:600px;height:400px;"/>
		</div>
		
<% }
	%>

<%
	if(img6 != null){ 
		%>
		<div class="item">
		<img src="<%=path%>/upload/${board_bean.board_img6}" style="width:600px;height:400px;"/>
		</div>
		
<% }
	%>

<%
	if(img7 != null){ 
		%>
		<div class="item">
		<img src="<%=path%>/upload/${board_bean.board_img7}" style="width:600px;height:400px;"/>
		</div>
		
<% }
	%>

<%
	if(img8 != null){ 
		%>
		<div class="item">
		<img src="<%=path%>/upload/${board_bean.board_img8}" style="width:600px;height:400px;"/>
		</div>
		
<% }
	%>

<%
	if(img9 != null){ 
		%>
		<div class="item">
		<img src="<%=path%>/upload/${board_bean.board_img9}" style="width:600px;height:400px;"/>
		</div>
		
<% }
	%>

<%
	if(img10 != null){ 
		%>
		<div class="item">
		<img src="<%=path%>/upload/${board_bean.board_img10}" style="width:600px;height:400px;"/>
		</div>
		
<% }
	%>
</div>

<!-- this is carousel controls for used of next and previous pages slider-->
<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
<span class="sr-only">Previous</span>
</a>
<a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
<span class="sr-only">Next</span>
</a>
</div>
</div>

<!-- 2)내용 -->

<hr class="star-primary-left" width="800" style="margin-top:50px;">
 <h3 style="margin-left:20px;">Content</h3>
 
<div class="text-wrap" id="content" >
<div class="container"  style="margin-top:50px; margin-bottom:50px; margin-left:20px; width:800px"> 


<pre>
${requestScope.board_bean.board_content}
</pre>

</div>
</div>
<!-- 3)지도 -->

  <hr class="star-primary-left" width="800" >
  <div style="margin-top:30px;">
  <h3 style="margin-left:20px; margin-bottom:3px;">Map</h3>

<div id="map" style="width:560px;height:250px; margin-bottom:50px;  margin-left:120px;text-align: center;">
	<!-- 지도 넣는 곳 -->
</div>

</div>
<!-- 4)팁 -->
    <hr class="star-primary-left" width="800">
	<h3>Tips</h3>

	<div class="row" style="margin-top:10px; margin-left:10px">
		<div class="col-sm-3">
			<img class="img" src="<%=img_path%>tip_air.gif" style="width:30px; height:30px; margin-left:80px;margin-right:5px;">Tip항공
	
		</div>
		<div class="col-sm-9">
		<p>
		${requestScope.board_bean.board_air}
		</p>
		</div>
		
	</div>
	
	<div class="row" style="margin-top:10px; margin-left:10px">
		<div class="col-sm-3">
			<img class="img" src="<%=img_path%>tip_dom.png" style="width:30px; height:30px; margin-left:80px;margin-right:5px;">Tip숙소
		</div>
		<div class="col-sm-9">
		<p>
		${requestScope.board_bean.board_dom}
		</p>
		</div>
		
	</div>
	
	<div class="row" style="margin-top:10px ; margin-left:10px">
		<div class="col-sm-3">
				<img class="img" src="<%=img_path%>tip_bag.png" style="width:30px; height:30px; margin-left:80px;margin-right:5px;">Tip필수품
		</div>
		<div class="col-sm-9">
		<p>
			${requestScope.board_bean.board_bag}
		</p>
		</div>
	</div>	
		<div class="row" style="margin-top:10px; margin-left:10px">
		<div class="col-sm-3">
				<img class="img" src="<%=img_path%>tip_att.png" style="width:30px; height:30px; margin-left:80px;margin-right:5px;">Tip주의
		</div>
		<div class="col-sm-9">
		<p>
			${requestScope.board_bean.board_att}
		</p>
		</div>
		</div>
			<div class="row" style="margin-top:10px; margin-left:10px">
		<div class="col-sm-3">
				<img class="img" src="<%=img_path%>tip_etc.png" style="width:30px; height:30px; margin-left:80px;margin-right:5px;">Tip기타
		</div>
		<div class="col-sm-9">
		<p>${requestScope.board_bean.board_etc}</p>
		</div>
		</div>
		
		<%if(is_login == true && board_bean.getUser_mail().equals(user_mail) == true){ %>
		<div style="margin: 10px; padding-left: 600px;">
			<a href="<%=path%>/rewrite1.do?board_idx=<%=board_idx%>">글 수정하기</a>
		</div>
		<%} %>

		<div id="replyc" class="reply">
		<hr class="star-primary-left" width="800" >
		<%if(is_login == true){ %>
		<div id="reply_input" class="reply-input">
			<div class="r-ele">
				<img class="reply-img" src="<%=path%>/upload/<%=user_img%>">
			</div>
			<div class="r-ele">
				<span class="reply-name"><%=user_name%></span>
			</div>
			<div class="r-ele r-ctns-sec" style="background-color: white;">
				<textarea id="reply_contents" name="reply_contents" class="rp-contents"></textarea>
			</div>
			<div class="r-ele">
				<button class="btn" onclick="insert_reply();">댓글 입력</button>
			</div>
		</div>
		<%} %>
		<div id="reply_view" class="reply-view">
			<ul id="new_reply"></ul>
		</div>
		</div>
</div>
</body>
</html>
