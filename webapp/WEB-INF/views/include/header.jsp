<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel='stylesheet' 
	href="${pageContext.servletContext.contextPath}/assets/css/include/header.css" />	
<div class="container-fluid">
	<div class="navbar-header">
		<a class="navbar-brand" href="#"><img class="img-responsive"
			style="width: 183px;"
			src="${pageContext.servletContext.contextPath}/assets/image/logo.png" /></a>
	</div>
	<div>
		<ul class="nav navbar-nav ">
			<li class="droupdown menu-icon"><a class="dropdown-toggle"
				data-toggle="dropdown"> <i class="fa fa-calendar"
					aria-hidden="true"></i> 영업 관리
			</a>
				<ul class="dropdown-menu">
					<li><a href="${pageContext.servletContext.contextPath}/week/">영업 계획서</a></li>
					<li><a href="#">영업 보고서</a></li>
					<li><a href="#">영업 기획서</a></li>
				</ul></li>
			<li class="droupdown menu-icon"><a class="dropdown-toggle"
				data-toggle="dropdown" href="#"> 
				<i class="fa fa-address-book-o" aria-hidden="true"></i> 고객 관리				 
			</a>
				<ul class="dropdown-menu">
					<li><a href="${pageContext.servletContext.contextPath}/customer/search">고객 조회</a></li>
					<li><a href="${pageContext.servletContext.contextPath}/customer/insert">고객 등록</a></li>
				</ul></li>
			<li class="droupdown menu-icon"><a class="dropdown-toggle"
				data-toggle="dropdown" href="#"><i class="fa fa-line-chart"
					aria-hidden="true"></i> 영업 통계 </a>
				<ul class="dropdown-menu submenu-icon">
					<li><a href="#">거래처 현황</a></li>
					<li><a href="#">금일 목표/실적 현황</a></li>
					<li><a href="#">주행거리 기록 현황</a></li>
					<li><a href="#">월별 매출 현황</a></li>
				</ul></li>
					<c:if test="${authUser.level =='팀장'}">
			<li class="droupdown menu-icon"><a class="dropdown-toggle"
				data-toggle="dropdown" href="#"><i class="fa fa-users"
					aria-hidden="true"></i> 팀원 관리 </a>
				<ul class="dropdown-menu">
				<li><a href="${pageContext.servletContext.contextPath}/join">팀원 등록</a></li>
					<li><a href="${pageContext.servletContext.contextPath}/list">팀원 조회</a></li>
				</ul>
				</li>
				</c:if>
			
				<li class="droupdown menu-icon">
				<a href="${pageContext.servletContext.contextPath}/user/notice_board"> 
				<i class="fa fa-bell" aria-hidden="true"></i> 공지사항
				</a>
				</li>
				
				<li class="droupdown menu-icon">
				<a href="${pageContext.servletContext.contextPath}/user/mypage"> 
				<i class="fa fa-user" aria-hidden="true"></i> 마이페이지
				</a>
				</li>
			
				</ul>
				
	</div>
	<div>
		<ul class="nav navbar-nav navbar-right">
			<li><a
				href="${pageContext.servletContext.contextPath}/user/logout"><span
					class="glyphicon glyphicon-log-out"></span> Logout</a></li>
		</ul>
		<br>
		<div id="user-info">
			<p class="small">${authUser.name}[${authUser.dept}] 환영합니다.</p>
		</div>
	</div>
</div>