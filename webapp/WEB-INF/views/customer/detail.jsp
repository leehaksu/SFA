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
	var click_number=0;
	var temp_contact='<c:out value="${customerVo.contact}"/>';
	var array=temp_contact.split("-");
	var temp_contact='<c:out value="${customerVo.manager_contact}"/>';
	var manager_array=temp_contact.split("-");
	
	function change(){
	document.getElementById( '#modify_btn' ).setAttribute('class','fa fa-floppy-o fa-lg' );
	$('.form-control').attr('readonly',false);
	$('#MapSearch_btn').show();

	$('.fa fa-floppy-o fa-lg').on("click",function(){
	$.ajax({
		url : '/sfa/customer/update',
		type : 'POST',
		dataType : 'json',
		/* data : , */
		contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		success : function(doc) {
			//console.log(doc.data);
		}
	});
	
	});
}
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
		$('#contact1').attr("value",array[0]);
		$('#contact1').mask('000');
		$('#contact2').attr("value",array[1]);
		$('#contact2').mask('0000');
		$('#contact3').attr("value",array[2]);
		$('#contact3').mask('0000');
		$('#manager_contact1').attr("value",array[0]);
		$('#manager_contact1').mask('000');
		$('#manager_contact2').attr("value",array[1]);
		$('#manager_contact2').mask('0000');
		$('#manager_contact3').attr("value",array[2]);
		$('#manager_contact3').mask('0000');
		$('#MapSearch_btn').hide();
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
	<div class="panel-info">
		<div class="content-header panel-heading">
			<h3>
				<strong>고객 등록</strong>
				<span style="float: right;">
				<a href="#"> <i id="#modify_btn" class="fa fa-pencil fa-lg"
					aria-hidden="true" onclick="change()"></i>
				</a> &nbsp; <a
					href="${pageContext.servletContext.contextPath}/customer/delete?customer=${customer_code}">
					<i class="fa fa-trash fa-lg" aria-hidden="true"></i>
				</a>
 				</span> 
			</h3>
		</div>
		<form action="${pageContext.servletContext.contextPath}/customer"
			method="post">
			<div id="custominertmain-content">
				<div class="customer">
					<table class="table customer-table">
						<tbody>
							<tr>
								<th>고객명</th>
								<td><input type="text" class="form-control"
									name="customer_name" value="${customerVo.name}"
									style="text-align: center" readonly></td>
							</tr>
							<tr>
								<th>고객 연락처</th>
								<td><input id="contact1" class="form-control" type="text"
									class="form-control" name="customer-phone"
									style="width: 32%; text-align: center;" max="3" readonly> <span
									style='width: 20%; text-align: center;'>-</span> <input
									id="contact2" class="form-control" type="text"
									class="form-control" name="customer-phone" max="4"
									style="width: 32%; text-align: center;" readonly> <span
									style='width: 20%; text-align: center;'>-</span> <input
									id="contact3" class="form-control" type="text"
									class="form-control" name="customer-phone" max="4"
									style="width: 32%; text-align: center;" readonly></td>
							</tr>
							<tr>
								<th>고객 영업시간</th>
								<td><input type="text" class="form-control"
									name="opening-hours" value="${customerVo.time}"
									style="text-align: center" readonly></td>
							</tr>
							<tr>
								<th>업체 주소</th>
								<td><input id="customer-address-input" type="text"
									class="form-control" name="name" value="${customerVo.address}"
									style="text-align: center" readonly>
									<button id="MapSearch_btn" type="button"
										class="btn btn-info btn-md" data-toggle="modal"
										data-target="#search_customer_map">맵 검색</button>
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
				</div>
				<br>
				<h3>당담자</h3>
				<table class="table customer-table">
					<tbody>
						<tr>
							<th>이름</th>
							<td><input id="name" type="text" class="form-control"
								name="name" placeholer="이름 " value="${customerVo.manager_name}"
								style="text-align: center" readonly></td>
						</tr>
						<tr>
							<th>연락처</th>
							<td><input id="manager_contact1" class="form-control"
								type="text" class="form-control" name="customer-phone"
								style="width: 32%; text-align: center;" max="3" readonly> <span
								style='width: 20%; text-align: center;'>-</span> <input
								id="manager_contact2" class="form-control" type="text"
								class="form-control" name="customer-phone" max="4"
								style="width: 32%; text-align: center;" readonly> <span
								style='width: 20%; text-align: center;'>-</span> <input
								id="manager_contact3" class="form-control" type="text"
								class="form-control" name="customer-phone" max="4"
								style="width: 32%; text-align: center;" readonly></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td><input type="email" class="form-control" name="name"
								value="${customerVo.manager_email}" style="text-align: center"
								readonly></td>
						</tr>
					</tbody>
				</table>
			</div>
		</form>
	</div>
	
	</main>
</body>
</html>