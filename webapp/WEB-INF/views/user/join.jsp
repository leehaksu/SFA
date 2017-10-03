<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
 <c:import url="/WEB-INF/views/common/common.jsp"></c:import>
<script type="text/javascript">
	$(document).ready(function() {
		var url = window.location.href;
		console.log(url);
		var url2 = url.substring(40);
		
	});
</script>
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
		<div id="join_container" style="margin-left: 300px;">
			<div class="col-md-12">
				<div class="page-header">
					<h3>회원 가입</h3>
				</div>
				<form name="joinform" class="form-horizontal" method="post"
					action="${pageContext.servletContext.contextPath}/join">
					<div class="form-group">
						<label class="col-sm-3 control-label" for="inputId">아이디</label>
						<div class="col-sm-6">
							<div id="inputid-form">
								<input class="form-control" id="joininputId" name="id"
									type="text" placeholder="아이디는 대/소문자,숫자  조합  4~20자 사이 "
									style="display:;"> <i id="check-image"
									class="fa fa-check" aria-hidden="true" style="display: none;">확인</i>
								<input id="Idcheck-button" class="btn btn-info" type="button"
									value="중복체크">
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label" for="inputPassword">비밀번호</label>
						<div class="col-sm-6">
							<input class="form-control" id="inputPassword" name="passwd"
								type="password" placeholder="비밀번호는 숫자, 특수문자 포함 8자 이상">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label" for="inputPasswordCheck">비밀번호
							확인</label>
						<div class="col-sm-6">
							<input class="form-control" id="inputPasswordCheck"
								type="password" placeholder="비밀번호 확인">
							<div id="passwordcheck" style="display: none;">
								<i class='fa fa-times' aria-hidden='true' style:color='#E82734'></i>
								&nbsp; 비밀번호가 일치 하지 않습니다.
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label" for="inputName">이름</label>
						<div class="col-sm-6">
							<input class="form-control" id="inputName" name="name"
								type="text" placeholder="이름">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label" for="inputName">이메일</label>
						<div class="col-sm-6">
							<input class="form-control" id="inputEmail" name="email"
								type="text" placeholder="이메일"><i id="check-image"
									class="fa fa-check" aria-hidden="true" style="display: none;">확인</i>
								<input id="Emailcheck-button" class="btn btn-info" type="button"
									value="중복체크">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label" for="inputDepartment">소속</label>
						<div class="col-sm-6">
							<div class="input-group">
								<select class="form-control" id="inputDepartment" name="dept"
									placeholder="소속을 선택해 주세요">
									<option>영업 1팀</option>
									<option>영업 2팀</option>
									<option>영업 3팀</option>
									<option>영업 4팀</option>
									<option>영업 5팀</option>
									<option>영업 6팀</option>
									<option>영업 7팀</option>
								</select>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label" for="inputGrade">직급</label>
						<div class="col-sm-6">
							<div class="input-group">
								<select class="form-control" id="inputGrade" name="grade"
									placeholder="직급명">
									<option>부장</option>
									<option>차장</option>
									<option>과장</option>
									<option>대리</option>
									<option selected="selected">사원 </option>
								</select>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-12 text-center">
							<button id="confirm_button" class="btn btn-primary" type="submit">
								회원가입 &nbsp;<i class="fa fa-check spaceLeft"></i>
							</button>
							<button id="cancel_button" class="btn btn-danger">
								가입취소 &nbsp;<i class="fa fa-times spaceLeft"></i>
							</button>
						</div>
					</div>
				</form>
				<hr>
			</div>
		</div>
	</article>
</body>
</html>