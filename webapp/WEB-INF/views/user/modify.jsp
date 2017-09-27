<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>SaleForceAutomation</title>

<!-- Bootstrap -->
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/assets/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.servletContext.contextPath}/assets/css/main.css">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/assets/css/bootstrap-theme.min.css">
<link rel='stylesheet'
	href="${pageContext.servletContext.contextPath}/assets/css/join.css" />

<script
	src="${pageContext.servletContext.contextPath}/assets/js/jquery-3.2.1.js"></script>
<!-- Latest compiled and minified JavaScript -->
<script
	src="${pageContext.servletContext.contextPath}/assets/js/bootstrap.min.js"></script>
<script
	src="${pageContext.servletContext.contextPath}/assets/js/moment.js"></script>
<script
	src="${pageContext.servletContext.contextPath}/assets/js/fullcalendar.js"></script>
<script type="text/javascript"
	src="${pageContext.servletContext.contextPath}/assets/js/ko.js"></script>
<script src="https://use.fontawesome.com/f8c7f597cb.js"></script>

<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>

<!-- Noty 라이브러리(noty.js, noty.css,bounce.js 다운 받아져 있음) -->
<link
	href="${pageContext.servletContext.contextPath}/assets/css/noty/noty.css"
	rel="stylesheet">
<script
	src="${pageContext.servletContext.contextPath}/assets/js/noty/noty.js"
	type="text/javascript"></script>
<!-- mo.js 파일 다운로드 -->
<script src="//cdn.jsdelivr.net/mojs/latest/mo.min.js"></script>

<script
	src="${pageContext.servletContext.contextPath}/assets/js/push.min.js"
	type="text/javascript"></script>
<script>
	var reg_uid = /^[A-Za-z]{1}[A-Za-z0-9]{3,19}$/;
	var reg_upw = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-]|.*[0-9]).{8,24}$/;
	var check = false;
	var password_check = false;
	$(document)
			.ready(
					function() {
						// 비밀번호,비밀번호 찾기 화면 숨기기
						$("#modify_inputPassword").hide();
						$("#password_container").hide();

						$("#reset_password").click(function() {
							check = true;
							$("#modify_inputPassword").show();
							$("#password_container").show();
							console.log(check);
						});

						password_check = $("#modify_confirm_button")
								.click(
										function() {
											console.log(check);
											if (check == true) {
												//2. 비밀번호가 비어있는지 체크   
												if ($("#modify_inputPassword")
														.val() == "") {
													alert("비밀번호가 비어있습니다.");
													$("#modify_inputPassword")
															.focus()
													return false;
												}
												//2-2 비밀번호 조건 체크 
												if (reg_upw
														.test($(
																"#modify_inputPassword")
																.val()) != true) {
													alert("비밀번호는 숫자, 특수문자 포함 8자 이상이어야 합니다.");
													return false;
												}

												//3. 비밀번호 확인이 비어있는지 체크 
												if ($(
														"#modify_inputPasswordcheck")
														.val() == "") {
													alert("비밀번호 확인 부탁드립니다.");
													$(
															"#modify_inputPasswordcheck")
															.focus();
													return false;
												}
											}

											//4. 이름이 비어있는지 체크 
											if ($("#inputName").val() == "") {
												alert("이름이 비어있습니다.");
												$("#inputName").focus();
												return false;
											}
											return true;
										});

						//비밀번호 변경시 비밀번호 확인 칸 초기화
						$("#modify_inputPassword").focusin(function() {
							$("#modify_inputPasswordcheck").val("");
						});
						$("#modify_inputPasswordcheck")
								.keyup(
										function() {
											//3-1. 비밀번호와 비밀번호 체크 비교
											if ($("#modify_inputPassword")
													.val() != $(
													"#modify_inputPasswordcheck")
													.val()) {
												//alert("비밀번호와 비밀번호 확인이  일치하지 않습니다.");
												//$("#inputPassword").val("");
												//$("#inputPasswordCheck").val("");
												$("#passwordcheck").show();
												//$("#inputPassword").focus();
												return false;
											} else {
												$("#passwordcheck").hide();
											}
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
	<article>
		<div id="join_container">
			<div class="pageheader">
				<h3>정보 수정</h3>
			</div>
			<div class="pagedetailHeader">
				<h4>${userVo.id}님의사원정보입니다.</h4>
				<h5>사원정보는 개인정보처리방침에 따라 안전하게 보호되며, ${userVo.id}님의 명백한 동의 없이 공개
					또는 제 3자에게 제공되지 않습니다.</h5>
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
							<input class="form-control" id="modify_inputPassword"
								name="passwd" type="password"
								placeholder="비밀번호는 숫자, 특수문자 포함 8자 이상" style="width: 56%;">
							<button id="reset_password" class="btn btn-primary" type="button">
								비밀번호 초기화 &nbsp;<i class="fa fa-check spaceLeft"></i>
							</button>
						</div>
					</div>
					<div id="password_container" class="form-group">
						<label class="col-sm-3 control-label" for="inputPasswordCheck">비밀번호
							확인</label>
						<div class="col-sm-6">
							<input class="form-control" id="modify_inputPasswordcheck"
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
								value="${userVo.name}" type="text" placeholder="이름">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label" for="inputDepartment">소속</label>
						<div class="col-sm-6">
							<div class="input-group">
								<select class="form-control" id="inputDepartment" name="dept"
									placeholder="소속을 선택해 주세요">
									<c:choose>
										<c:when test='${userVo.dept=="영업1팀" || userVo.dept=="영업 1팀"}'>
											<option selected="selected">영업 1팀</option>
											<option>영업 2팀</option>
											<option>영업 3팀</option>
											<option>영업 4팀</option>
											<option>영업 5팀</option>
											<option>영업 6팀</option>
											<option>영업 7팀</option>
										</c:when>
										<c:when test="${userVo.dept=='영업2팀' || userVo.dept=='영업 2팀'}">
											<option>영업 1팀</option>
											<option selected="selected">영업 2팀</option>
											<option>영업 3팀</option>
											<option>영업 4팀</option>
											<option>영업 5팀</option>
											<option>영업 6팀</option>
											<option>영업 7팀</option>
										</c:when>
										<c:when test="${userVo.dept=='영업3팀' || userVo.dept=='영업 3팀' }">
											<option>영업 1팀</option>
											<option>영업 2팀</option>
											<option selected="selected">영업 3팀</option>
											<option>영업 4팀</option>
											<option>영업 5팀</option>
											<option>영업 6팀</option>
											<option>영업 7팀</option>
										</c:when>
										<c:when test="${userVo.dept=='영업4팀'|| userVo.dept=='영업 4팀'}">
											<option>영업 1팀</option>
											<option>영업 2팀</option>
											<option>영업 3팀</option>
											<option selected="selected">영업 4팀</option>
											<option>영업 5팀</option>
											<option>영업 6팀</option>
											<option>영업 7팀</option>
										</c:when>
										<c:when test="${userVo.dept=='영업5팀' || userVo.dept=='영업 5팀'}">
											<option>영업 1팀</option>
											<option>영업 2팀</option>
											<option>영업 3팀</option>
											<option>영업 4팀</option>
											<option selected="selected">영업 5팀</option>
											<option>영업 6팀</option>
											<option>영업 7팀</option>
										</c:when>
										<c:when test="${userVo.dept=='영업6팀' || userVo.dept=='영업 6팀'}">
											<option>영업 1팀</option>
											<option>영업 2팀</option>
											<option>영업 3팀</option>
											<option>영업 4팀</option>
											<option>영업 5팀</option>
											<option selected="selected">영업 6팀</option>
											<option>영업 7팀</option>
										</c:when>
										<c:when test="${userVo.dept=='영업7팀' || userVo.dept=='영업 7팀'}">
											<option>영업 1팀</option>
											<option>영업 2팀</option>
											<option>영업 3팀</option>
											<option>영업 4팀</option>
											<option>영업 5팀</option>
											<option>영업 6팀</option>
											<option selected="selected">영업 7팀</option>
										</c:when>
									</c:choose>
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
									<c:choose>
										<c:when test="${userVo.grade=='부장'}">
											<option selected="selected">부장</option>
											<option>차장</option>
											<option>과장</option>
											<option>대리</option>
											<option>사원 </option>
										</c:when>
										<c:when test="${userVo.grade=='차장'}">
											<option>부장</option>
											<option selected="selected">차장</option>
											<option>과장</option>
											<option>대리</option>
											<option>사원 </option>
										</c:when>
										<c:when test="${userVo.grade=='과장'}">
											<option>부장</option>
											<option>차장</option>
											<option selected="selected">과장</option>
											<option>대리</option>
											<option>사원 </option>
										</c:when>
										<c:when test="${userVo.grade=='대리'}">
											<option>부장</option>
											<option>차장</option>
											<option>과장</option>
											<option selected="selected">대리</option>
											<option>사원 </option>
										</c:when>
										<c:when test="${userVo.grade=='사원'}">
											<option>부장</option>
											<option>차장</option>
											<option>과장</option>
											<option>대리</option>
											<option selected="selected">사원 </option>
										</c:when>
									</c:choose>
								</select>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label" for="inputGrade"></label>
						<div class="col-sm-6" id="modify_button">
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
</body>
</html>