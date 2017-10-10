<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
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
				<label class="col-md-4 control-label" for="customer_id">
					ID</label>
				<div class="col-md-4">
					<input id="customer_id" name="customer_id"
						placeholder="CUSTOMER ID" class="form-control input-md"
						required="" type="text">

				</div>
			</div>

			<!-- Text input-->
			<div class="form-group">
				<label class="col-md-4 control-label" for="customer_name">이름</label>
				<div class="col-md-4">
					<input id="customer_name" name="customer_name"
						placeholder="CUSTOMER NAME" class="form-control input-md"
						required="" type="text">

				</div>
			</div>

			<!-- Text input-->
			<div class="form-group">
				<label class="col-md-4 control-label" for="customer_e_mail">이메일</label>
				<div class="col-md-4">
					<input id="customer_e_mail" name="customer_e_mail"
						placeholder="CUSTOMER E.MAIL" class="form-control input-md"
						required="" type="text">

				</div>
			</div>

			<!-- Password input-->
			<div class="form-group">
				<label class="col-md-4 control-label" for="password">PASSWORD</label>
				<div class="col-md-4">
					<input id="password" name="password" placeholder="PASSWORD"
						class="form-control input-md" required="" type="password">

				</div>
			</div>

			<!-- Text input-->
			<div class="form-group">
				<label class="col-md-4 control-label" for="customer_status">부서</label>
				<div class="col-md-4">
					<input id="customer_status" name="customer_status"
						placeholder="CUSTOMER STATUS" class="form-control input-md"
						required="" type="text">

				</div>
			</div>

			<!-- Text input-->
			<div class="form-group">
				<label class="col-md-4 control-label" for="site_web">직급</label>
				<div class="col-md-4">
					<input id="site_web" name="site_web" placeholder="SITE WEB"
						class="form-control input-md" type="text">

				</div>
			</div>


			<!-- Text input-->
			<div class="form-group">
				<label class="col-md-4 control-label" for="phone1">전화번호</label>
				<div class="col-md-4">
					<input id="phone1" name="phone1" placeholder="PHONE1"
						class="form-control input-md" required="" type="text">
				</div>
			</div>


			<!-- Button -->
			<div class="form-group">
				<label class="col-md-4 control-label" for=""></label>
				<div class="col-md-4">
					<button id="" name="" class="btn btn-primary">Submit</button>
				</div>
			</div>

		</fieldset>
	</form>


	</main>
</body>
</html>