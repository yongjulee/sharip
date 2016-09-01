<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<title>Map</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="<%=path%>/css/style.css">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<!-- Latest compiled JavaScript -->
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBhYxaXetxNgRn8lk2xanBSMwXCpqa5TGo&libraries=places&region=KR"></script>
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

.bound {
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

var map;
var marker;
var place;
var infowindow;
var autocomplete;

$(function(){
	initMap();
	initLocation();
});
function initLocation(){
	if(marker) marker.setMap(null);
	var lat = sessionStorage.lat;
	var lng = sessionStorage.lng;
	var loc = sessionStorage.loc;
	if(lat && lng && loc){
		latLng = new google.maps.LatLng(sessionStorage.lat, sessionStorage.lng);
		marker = new google.maps.Marker({
			map: map,
			draggable: true,
			position: latLng
		});
		map.panTo(latLng);
		
		infowindow.setContent('<div>' + loc + '</div>');
	    infowindow.open(map, marker);
	}
}

function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
      center: new google.maps.LatLng(36.5, 128),
      zoom: 6
    });
    var input =(document.getElementById('search_map'));

    autocomplete = new google.maps.places.Autocomplete(input);
    autocomplete.bindTo('bounds', map);

    infowindow = new google.maps.InfoWindow();
    marker = new google.maps.Marker({
      map: map,
      anchorPoint: new google.maps.Point(0, -29)
    });

    autocomplete.addListener('place_changed', function() {
      infowindow.close();
      marker.setVisible(false);
      place = autocomplete.getPlace();
      if (!place.geometry) {
        alert("Autocomplete's returned place contains no geometry");
        return;
      }

      if (place.geometry.viewport) {
        map.fitBounds(place.geometry.viewport);
      } else {
        map.setCenter(place.geometry.location);
        map.setZoom(17);
      }

      latLng = new google.maps.LatLng(place.geometry.location.lat(), place.geometry.location.lng());
      marker = new google.maps.Marker({
    	  map: map,
    	  draggable: false,
    	  position: latLng
    });
      map.panTo(latLng);
      
      // 웹 스토리지에 저장 해둔다.
      sessionStorage.setItem("lat",place.geometry.location.lat());
      sessionStorage.setItem("lng",place.geometry.location.lng());
      sessionStorage.setItem("loc",place.name);
      marker.setVisible(true);

      var address = '';
      if (place.address_components) {
        address = [
          (place.address_components[0] && place.address_components[0].short_name || ''),
          (place.address_components[1] && place.address_components[1].short_name || ''),
          (place.address_components[2] && place.address_components[2].short_name || '')
        ].join(' ');
      }

      infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
      infowindow.open(map, marker);
    });
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
				<div class="signup-modal-description">내가 알려주고 싶은 나만의 여행지를 소개해
					주세요. SHARIP</div>
				<div class="signup-or-dotted-line"></div>
				<!-- 중간 -->
				<div class="panel-body">
					<form class="form-horizontal">
						<div class="form-group">
							<div class="col-sm-8">
								<input type="text" class="form-control" id="search_map"
									name="search_map" placeholder="주소 검색" />
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-8">
								<div id="map" style="width: 455px; height: 300px;"></div>
							</div>
						</div>
						<input type="hidden" id="check_value" value="0" />
						<!-- 마지막 -->
						<button type="button" class="btn btn-primary" onclick="location.href = 'write4.do';">다음 단계로 넘어가기</button>
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
									<h4>여행 장소</h4>
								</li>
								<li>
									<h4><a href="<%=path%>/write4.do" onclick="save4();">여행 팁</a></h4>
								</li>
							</ul>
						</div>
						<div class="bound" style="margin-top: 20px; padding: 20px;">
							<img src="<%=path%>/img/answer_icon.png"/> 일지 작성 팁
							<br/><br/>
							- 여행하신 장소를 검색 하셔서 등록하여 주세요.<br/><br/>
							- 다른사람들에게 알려지는 만큼 자세하게 등록해 주세요.
						</div>
					</div>
				</div>
		</div>
	</div>
</body>
</html>