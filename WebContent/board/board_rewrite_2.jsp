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
	String board_idx = request.getParameter("board_idx");
	String image_path = request.getContextPath() + "/upload";
	String image_pro_path = request.getContextPath() + "/image_pro.do";
	String js_path = request.getContextPath() + "/js/jquery.form.min.js";
	
	BoardBean board_bean = (BoardBean)request.getAttribute("board_bean");

	int img_num = 0;
	String[] img_src = new String[10];
	if(board_bean.getBoard_img1() != null){
		img_src[0] = board_bean.getBoard_img1();
		img_num++;
	}
	if(board_bean.getBoard_img2() != null){
		img_src[1] = board_bean.getBoard_img2();
		img_num++;
	}
	if(board_bean.getBoard_img3() != null){
		img_src[2] = board_bean.getBoard_img3();
		img_num++;
	}
	if(board_bean.getBoard_img4() != null){
		img_src[3] = board_bean.getBoard_img4();
		img_num++;
	}
	if(board_bean.getBoard_img5() != null){
		img_src[4] = board_bean.getBoard_img5();
		img_num++;
	}
	if(board_bean.getBoard_img6() != null){
		img_src[5] = board_bean.getBoard_img6();
		img_num++;
	}
	if(board_bean.getBoard_img7() != null){
		img_src[6] = board_bean.getBoard_img7();
		img_num++;
	}
	if(board_bean.getBoard_img8() != null){
		img_src[7] = board_bean.getBoard_img8();
		img_num++;
	}
	if(board_bean.getBoard_img9() != null){
		img_src[8] = board_bean.getBoard_img9();
		img_num++;
	}
	if(board_bean.getBoard_img10() != null){
		img_src[9] = board_bean.getBoard_img10();
		img_num++;
	}
	
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
		var img_num = <%=img_num%>;
		sessionStorage.img_num = img_num;
		var img_src = new Array();
		<%for(int i=0; i<img_num; i++){%>
		img_src[<%=i%>] = "<%=img_src[i]%>";
		<%}%>

		for(var i=0; i<img_num; i++){
			addImageTag(true);
			$(".board-img").eq(i).attr("src", "<%=image_path%>/" + img_src[i]);
		}

		var option = {
			type: "POST",
			url: "<%=image_pro_path%>",
			success: function(data){
				data = data.trim();
				$("form").eq(tag_num).children().children().attr("src", "<%=image_path%>/"+data);
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
		var tags = "<li class='img-up'><form name='img_form'><div class='img-up'><img class='board-img'/></div>"
			+ "<div class='img-op'><div class='img-op-name'>"
			+ "<input id='img_file' name='img_file' type='file' value='사진 올리기' onchange='submitImage(this);'/>"
			+ "</div><div class='img-op-name'>"
			+ "<button type='button' class='btn btn-warning' onclick='removeImageTag(this);'>삭제 하기</button>"
			+ "</div></div></form></li>";

		$("#ul_bound").children().last().before(tags);
	}
	
	function removeImageTag(cur_tag){
		sessionStorage.img_num = sessionStorage.img_num - 1;
		$("form").each(function(idx){
			if(cur_tag.parentNode.parentNode.parentNode == $(this).context){
				$(this).parent().remove();
				var num = sessionStorage.getItem("img_num");
			}
		})
	}
	
	function modifyImage(form){
		var k = 1;
		$("form").each(function(form_idx){
			var img_src = $(this).children().children(".board-img").attr("src");
			if(img_src != null || img_src != undefined){
				var img_ary = img_src.split("/");
				var img_name = img_ary[img_ary.length-1];
				$("#img_src" + k++).val(img_name);
			}
		})
		if(k < 4){
			alert("사진을 최소 3장 이상 올려주세요.");
			return false;
		}
		removeStorage();
		form.submit();
	}
	
	function removeStorage(){
		sessionStorage.removeItem("img_num");
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
				<h4 class="signup-title">여행 일지 작성</h4>
				<div class="signup-modal-description">내가 알려주고 싶은 나만의 여행지를 소개해 주세요. SHARIP</div>
				<div class="signup-or-dotted-line"></div>
				<div class="panel-body" style="min-width: 400px;">
					<h3>사진 등록하기</h3>
					<ul id="ul_bound">
						<li>
							<div>
								<button class="btn btn-primary" onclick="addImageTag();">사진 추가하기</button>
							</div>
							
						</li>
					</ul>
				</div>
				<form name="mi_form" id="mi_form" action="<%=path%>/rewrite_complete.do" method="POST" class="form-horizontal" >
					<input type="hidden" name="page" value="2">
					<input type="hidden" name="board_idx" value="<%=board_idx%>">
					<input type="hidden" id="img_src1" name="img_src">
					<input type="hidden" id="img_src2" name="img_src">
					<input type="hidden" id="img_src3" name="img_src">
					<input type="hidden" id="img_src4" name="img_src">
					<input type="hidden" id="img_src5" name="img_src">
					<input type="hidden" id="img_src6" name="img_src">
					<input type="hidden" id="img_src7" name="img_src">
					<input type="hidden" id="img_src8" name="img_src">
					<input type="hidden" id="img_src9" name="img_src">
					<input type="hidden" id="img_src10" name="img_src">
					<div style="padding: 20px;">
						<input type="button" class="btn btn-primary"  value="수정하기" onclick="modifyImage(form);"> 							
					</div>
				</form>
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
										<h4>여행 사진</h4>
									</li>
									<li>
										<h4><a href="<%=path%>/rewrite3.do?board_idx=<%=board_idx%>" onclick="save4();">여행 장소</a></h4>
									</li>
									<li>
										<h4><a href="<%=path%>/rewrite4.do?board_idx=<%=board_idx%>" onclick="save4();">여행 팁</a></h4>
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