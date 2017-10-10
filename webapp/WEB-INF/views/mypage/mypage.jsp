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
	<form class="form-horizontal">
		<fieldset>

			<!-- Form Name -->
			<legend>회원정보</legend>

			<!-- Text input-->
			<div class="form-group">
				<label class="col-md-4 control-label" for="customer_id">아이디
					ID</label>
				<div class="col-md-4">
					아이디
				</div>
			</div>

			<!-- Text input-->
			<div class="form-group">
				<label class="col-md-4 control-label" for="customer_name">이름</label>
				<div class="col-md-4">
					이름
				</div>
			</div>

			<!-- Text input-->
			<div class="form-group">
				<label class="col-md-4 control-label" for="customer_e_mail">개인 이메일</label>
				<div class="col-md-4">
					개인 이메일
				</div>
			</div>

			<!-- Password input-->
			<div class="form-group">
				<label class="col-md-4 control-label" for="password">PASSWORD</label>
				<div class="col-md-4">
					비밀번호
				</div>
			</div>

			<!-- Text input-->
			<div class="form-group">
				<label class="col-md-4 control-label" for="customer_status">부서
				</label>
				<div class="col-md-4">
					영업 ?팀
				</div>
			</div>

			<!-- Text input-->
			<div class="form-group">
				<label class="col-md-4 control-label" for="site_web">직급</label>
				<div class="col-md-4">
					대리
				</div>
			</div>

		</fieldset>
	</form>

	</main>
</body>
</html>