<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
 <c:import url="/WEB-INF/views/common/common.jsp"></c:import>
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
	<main id="page-content-wrapper" role="main">
		<div class="joinsuccess_container">
			<div class="page-header">
					<h3 class="dayreport">
						<strong>회원 가입 완료</strong>
					</h3>
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
	</main>
</body>
</html>