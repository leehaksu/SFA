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
				<label class="col-md-4 control-label" for="user_id">ID</label>
				<div class="col-md-4"><span>${authUser.id}</span>
				</div>
			</div>

			<!-- Text input-->
			<div class="form-group">
			
				<label class="col-md-4 control-label" for="user_name">이 름 </label>
				<div class="col-md-4"><span>${authUser.name}</span>
				</div>
			</div>

			<!-- Text input-->
			<div class="form-group">
				<label class="col-md-4 control-label" for="user_e_mail">이메일</label>
				<div class="col-md-4">
					<input id="user_e_mail" name="user_e_mail"
						placeholder="개인 이메일" class="form-control input-md"
						required="" type="text" value="${authUser.email}" >

				</div>
			</div>

			<!-- Password input-->
			<div class="form-group">
				<label class="col-md-4 control-label" for="password">PASSWORD</label>
				<div class="col-md-4">
					<input id="password" name="password" placeholder="PASSWORD"
						class="form-control input-md" required="" type="password" >

				</div>
			</div>
			
				<div class="form-group">
				<label class="col-md-4 control-label" for="password_check">PASSWORD 확인</label>
				<div class="col-md-4">
					<input id="password_check" name="password_check" placeholder="비밀번호 확인"
						class="form-control input-md" required="" type="password">

				</div>
			</div>

			<!-- Text input-->
			<div class="form-group">
				<label class="col-md-4 control-label" for="user_status">부서</label>
				<div class="col-md-4">
					<select id="user_status" name="user_status"
						 class="form-control input-md"
						required> 
						<option value="1" selected>영업1팀</option>
						<option value="2">영업2팀</option>
						<option value="3">영업3팀</option>						
						</select>

				</div>
			</div>

			<!-- Text input-->
			<div class="form-group">
				<label class="col-md-4 control-label" for="grade">직급</label>
				<div class="col-md-4">
					<select id="grade" name="grade"
						class="form-control input-md" required>
						<option value="1" selected>사원</option>
						<option value="2">대리</option>
						<option value="3">과장</option>
						</select>

				</div>
			</div>
			
			<!-- Button -->
			<div class="form-group">
				<label class="col-md-4 control-label" for=""></label>
				<div class="col-md-4">
					<button id="" name="" class="btn btn-primary">수정하기</button>
				</div>
			</div>

		</fieldset>
	</form>
	</main>
</body>
</html>