<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<c:import url="/WEB-INF/views/common/common.jsp"></c:import>
<script>
	var dept='<c:out value="${authUser.dept}"/>';
	var grade='<c:out value="${authUser.grade}"/>';
	console.log(dept);
	console.log(grade);
	
	$(document).ready(function() {
 		$("#user_dept").find("option").each(function() {				 
			
 			if(this.value == dept){
 				$(this).prop('selected', true);
 			}
 		});
 		
		$("#user_grade").find("option").each(function() {				 
 			if(this.value == grade){
 				$(this).prop('selected', true);
 			}
 		});
		
		$("#password").focusin(function(){
			$("#inputPasswordCheck").val("");
		});
		
		$("#password_check").keyup(function(){	
			//3-1. 비밀번호와 비밀번호 체크 비교
			if ($("#password").val() != $("#password_check").val()) {
				$("#passwordcheck").show();
				return false;
			}
			else{
				$("#passwordcheck").hide();
			}
		});
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
	<main id="page-content-wrapper" role="main">
	<div class="page-header">
		<h3>
			<strong>회원 정보</strong>
		</h3>
	</div>
	<form class="form-horizontal" method="post"
		action="${pageContext.servletContext.contextPath}/mypage"
		>
		<table class="table table-hover">
			<tbody>
				<tr>
					<td>
						<div class="form-group">
							<label class="col-md-4 control-label" for="user_id"> ID</label>
							<div class="col-md-6" style="margin-top: 8px;">
								<span>${authUser.id}</span>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
							<label class="col-md-4 control-label" for="user_name">이름</label>
							<div class="col-md-6" style="margin-top: 8px;">
								<input id="user_e_mail" name="name"
									class="form-control input-md mypage_input" value="${authUser.name}" required
									type="text">
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
							<label class="col-md-4 control-label" for="user_e_mail">이메일</label>
							<div class="col-md-6">
								<input id="inputEmail" name="email" placeholder="개인 이메일" style="width: 76%;"
									class="form-control input-md mypage_input" required type="email" value="${authUser.email}">
								 <i id="Emailcheck-image" class="fa fa-check" aria-hidden="true" style="display: none;">확인</i>
									<input id="Emailcheck-button" class="btn btn-info" type="button"
										value="중복체크">
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
							<label class="col-md-4 control-label" for="password">PASSWORD</label>
							<div class="col-md-6">
								<input id="password" name="passwd"
									placeholder="숫자,특수문자 포함 8자 이상" class="form-control mypage_input" required
									pattern="^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-]|.*[0-9]).{8,24}$"
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
							<div class="col-md-6">
								<input id="password_check" name="password_check"
									placeholder="비밀번호 확인" class="form-control mypage_input" required=""
									type="password">
								<div id="passwordcheck" style="display: none;">
									<i class='fa fa-times' aria-hidden='true'></i>
									&nbsp; 비밀번호가 일치 하지 않습니다.
								</div>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
							<label class="col-md-4 control-label" for="user_status">부서</label>
							<div class="col-md-6">
								<select id="user_dept" name="dept" class="form-control mypage_input"
									required>
									<option value="부서" selected>부서</option>
									<option value="영업  1팀">영업 1팀</option>
									<option value="영업  2팀">영업 2팀</option>
									<option value="영업  3팀">영업 3팀</option>
								</select>

							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
							<label class="col-md-4 control-label" for="grade">직급</label>
							<div class="col-md-6">
								<select id="user_grade" name="grade" class="form-control mypage_input" required>
									<option value="부서" selected>직급</option>
									<option value="사원">사원</option>
									<option value="대리">대리</option>
									<option value="과장">과장</option>
									<option value="차장">차장</option>
									<option value="부장">부장</option>
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
							<div style="margin: 0 auto; text-align: center;">
								<input type="submit" value="저장하기" id="" name=""
									class="btn btn-primary">
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