<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.addHeader("Cache-Control", "no-store");
	response.setDateHeader("Expires", 1L);

	String path = request.getContextPath();
	String user_img = (String)session.getAttribute("user_pic");
	String image_path = request.getContextPath() + "/upload";
	String image_pro_path = request.getContextPath() + "/image_pro.do";
	String js_path = request.getContextPath() + "/js/jquery.form.min.js";
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
<script src="<%=js_path%>"></script>
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
li.img-up{
	width: 340px;
	border: 1px solid #DDDDDD;
	padding: 20px;
	margin-bottom: 20px;
}
div.img-up{
	
	
}
div.img-op{

}
div.img-op-name{
	margin: 10px;
}
img.board-img{
	background-color: #DDDDDD;
	width: 300px;
	height: 300px;
	border: 1px solid #D9D9D9;
}

</style>
</head>

<script>
	var tag_num;
	$(function(){
		var img_num = sessionStorage.img_num;
		if(!img_num){
			addImageTag(true);
			sessionStorage.img_num = 1;
		} else{
			for(var i=0; i<img_num; i++){
				addImageTag(true);
				var img_name = window.sessionStorage.getItem("img_src"+i);
				if(img_name) $(".board-img").eq(i).attr("src", "<%=image_path%>/"+img_name);
			}
		}
		

		var option = {
			type: "POST",
			url: "<%=image_pro_path%>",
			success: function(data){
				data = data.trim();
				$("form").eq(tag_num).children().children().attr("src", "<%=image_path%>/"+data);
				window.sessionStorage.setItem("img_src"+tag_num, data);
			}	
		};
		$(this).ajaxForm(option);
	})
	

	function submitImage(img_tag){
		var extension = img_tag.value;
		extension = extension.slice(extension.indexOf(".") + 1).toLowerCase();
		if(!extension){
			alert("사진을 올려주세요.");
			event.preventDefault();
		} else if(extension!="jpg" && extension!="png" && extension!="gif" && extension!="jpeg"){
			alert("jpg, jpeg, gif, png형식의 이미지 파일을 올려주세요.");
			event.preventDefault();
		} else{
			$("form").each(function(form_idx){
				if(img_tag.parentNode.parentNode.parentNode == $(this).context){
					tag_num = form_idx;
					$(this).submit();
				}
			})
		}
	}
	
	function addImageTag(reload){
		var img_num = parseInt(sessionStorage.img_num);

		if(img_num > 9 && reload != true){
			alert("사진 최대 개수는 10개");
			return false;
		}
		if(reload != true) sessionStorage.img_num = img_num + 1;
		var tags = "<li class='img-up'><form><div class='img-up'><img class='board-img'/></div>"
			+ "<div class='img-op'><div class='img-op-name'>"
			+ "<input id='img_file' name='img_file' type='file' value='사진 올리기' onchange='submitImage(this);'/>"
			+ "</div><div class='img-op-name'>"
			+ "<button type='button' class='btn btn-danger' onclick='removeImageTag(this);'>DELETE</button>"
			+ "</div></div></form></li>";

		$("#ul_bound").children().last().before(tags);
	}
	
	function removeImageTag(cur_tag){
		window.sessionStorage.img_num = window.sessionStorage.img_num - 1;
		$("form").each(function(idx){
			if(cur_tag.parentNode.parentNode.parentNode == $(this).context){
				$(this).parent().remove();
				var num = sessionStorage.getItem("img_num");

				for(var i=idx; i<num+1; i++){
					var temp = sessionStorage.getItem("img_src"+(i+1));
					if(temp != null){
						sessionStorage.setItem("img_src"+i, temp);
						sessionStorage.removeItem("img_src"+(i+1));
					} else{
						sessionStorage.removeItem("img_src"+i);
					}
				}
			}
		})
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
			<div class="col-sm-8 bound" style="min-width: 500px;">
						<h4 class="signup-title">여행 <span style="color: #38a3dc;">일지</span> 작성</h4>
						<div class="signup-modal-description">내가 알려주고 싶은 나만의 여행지를 소개해 주세요. SHARIP</div>
						<div class="signup-or-dotted-line"></div>
						<!-- 중간 -->
					<div class="panel-body" style="min-width: 400px;">
						<h3>사진 등록하기</h3>
						<ul id="ul_bound">
						<!-- 
							<li>
								<form>
									<div class="img-up">
										<img class="board-img"/>
									</div>
									<div class="img-op">
										<div class="img-op-name">
											<input name="img_file" type="file" value="사진 올리기" onchange="submitImage(this);"/>
										</div>
										<div class="img-op-name">
											<button class="btn btn-warning">삭제 하기</button>
										</div>
									</div>
								</form>
							</li>
						 -->
						
							<li>
								<div>
									<button class="btn btn-primary" onclick="addImageTag();">
										<img src="<%=path%>/img/button_pic_img.png"/>
									</button>
								</div>
								<div style="padding: 20px; padding-left: 0px;">
									<input type="button" class="btn btn-primary"  value="다음 단계로 넘어가기" onclick= "location.href = 'write3.do'"> 							
								</div>
							</li>
						</ul>
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
									<h4>여행 사진</h4>
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
							<img src="<%=path%>/img/answer_icon.png"/> 일지 작성 팁
							<br/><br/>
							- 내가 직접 찍은 여행 사진을 게시해 주세요.<br/><br/>
							- 최소 3장 이상의 사진을 등록해야 합니다.<br/><br/>
							- 최대 10장의 사진을 등록 하실 수 있습니다.
						</div>
					</div>
				</div>
		</div>
	</div>
</body>
</html>