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
	<div class="panel-info">
	<div class="content-header panel-heading">
			<h3>
				<strong>통합 게시판</strong>
			</h3>
	</div>
	<div class="main_box">
		<img
			src="${pageContext.servletContext.contextPath}/assets/image/mainbg_02.jpg"
			id="main_img"></img>
		<div>
			<div class="title">
				<h4 id="main_notice">
					<i class="fa fa-list" aria-hidden="true"></i>&nbsp;&nbsp;<Strong>주간계획서</Strong>
				</h4>
				<h5 id="main_notice2">
					<a href="${pageContext.servletContext.contextPath}/week/"><Strong>더보기</Strong>&nbsp;&nbsp;<i class="fa fa-plus"
						aria-hidden="true"></i></a>
				</h5>
				<table class="table table-striped">
					<tr>
						<th class="tg-031e">월요일 목표액</th>
						<th class="tg-031e">화요일 목표액</th>
						<th class="tg-031e">수요일 목표액</th>
						<th class="tg-031e">목요일 목표액</th>
						<th class="tg-031e">목요일 목표액</th>
					</tr>
					<c:forEach items="${week_list}" var="weeklist" varStatus="status">
					<tr>
						<td class="tg-031e">${weeklist}</td>
						<td class="tg-031e">${weeklist}</td>
						<td class="tg-031e">${weeklist}</td>
						<td class="tg-031e">${weeklist}</td>
						<td class="tg-031e">${weeklist}</td>
					</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<div>
			<div class="title">
				<h4 id="main_notice">
					<i class="fa fa-list" aria-hidden="true"></i>&nbsp;&nbsp;<Strong>일일계획서</Strong>
				</h4>
				<h5 id="main_notice2">
				<a href="${pageContext.servletContext.contextPath}/week/">
					<Strong>더보기</Strong>&nbsp;&nbsp;<i class="fa fa-plus"
						aria-hidden="true"></i>
				</a>		
				</h5>
				<table class="table table-striped">
					<tr>
						<th class="tg-031e">날짜</th>
						<th class="tg-031e">제목</th>
						<th class="tg-031e">도전과제</th>
						<th class="tg-031e">예상경로</th>
						<th class="tg-031e">팀장의견</th>
					</tr>
					<c:forEach items="${date_list}" var="datelist" varStatus="status">
					<tr>
						<td class="tg-031e">${datelist.date}</td>
						<td class="tg-031e">${datelist.title}</td>
						<td class="tg-031e">${datelist.challenge_content}</td>
						<td class="tg-031e">${datelist.estimate_course}</td>
						<td class="tg-031e">${datelist.opinion}</td>						
					</tr>					
					</c:forEach>
				</table>
			</div>
		</div>
		<div>
			<div class="title">
				<h4 id="main_notice">
					<i class="fa fa-list" aria-hidden="true"></i>&nbsp;&nbsp;<Strong>업무보고서</Strong>
				</h4>
				<h5 id="main_notice2">
				<a href="${pageContext.servletContext.contextPath}/report/">
					<Strong>더보기</Strong>&nbsp;&nbsp;<i class="fa fa-plus"
						aria-hidden="true"></i>
				</a>
				</h5>
				<table class="table table-striped">
					<tr>
						<th class="tg-031e">번호</th>
						<th class="tg-031e">제목</th>
						<th class="tg-031e">당일 매출액</th>
						<th class="tg-031e">작성일</th>
					</tr>
					<c:forEach items="${report_list}" var="reportlist" varStatus="status">
					<tr>
						<td class="tg-031e">${reportlist.report_no}</td>
						<td class="tg-031e">${reportlist.title}</td>
						<td class="tg-031e">${reportlist.report_sale}</td>
						<td class="tg-031e">${reportlist.reg_date}</td>
					</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
	</div>
	</main>
</body>
</html>