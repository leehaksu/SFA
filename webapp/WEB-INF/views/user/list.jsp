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
		<div class="panel-info" style="clear: both; margin-top : 10px;">
		<div class="content-header panel-heading">
			<h3 >
				<strong>팀원 정보 조회</strong>
			</h3>
		</div>
		</div>
		<div id="list_container">			
			<form name="joinform" class="form-horizontal" method="post"
				action="${pageContext.servletContext.contextPath}/list">
				<div class="search_box">
					<table id="search_table">
						<tr>
							<th id="search_label">이름 :</th>
							<td class="search_input"><input class="form-control"
								id="inputName" name="name" type="text" placeholder="이름"></td>
							<th id="search_label">직급 :</th>
							<td class="search_input"><select class="form-control"
								id="inputGrade" name="grade">
									<option value="부장">부장</option>
									<option value="차장">차장</option>
									<option value="과장">과장</option>
									<option value="대리">대리</option>
									<option value="사원">사원</option>
									<option selected="selected">전체 </option>
							</select></td>
							<th class="search_input">
								<button class="btn btn-info" type="submit">사원 찾기</button>
							</th>
						</tr>
					</table>
				</div>
			</form>
	
			<div id="search_list">
				<div>
					<table class="table">
						<thead>
							<tr>
								<th id="search_td">아이디</th>
								<th id="search_td">이 름</th>
								<th id="search_td">부 서</th>
								<th id="search_td">직 급</th>
								<th id="search_td">이 메 일</th>
								<th id="search_td">상태</th>
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
										<td id="search_td">${vo.email}</td>
										<c:choose>
										<c:when test="${vo.status == 1}">	
										<td id="search_td">재직</td>
										</c:when>
										<c:otherwise>	
											<td id="search_td">퇴사</td>
										</c:otherwise>
										</c:choose>
										<td id="search_td"><a id="search_userid"
											href="modify?id=${vo.id}" class="btn btn-info" role="button"
											>수정</a></td>
									</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</main>
</body>
</html>