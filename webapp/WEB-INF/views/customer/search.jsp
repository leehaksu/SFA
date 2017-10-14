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
	<div>
		<div class="content-header">
			<h3 >
				<strong>고객 조회</strong>
			</h3>
		</div>
		<div class="search_wrap">
			<div class="search_list">
				<ul>
					<li class="all"><input class="ng-all" type="text"
						placeholder="고객명">
						 <a href="#" class="button" type="button">검색</a>
						 <a href="${pageContext.servletContext.contextPath}/customer/insert" class="button" type="button">추가</a>
					</li>
					<li><select name="ng-valid" class="ng-valid">
							<option value="영업부" selected="">영업부</option>
							<option value="파트너">파트너</option>
							<option value="파트너사">파트너사</option>
					</select> <select name="ng-valid" class="ng-valid">
							<option value="영업부" selected="">영업부</option>
							<option value="파트너">파트너</option>
							<option value="파트너사">파트너사</option>
					</select></li>

				</ul>
			</div>
			<div class="search_mt">
				<div class="left">
					<span class="ng-binding">0건</span>
				</div>
				<div class="right">
					<a class="on" href="#">등록일 순</a> <a class="on" href="#">고객사 순</a> <a
						class="on default" href="#">가나다 순</a>
				</div>
			</div>
		</div>
		<hr>
		
		<c:forEach items="${list}" var="customerVo" varStatus="status">
		<div id="customer-info" class="well">
			<a href="${pageContext.servletContext.contextPath}/customer/detail?customer_code=${customerVo.customer_code}">
			<h4>${customerVo.name}</h4>
			<small>${customerVo.address}<i class="glyphicon glyphicon-map-marker"></i>			
			</small>
			<p>
				<i class="fa fa-user" aria-hidden="true"></i>담당자:${customerVo.manager_name}<br/> <i
					class="glyphicon glyphicon-envelope"></i>${customerVo.manager_email} <br />
				<i class="fa fa-phone" aria-hidden="true"></i>${customerVo.manager_contact}
			</p>
			</a>
		</div>
		</c:forEach>
		<%-- <c:forEach items="${customerList}" var="dayreportVo" varStatus="status">
		<div id="customer-info" class="well">
			<a href="${pageContext.servletContext.contextPath}/customer/customer_detail">
			<h4>${customerlist.name}</h4>
			<small>${customerlist.address}<i class="glyphicon glyphicon-map-marker"></i>			
			</small>
			<p>
				<i class="fa fa-user" aria-hidden="true"></i>담당자:${customerlist.manager_name}<br /> <i
					class="glyphicon glyphicon-envelope"></i>${customerlist.manager_email} <br />
				<i class="fa fa-phone" aria-hidden="true"></i>${customerlist.manager_contact}
			</p>
			</a>
		</div>
		</c:forEach> --%>
	</div>
	</main>

</body>
</html>