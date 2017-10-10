<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:import url="/WEB-INF/views/common/common.jsp"></c:import>
</head>
<body>
	<nav class="navbar navbar-default"> <c:import
		url="/WEB-INF/views/include/header.jsp">
		<c:param name="menu" value="main" />
	</c:import> </nav>
	<div id="wrapper">
		<div id="sidebar-wrapper">
			<c:import url="/WEB-INF/views/include/navigator.jsp">
				<c:param name="menu" value="main" />
			</c:import>
		</div>
	</div>
	<main id="page-content-wrapper" role="main">
	<div class="container" style="margin-left: 18%;">
		<br>
		<h3>고객 조회</h3>
		<hr>
		<div class="search_wrap">
			<div class="search_list">
				<ul>
					<li class="all"><input class="ng-all" type="text"
						placeholder="고객명"></li>
					<li class="btn_group"><a href="#" class="button" type="button">추가</a>
						<a href="#" class="button" type="button">검색</a></li>
					<li><select name="ng-valid" class="ng-valid">
							<option value="영업부" selected>영업부</option>
							<option value="파트너">파트너</option>
							<option value="파트너사">파트너사</option>
					</select></li>
					<li><select name="ng-valid" class="ng-valid">
							<option value="사원명" selected>사원명</option>
							<option value="김대리">파트너</option>
							<option value="이차장">파트너사</option>
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
		<div>
			<h4>알리딘 슈퍼</h4>
			<small>서울시 동작구 신대방동 <i class="glyphicon glyphicon-map-marker"> </i>
			</small>
			<p>
				<i class="fa fa-user" aria-hidden="true"></i>담당자:김삼순<br />
				<i class="glyphicon glyphicon-envelope"></i>email@example.com <br />
				<i class="fa fa-phone" aria-hidden="true"></i>010-1234-5678
			</p>

		</div>
	</div>
	</main>
</body>
</html>