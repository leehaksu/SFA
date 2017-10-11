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
	<div id="content">
		<div id="board">
			<form id="search_form"
				action="${pageContext.request.contextPath }/board" method="get">
				<input type="text" id="kwd" name="kwd" value="${map.keyword }">
				<input type="submit" value="찾기">
			</form>
			<table class="tbl-ex">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>글쓴이</th>
					<th>조회수</th>
					<th>작성일</th>
					<th>&nbsp;</th>
				</tr>
				<c:forEach items="${map.list }" var="vo" varStatus="status">
					<tr>
						<td>${map.totalCount - (map.currentPage - 1)*map.listSize - status.index }</td>
						<c:choose>
							<c:when test="${vo.depth > 0 }">
								<td class="left" style="padding-left:${20*vo.depth }px"><img
									src="${pageContext.request.contextPath }/assets/images/reply.png">
									<a
									href="${pageContext.request.contextPath }/board/view/${vo.no }?p=${map.currentPage }&kwd=${map.keyword }">${vo.title }</a>
								</td>
							</c:when>
							<c:otherwise>
								<td class="left"><a
									href="${pageContext.request.contextPath }/board/view/${vo.no }?p=${map.currentPage }&kwd=${map.keyword }">${vo.title }</a>
								</td>
							</c:otherwise>
						</c:choose>
						<td>${vo.userName }</td>
						<td>${vo.hit }</td>
						<td>${vo.regDate }</td>
						<td><c:choose>
								<c:when
									test="${not empty authUser && authUser.no == vo.userNo }">
									<a
										href="${pageContext.request.contextPath }/board/delete/${vo.no }?p=${map.currentPage }&kwd=${map.keyword }"
										class="del">삭제</a>
								</c:when>
								<c:otherwise>
										&nbsp;
									</c:otherwise>
							</c:choose></td>
					</tr>
				</c:forEach>
			</table>
			<div class="pager">
				<ul>
					<c:if test="${map.prevPage > 0 }">
						<li><a
							href="${map.pageContext.request.contextPath }/board?p=${map.prevPage }&kwd=${map.keyword }">◀</a></li>
					</c:if>

					<c:forEach begin="${map.beginPage }"
						end="${map.beginPage + map.listSize - 1 }" var="page">
						<c:choose>
							<c:when test="${map.endPage < page }">
								<li>${page }</li>
							</c:when>
							<c:when test="${map.currentPage == page }">
								<li class="selected">${page }</li>
							</c:when>
							<c:otherwise>
								<li><a
									href="${pageContext.request.contextPath }/board?p=${page }&kwd=${map.keyword }">${page }</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<c:if test="${nextPage > 0 }">
						<li><a
							href="${pageContext.request.contextPath }/board?p=${map.nextPage }&kwd=${map.keyword }">▶</a></li>
					</c:if>
				</ul>
			</div>
			<div class="bottom">
				<c:if test="${not empty authUser }">
					<a href="${pageContext.request.contextPath }/board/write?p=${map.currentPage }&kwd=${map.keyword }"
						id="new-book">글쓰기</a>
				</c:if>
			</div>
		</div>
	</div>
	</main>
</body>
</html>