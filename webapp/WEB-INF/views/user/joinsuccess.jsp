<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>SaleForceAutomation</title>

<!-- Bootstrap -->
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/assets/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.servletContext.contextPath}/assets/css/main.css">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/assets/css/bootstrap-theme.min.css">
<link rel='stylesheet'
	href="${pageContext.servletContext.contextPath}/assets/css/join.css" />

<script
	src="${pageContext.servletContext.contextPath}/assets/js/jquery-3.2.1.js"></script>
<!-- Latest compiled and minified JavaScript -->
<script
	src="${pageContext.servletContext.contextPath}/assets/js/bootstrap.min.js"></script>
<script
	src="${pageContext.servletContext.contextPath}/assets/js/moment.js"></script>
<script
	src="${pageContext.servletContext.contextPath}/assets/js/fullcalendar.js"></script>
<script type="text/javascript"
	src="${pageContext.servletContext.contextPath}/assets/js/ko.js"></script>
<script src="https://use.fontawesome.com/f8c7f597cb.js"></script>
<script
	src="${pageContext.servletContext.contextPath}/assets/js/join.js"></script>
</head>

<body>
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
	<article>
		<div class="joinsuccess_container">
			<div class="pageheader">
				<h3>회원 가입</h3>
			</div>
			<div class="pageContent">
				<h4>사원 가입을 진심으로 축하드립니다.</h4>
				<label> 사원 아이디는 ${userVo.id} 입니다.</label>
			</div>
			<div class="pagefooter">
				<div class="personal_header">
					<h4>
						<Strong>개인 정보 내역</strong>
					</h4>
				</div>
				<div class="personal_container">
					<div id="personal_label">
						<label>이름</label>
					</div>
					<div id="personal_data">
						<c:choose>
							<c:when test="${not empty userVo.name}">
								<label> ${userVo.name} </label>
							</c:when>
							<c:otherwise>
								<label> 정보 없음 </label>
							</c:otherwise>
						</c:choose>
					</div>

					<div id="personal_label">
						<label>부서</label>
					</div>
					<div id="personal_data">
						<c:choose>
							<c:when test="${not empty userVo.dept}">
								<label> ${userVo.name} </label>
							</c:when>
							<c:otherwise>
								<label> 정보 없음 </label>
							</c:otherwise>
						</c:choose>
					</div>

					<div id="personal_label">
						<label>직급</label>
					</div>
					<div id="personal_data">
						<c:choose>
							<c:when test="${not empty userVo.grade}">
								<label> ${userVo.grade} </label>
							</c:when>
							<c:otherwise>
								<label> 정보 없음 </label>
							</c:otherwise>
						</c:choose>
					</div>
					<div id="personal_label">
						<label>이메일</label>
					</div>
					<div id="personal_data">
						<c:choose>
							<c:when test="${not empty userVo.email}">
								<label> ${userVo.email} </label>
							</c:when>
							<c:otherwise>
								<label> 정보 없음 </label>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="psersonal_btn">
					<input type="button" id="confirm_button" class="btn btn-primary"
						value="메인화면으로 돌아가기" onClick="location.href='http://localhost:8080/sfa/';">
				</div>
			</div>

		</div>
	</article>
</body>
</html>