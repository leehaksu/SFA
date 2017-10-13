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
	var reg_uid = /^[A-Za-z]{1}[A-Za-z0-9]{3,19}$/;
	var reg_upw = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-]|.*[0-9]).{8,24}$/;
	var check = false;
	var password_check = false;
	
	var userdept='<c:out value="${userVo.grade}"/>';
	var usergrade='<c:out value="${userVo.grade}"/>';
	
			

	$(document).ready(function() {		
		$("#inputDepartment").find("option").each(function() {				 
 			if(this.value == userdept){
 				$(this).prop('selected', true);
 			}
 		});
 		
		$("#inputGrade").find("option").each(function() {				 
 			if(this.value == usergrade){
 				$(this).prop('selected', true);
 			}
 		});
		
						$("#reset_password").click(function() {
							check = true;
							$("#modify_inputPassword").show();
							$("#passwordReset-image").show();
							console.log(check);
						});

						password_check = $("#modify_confirm_button").click(function() {
											//4. 이름이 비어있는지 체크 
											if ($("#inputName").val() == "") {
												alert("이름이 비어있습니다.");
												$("#inputName").focus();
												return false;
											}
											return true;
										});

						$("#modify_confirm_button").click(
								function() {
									if (password_check == true) {
										var form = document
												.getElementById("modifyform");
										form.action = "modify"; // action에 해당하는 jsp 경로를 넣어주세요.
										form.submit();
									}
								});
						$("#modify_delete_button").click(function() {
							var form = document.getElementById("modifyform");
							form.action = "delete"; // action에 해당하는 jsp 경로를 넣어주세요.
							form.submit();
						});
						var url = window.location.href;// 현재 URL을 가지고 옴
						var url2 = url.substring(40);//URL의 40번째기준으로 자름
						if (url2 == "fail") {//Fail 경우
							new Noty({
								type : "info",
								text : "수정에 실패하였습니다.",
								timeout : 4500,
							}).show();

						} else {//success일 경우
							new Noty({
								type : "info",
								text : "수정에 성공하였습니다.",
								timeout : 4500,
							}).show(); 
						}
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
			<strong>회원 정보수정</strong>
		</h3>
	</div>
	<article>
		<div id="modify_container">
			<div class="pagedetailHeader">
				<h4>${userVo.id}님의사원정보입니다.</h4>
			</div>
			<div class="modify_box">
				<form id="modifyform" name="joinform" class="form-horizontal"
					method="post"<%-- action="${pageContext.servletContext.contextPath}/modify" --%>>
					<div class="form-group">
						<label class="col-sm-3 control-label" for="inputId">아이디</label>
						<div class="col-sm-6">
							<div id="inputid-form">
								<input class="form-control" id="ModifyinputId" name="id"
									type="text" value="${userVo.id}"
									placeholder="아이디는 대/소문자,숫자  조합  4~20자 사이 " style="display:;"
									readonly> <i id="check-image" class="fa fa-check"
									aria-hidden="true" style="display: none;">확인</i>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label" for="inputPassword">비밀번호</label>
						<div class="col-sm-6">
							<button id="reset_password" class="btn btn-primary" type="button">
								비밀번호 초기화 &nbsp;<i class="fa fa-check spaceLeft"></i>
							</button>
							 <i id="passwordReset-image" class="fa fa-check" aria-hidden="true" style="display: none;">메일 발송 완료</i>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-3 control-label" for="inputName">이름</label>
						<div class="col-sm-6">
							<input class="form-control" id="inputName" name="name"
								value="${userVo.name}" type="text" placeholder="이름">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label" for="inputDepartment">소속</label>
						<div class="col-sm-6">
							<div class="input-group">
								<select class="form-control" id="inputDepartment" name="dept">
											<option value="영업 1팀">영업 1팀</option>
											<option value="영업 2팀">영업 2팀</option>
											<option value="영업 3팀">영업 3팀</option>
											<option value="영업 4팀">영업 4팀</option>
											<option value="영업 5팀">영업 5팀</option>
											<option value="영업 6팀">영업 6팀</option>
											<option value="영업 7팀">영업 7팀</option>
								</select>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label" for="inputGrade">직급</label>
						<div class="col-sm-6">
							<div class="input-group">
								<select class="form-control" id="inputGrade" name="grade">
											<option value="부장">부장</option>
											<option value="차장">차장</option>
											<option value="과장">과장</option>
											<option value="대리">대리</option>
											<option value="사원">사원 </option>
									</select>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label" for="inputGrade"></label>
						<div id="modify_button">
							<button id="modify_delete_button" class="btn btn-danger"
								type="button">
								<i class="fa fa-times spaceLeft"></i>&nbsp;탈퇴하기
							</button>
							<button id="modify_confirm_button" class="btn btn-primary"
								type="button">
								수정하기 &nbsp;<i class="fa fa-check spaceLeft"></i>
							</button>
							<button id="modify_cancel_button" class="btn btn-primary"
								type="button"
								onClick="location.href='http://localhost:8080/sfa/main'">
								취소</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</article>
	<main>
</body>
</html>