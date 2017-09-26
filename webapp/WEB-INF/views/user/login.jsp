<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<title>SaleForceAutomation</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">

		<script  src="http://code.jquery.com/jquery-1.12.4.js"></script>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

		<!-- Optional theme -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

		<!-- Latest compiled and minified JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
		<script src="https://use.fontawesome.com/f8c7f597cb.js"></script>
		<!-- <link rel="stylesheet" href="animate.css"> -->
		<script src="${pageContext.servletContext.contextPath}/assets/js/jquery-3.2.1.js"></script>
		<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath}/assets/css/login.css">
		

<script type="text/javascript">

$(function(){
	$( "#login_form" ).submit( function(){
		
		//1. 아이디가 비어있는 지 체크
		if( $( "#id" ).val() == "" ) {
				alert("아이디를 써주세요.");
				$( "#id" ).focus();				
			return false;
		}
		
		//2. 비밀번호 비어있는지체크
		if( $("#password").val() == "" ) {
			alert("비밀번호를 써주세요.");
					$( "#password" ).focus();			
			return false;
		}
		return true;
	});
});

</script>

</head>
<body>
	<div class="container-fluid">
		<div id ="company-name">
	 		<div class="company_wrap">
				<h3>Sale Force Automation</h3>
				
				<div class="login_box">
					<div id="positive-line">
						<p class="large">
					 		"하루하루를 어떻게 보내는가에 따라 우리의 인생이 결정된다."
						</p>
					</div>
					<form id="login_form" name="loginform" action="${pageContext.servletContext.contextPath}/user/auth" method="POST" >
					  <div class="input-group">
					    <input id="site" type="hidden" class="form-control" name="site">
					  </div>
					  <div class="input-group">
					    <input id="id" type="text" class="form-control" name="id"  placeholder="ID">
					  </div>
					  <div class="input-group">
					    <input id="passwd" type="password" class="form-control" name="passwd" placeholder="Password">
					  </div>
					  <div class="input-group">
					  	<c:if test='${result == "fail" or param.result == "fail"}'>
					  		<p>
					  			아이디 또는 비밀번호를 다시 확인하세요.
					  			<br>
								등록되지 않은 아이디이거나, 아이디 또는 비밀번호를 잘못 입력하셨습니다.
					  		</p>
					  	</c:if>
					  	<input id="login_button" type="submit" class="btn btn-default" value="Login">
					  </div>
					  <div class="search_uesrinfo">
						<a id="search_userid" href="#" class="btn btn-info" role="button" target="_blank">ID 찾기</a>
						<a id="search_userpw" href="#" class="btn btn-info" role="button" target="_blank">PW 찾기</a>	
					  </div>
					</form>
				</div>
	 		</div>
	 	</div>			
	</div>
</body>
</html>