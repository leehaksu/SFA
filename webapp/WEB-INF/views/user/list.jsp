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
	<article>
		<div id="search_container">
			<div class="pageheader">
				<h3>사원 정보 조회</h3>
			</div>
			<form name="joinform" class="form-horizontal" method="post"
				action="${pageContext.servletContext.contextPath}/list">
				<div class="search_box">
					<table id="search_table">
						<tr>
							<th id="search_label">이름 :</th>
							<td id="search_input"><input class="form-control"
								id="inputName" name="name" type="text" placeholder="이름"></td>
							<th id="search_label">직급 :</th>
							<td id="search_input"><select class="form-control"
								id="inputGrade" name="grade">
									<option>부장</option>
									<option>차장</option>
									<option>과장</option>
									<option>대리</option>
									<option>사원</option>
									<option selected="selected">전체 </option>
							</select></td>
							<th id="search_input">
								<button class="btn btn-info" type="submit">사원 찾기</button>
							</th>
						</tr>
					</table>
				</div>
			</form>
			<div class="pageheader">
				<h3>팀원 목록</h3>
			</div>
			<div id="search_list">
				<div>
					<table class="table">
						<thead>
							<tr>
								<th id="search_td">아이디</th>
								<th id="search_td">이 름</th>
								<th id="search_td">부 서</th>
								<th id="search_td">직 급</th>
								<th id="search_td">등 급</th>
								<th id="search_td">이 메 일</th>
								<th id="search_td"></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="vo" varStatus="status">
							<tr>
										<td id="search_td">${vo.id}</td>
										<td id="search_td">${vo.name}</td>
										<td id="search_td">${vo.dept}</td>
										<td id="search_td">${vo.grade}</td>
										<td id="search_td">${vo.level}</td>
										<td id="search_td">${vo.email}</td>
										<td id="search_td"><a id="search_userid"
											href="modify?id=${vo.id}" class="btn btn-info" role="button"
											target="_blank">수정</a></td>
									</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</article>
</body>
</html>