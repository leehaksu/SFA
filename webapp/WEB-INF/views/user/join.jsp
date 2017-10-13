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
		
	$(document).ready(function(){
		$("#Idcheck-button").click(function() {
			var id = $("#inputId").val();
			
			console.log(id+"입니다");
			
			if (typeof id == "undefined" || id == null || id == "") {
				alert("아이디가 입력되지 않았습니다. 다시 확인해 주세요.");
				return;
			}
			
			if (reg_uid.test(id) != true) {
				alert("아이디 형식이 잘못 되었습니다. 다시 확인해 주세요.");
				return ;
			}

			//ajax 통신
			$.ajax({
				url : "/sfa/check?id=" + id,
				type : "get",
				dataType : "json",
				success : function(response) {

					// 통신 에러(서버 에러)
					if (response.result == "error") {
						//console.log(response.message);
						return;
					}

					if (response.result == "success") {
						alert("이미 존재하는 아이디 입니다.");
						$("#inputId").val("");
						$("#inputId").focus();
						idcheck=false;
					} else {
						alert("사용 가능한 아이디 입니다.");
						$("#Idcheck-image").show();
						$("#Idcheck-button").hide();
						idcheck=true;
					}
				},
				error : function(jqXHR, status, error) {
					console.error(status + " : " + error);
				}
			});
		});
		
		$("#Emailcheck-button").click(function() {
			var email = $("#inputEmail").val();
			
			if (typeof email == "undefined" || email == null || email == "") {
				alert("이메일 입력되지 않았습니다. 다시 확인해 주세요.");
				return;
			}
			
			if (reg_email.test(email) != true) {
				alert("이메일 형식이 잘못 되었습니다. 다시 확인해 주세요.");
				return "";
			}

			//ajax 통신
			$.ajax({
				url : "/sfa/checkEmail?email="+email,
				type : "GET",
				dataType : "json",
				data : "",
				success : function(response) {

					// 통신 에러(서버 에러)
					if (response.result == "error") {
						console.log(response.message);
						return;
					}

					if (response.result == "fail") {
						alert("이미 존재하는 이메일 입니다.");
						$("#inputEmail").val("");
						$("#inputEmail").focus();	
						emailcheck=false;
					} else {
						alert("사용 가능한 이메일 입니다.");	
						$("#Emailcheck-image").show();
						$("#Emailcheck-button").hide();
						emailcheck=true;
					}
				},
				error : function(jqXHR, status, error) {
					console.error(status + " : " + error);
				}
			});
		});	
		
		$("#inputId").change(function(){
			$("#Idcheck-button").show();
			$("#Idcheck-image").hide();	
			idcheck= false;
		});
		
		$("#inputEmail").change(function(){
			$("#Emailcheck-button").show();
			$("#Emailcheck-image").hide();	
			idcheck= false;
		});
		
	//비밀번호 변경시 비밀번호 확인 칸 초기화
	$("#inputPassword").focusin(function(){
		$("#inputPasswordCheck").val("");
	});
	
	$("#inputPasswordCheck").keyup(function(){	
		//3-1. 비밀번호와 비밀번호 체크 비교
		if ($("#inputPassword").val() != $("#inputPasswordCheck").val()) {
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
						<h3><strong>회원 가입</strong></h3>
			</div>
			<div class="join_container">
				<div>
					<form name="joinform" class="form-horizontal" method="post" 
						action="${pageContext.servletContext.contextPath}/join" >
						<div class="form-group">
							<label class="col-sm-2 control-label" for="inputId">아이디</label>
							<div class="col-sm-8">
								<div id="inputid-form">
									<input class="form-control" id="inputId" name="id"
										type="text" placeholder="첫문자는 영문 대/소문자로  [숫자, 특수문자 _ 조합] 5~12자 "
										pattern="^[a-z0-9_]{5,12}$" required > 
										<i id="Idcheck-image" class="fa fa-check" aria-hidden="true" style="display: none;">확인</i>
									<input id="Idcheck-button" class="btn btn-info" type="button"
										value="중복체크">
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="inputPassword">비밀번호</label>
							<div class="col-sm-8">
								<input class="form-control" id="inputPassword" name="passwd" pattern="^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-]|.*[0-9]).{8,24}$"
									type="password" placeholder="비밀번호는 숫자, 특수문자 포함 8자 이상" required>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="inputPasswordCheck">비밀번호
								확인</label>
							<div class="col-sm-8">
								<input class="form-control" id="inputPasswordCheck"
									type="password" placeholder="비밀번호 확인" required>
								<div id="passwordcheck" style="display: none;">
									<i class='fa fa-times' aria-hidden='true'></i>
									&nbsp; 비밀번호가 일치 하지 않습니다.
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="inputName">이름</label>
							<div class="col-sm-8">
								<input class="form-control" id="inputName" name="name"
									type="text" placeholder="이름" required>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="inputEmail">이메일</label>
							<div class="col-sm-8">
								<input class="form-control" id="inputEmail" name="email"
									type="email" placeholder="이메일" required>
									<i id="Emailcheck-image" class="fa fa-check" aria-hidden="true" style="display: none;">확인</i>
									<input id="Emailcheck-button" class="btn btn-info" type="button"
										value="중복체크">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="inputDepartment">소속</label>
							<div class="col-sm-8">
								<div class="input-group">
									<select class="form-control" id="inputDepartment" name="dept"
									 required>
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
							<label class="col-sm-2 control-label" for="inputGrade">직급</label>
							<div class="col-sm-8">
								<div class="input-group">
									<select class="form-control" id="inputGrade" name="grade" required>
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
							<div class="col-sm-8 text-center">
								<button id="confirm_button" class="btn btn-primary" type="submit" onsubmit="validate()">
									회원가입 &nbsp;<i class="fa fa-check spaceLeft"></i>
								</button>
								<button id="cancel_button" class="btn btn-danger"  onClick="location.href='http://localhost:8080/sfa/';" >
									가입취소 &nbsp;<i class="fa fa-times spaceLeft"></i>
								</button>
							</div>
						</div>
					</form>
					<hr>
				</div>
			</div>
		</main>
	</body>
	</html>