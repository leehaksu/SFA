<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<c:import url="/WEB-INF/views/common/common.jsp"></c:import>
<script>
	var current_latitude;
	var current_longitude;

	function getLocation() {
		//console.log("1번째 실행");
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(showPosition, showError);
		} else {
			alert("위치 기반 서비스를 지원하지 않는 브라우저 입니다.")
		}
	}
	function showPosition(position) {
		//console.log("2번째 실행");
		current_latitude = position.coords.latitude;
		current_longitude = position.coords.longitude;
		//map 생성
		init();
	}
	function showError(error) {

		switch (error.code) {
		case error.PERMISSION_DENIED:
			alert("User denied the request for Geolocation.");
			break;
		case error.POSITION_UNAVAILABLE:
			alert("Location information is unavailable.");
			break;
		case error.TIMEOUT:
			alert("The request to get user location timed out.");
			break;
		case error.UNKNOWN_ERROR:
			alert("An unknown error occurred.");
			break;
		}
	}

	function init() {
		zoom = 16; // zoom level입니다.  0~19 레벨을 서비스 하고 있습니다. 
		cLonLat = new Tmap.LonLat(current_longitude, current_latitude);

		map = new Tmap.Map({
			div : 'map_div',
			width : '400px',
			height : '400px',
			animation : true
		});
		map.setCenter(cLonLat, zoom);
	}

	$(document).ready(function() {
		$('input[name=cellphone]').mask('000-0000-0000');
		$('input[name=customer-phone]').mask('00-000-0000');
		
	});
</script>

</head>
<body>
	<!-- onload="getLocation()" -->
	<nav class="navbar navbar-default">
		<c:import url="/WEB-INF/views/include/header.jsp">
			<c:param name="menu" value="main" />
		</c:import>
	</nav>
	<div id="wrapper">
		<div id="sidebar-wrapper">
			<c:import url="/WEB-INF/views/include/navigator.jsp">
				<c:param name="menu" value="main" />
			</c:import>
		</div>
	</div>
	<main id="page-content-wrapper" role="main">
	<div class="customer-container">
		<div class="page-header">
			<h3 >
				<strong>고객 등록</strong>
			</h3>
		</div>
		<div id="custominertmain-content">
			<div class="customer">
				<h3>고객사 정보</h3>
				<form>
					<table class="table customer-table">
						<tbody>
							<tr>
								<th>고객 코드</th>
								<td><자동 기입></td>
							</tr>
							<tr>
								<th>고객명</th>
								<td><input type="text" class="form-control"
									name="customer-name" readonly></td>
							</tr>
							<tr>
								<th>고객 연락처</th>
								<td><input class="form-control" type="text"
									class="form-control" name="customer-phone"readonly></td>
							</tr>
							<tr>
								<th>고객 영업시간</th>
								<td><input type="text" class="form-control"
									name="opening-hours"readonly></td>
							</tr>
							<tr>
								<th>업체 주소</th>
								<td><input id="customer-address-input" type="input"
									class="form-control" name="name"readonly>
									<button type="button" class="btn btn-info btn-md"
										data-toggle="modal" data-target="#search_customer_map">맵
										검색</button>
									<div id="search_customer_map" class="modal fade" role="dialog">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal">&times;</button>
													<h4 class="modal-title">고객 위치 검색</h4>
												</div>
												<div class="modal-body">
													<div id="map_div"></div>
												</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-default"
														data-dismiss="modal">Close</button>
												</div>
											</div>

										</div>
								</div></td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
			<br>
			<h3>당담자</h3>
			<form>
				<table class="table customer-table">
					<tbody>
						<tr>
							<th>이름</th>
							<td><input id="name" type="text" class="form-control"
								name="name" placeholer="휴대전화 번호 " readonly></td>
						</tr>
						<tr>
							<th>연락처</th>
							<td><input id="cellPhone" type="text" class="form-control"
								name="cellphone" placeholer="휴대전화 번호 " readonly></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td><input type="email" class="form-control" name="name" readonly>
							</td>
						</tr>
					</tbody>
				</table>
				<br> <input id="customer-submit-button" type="submit"
					class="btn btn-default" readonly>
			</form>
		</div>
	</div>
	</main>
</body>
</html>