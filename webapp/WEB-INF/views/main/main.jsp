<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
	<div class="main_box">
		<img
			src="${pageContext.servletContext.contextPath}/assets/image/mainbg_02.jpg"
			id="main_img"></img>
		<div class="notification">
			<h5>
				<strong>알림</strong>
			</h5>
		</div>
		<div class="container_right">
			<div class="title">
				<h4 id="main_notice">
					<i class="fa fa-list" aria-hidden="true"></i>&nbsp;&nbsp;<Strong>공지사항</Strong>
				</h4>
				<h5 id="main_notice2">
					<Strong>더보기</Strong>&nbsp;&nbsp;<i class="fa fa-plus"
						aria-hidden="true"></i>
				</h5>
				<table class="table table-striped">
					<tr>
						<th class="tg-031e">번호</th>
						<th class="tg-031e">제목</th>
						<th class="tg-031e">작성자</th>
						<th class="tg-031e">작성일</th>
					</tr>
					<tr>
						<th class="tg-031e"></th>
						<th class="tg-031e"></th>
						<th class="tg-031e"></th>
						<th class="tg-031e"></th>
					</tr>
				</table>
			</div>
		</div>
		<div class="container_left">
			<div class="title">
				<h4 id="main_notice">
					<i class="fa fa-list" aria-hidden="true"></i>&nbsp;&nbsp;<Strong>주간계획서</Strong>
				</h4>
				<h5 id="main_notice2">
					<Strong>더보기</Strong>&nbsp;&nbsp;<i class="fa fa-plus"
						aria-hidden="true"></i>
				</h5>
				<table class="table table-striped">
					<tr>
						<th class="tg-031e">번호</th>
						<th class="tg-031e">제목</th>
						<th class="tg-031e">작성자</th>
						<th class="tg-031e">작성일</th>
					</tr>
					<tr>
						<th class="tg-031e"></th>
						<th class="tg-031e"></th>
						<th class="tg-031e"></th>
						<th class="tg-031e"></th>
					</tr>
				</table>
			</div>
		</div>
		<div class="container_right">
			<div class="title">
				<h4 id="main_notice">
					<i class="fa fa-list" aria-hidden="true"></i>&nbsp;&nbsp;<Strong>일일계획서</Strong>
				</h4>
				<h5 id="main_notice2">
					<Strong>더보기</Strong>&nbsp;&nbsp;<i class="fa fa-plus"
						aria-hidden="true"></i>
				</h5>
				<table class="table table-striped">
					<tr>
						<th class="tg-031e">번호</th>
						<th class="tg-031e">제목</th>
						<th class="tg-031e">작성자</th>
						<th class="tg-031e">작성일</th>
					</tr>
					<tr>
						<th class="tg-031e"></th>
						<th class="tg-031e"></th>
						<th class="tg-031e"></th>
						<th class="tg-031e"></th>
					</tr>
				</table>
			</div>
		</div>
		<div class="container_left">
			<div class="title">
				<h4 id="main_notice">
					<i class="fa fa-list" aria-hidden="true"></i>&nbsp;&nbsp;<Strong>업무보고서</Strong>
				</h4>
				<h5 id="main_notice2">
					<Strong>더보기</Strong>&nbsp;&nbsp;<i class="fa fa-plus"
						aria-hidden="true"></i>
				</h5>
				<table class="table table-striped">
					<tr>
						<th class="tg-031e">번호</th>
						<th class="tg-031e">제목</th>
						<th class="tg-031e">작성자</th>
						<th class="tg-031e">작성일</th>
					</tr>
					<tr>
						<th class="tg-031e"></th>
						<th class="tg-031e"></th>
						<th class="tg-031e"></th>
						<th class="tg-031e"></th>
					</tr>
				</table>
			</div>
		</div>
	</div>
	</main>
</body>
</html>