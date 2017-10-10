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
<c:import url="/WEB-INF/views/common/common.jsp"></c:import>

<script type="text/javascript">

$(function(){
	$( "#login_form" ).submit( function(){
		
		//1. ���̵� ����ִ� �� üũ
		if( $( "#id" ).val() == "" ) {
				alert("���̵� ���ּ���.");
				$( "#id" ).focus();				
			return false;
		}
		
		//2. ��й�ȣ ����ִ���üũ
		if( $("#password").val() == "" ) {
			alert("��й�ȣ�� ���ּ���.");
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
						<p class="large">"�Ϸ��Ϸ縦 ��� �����°��� ���� �츮�� �λ��� �����ȴ�."</p>
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
					  			���̵� �Ǵ� ��й�ȣ�� �ٽ� Ȯ���ϼ���.
					  			<br>
								��ϵ��� ���� ���̵��̰ų�, ���̵� �Ǵ� ��й�ȣ�� �߸� �Է��ϼ̽��ϴ�.
					  		</p>
					  	</c:if>
					  	<input id="login_button" type="submit" class="btn btn-default" value="Login">
					  </div>
					  <div class="search_uesrinfo">
						<a id="search_userid" href="${pageContext.servletContext.contextPath}/search" class="btn btn-info"  target="_blank" width=500, sheight=300>ID ã��/PW ã��</a>
					  </div>
					</form>
				</div>
	 		</div>
	 	</div>			
	</div>
</body>
</html>