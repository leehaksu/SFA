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
	<div class="page-header">
		<h3>
			<strong>회원 정보</strong>
		</h3>
	</div>
	<form class="form-horizontal">
		<table class="table table-hover">
			<tbody>
				<tr>
					<td>
						<div class="form-group">
							<label class="col-md-4 control-label" for="user_id"> ID</label>
							<div class="col-md-4" style="margin-top: 8px;">
								<span>${authUser.id}</span>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
							<label class="col-md-4 control-label" for="user_name">이름</label>
							<div class="col-md-4" style="margin-top: 8px;">
								<input id="user_e_mail" name="user_e_mail" placeholder="개인 이메일"
									class="form-control input-md" value="${authUser.name}" required
									type="email">
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
							<label class="col-md-4 control-label" for="user_e_mail">이메일</label>
							<div class="col-md-4">
								<input id="user_e_mail" name="user_e_mail" placeholder="개인 이메일"
									class="form-control input-md" required type="email">

							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
							<label class="col-md-4 control-label" for="password">PASSWORD</label>
							<div class="col-md-4">
								<input id="password" name="password" placeholder="PASSWORD"
									class="form-control" required pattern="^[a-z0-9_]{5,12}$"
									type="password">

							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
							<label class="col-md-4 control-label" for="password_check">PASSWORD
								확인</label>
							<div class="col-md-4">
								<input id="password_check" name="password_check"
									placeholder="비밀번호 확인" class="form-control " required=""
									type="password">

							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
							<label class="col-md-4 control-label" for="user_status">부서</label>
							<div class="col-md-4">
								<select id="user_status" name="user_status"
									class="form-control " required>
									<option value="부서" selected>부서</option>
									<option value="1">영업1팀</option>
									<option value="2">영업2팀</option>
									<option value="3">영업3팀</option>
								</select>

							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
							<label class="col-md-4 control-label" for="grade">직급</label>
							<div class="col-md-4">
								<select id="grade" name="grade" class="form-control " required>
									<option value="부서" selected>직급</option>
									<option value="1">사원</option>
									<option value="2">대리</option>
									<option value="3">과장</option>
								</select>

							</div>
						</div>
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td>
						<div class="form-group">
							<label class="col-md-4 control-label" for=""></label>
							<div class="col-md-4">
								<input type="submit" value="저장하기" id="" name=""
									class="btn btn-primary">
								</button>
							</div>
						</div>
					</td>
				</tr>
			</tfoot>
		</table>
	</form>
	</main>
</body>
</html>