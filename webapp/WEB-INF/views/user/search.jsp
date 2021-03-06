<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<c:import url="/WEB-INF/views/common/uncommon.jsp"></c:import>
 <script>
 	$(document).ready(function(){
 		$("#id-info").hide();
 		$("#pw-info").hide();
 		 
 		$("#id-find-button").on("click",function(){
 			var name=$("#find-id-name").val();
 			var email=$("#find-id-email").val();
 			var id=$().val();
 			console.log(name);
 			console.log(email);
 			
 			$.post("search/id",
 					{"name":name,
 					 "email":email
 						},
 			function(data,status){
 				 console.log(data);
 			var receive_id=data.data;
 			 $("#id-info").html("회원님의 아이디는 <strong>"+receive_id+"</strong>입니다");
 			console.log(data.data);
 		   	}).done(function() {
 			  $("#id-info").show();
 	
 		   	  })
 			  .fail(function() {
 			    alert( "조회 실패" );
 			  });

 		});
		$("#pw-find-button").on("click",function(){
 			var id=$("#find-pw-id").val();
 			var email=$("#find-pw-email").val();
 			
			$.post("search/pw",
					{"id":id,
				 	 "email":email
					},
 			function(data,status){
 				 console.log(data+","+status);
 				var email=data.data;
 				$("#pw-info").html("회원님의 임시 비밀번호는 <br/><strong>"+email+"</strong> 이메일로 발송되었습니다.");
 		   	}).done(function() {
 			  $("#pw-info").show();			  
 		   	  })
 			  .fail(function() {
 			    alert( "조회 실패" );
 			  });
 		});
 	});
 </script>
 </head>
<body>
<!-- Start of Body -->
<div class="id_pw_wrap">
	<div class="find-id-table">
		<h3>아이디 찾기</h3>
		<span class="desc">회원가입시 입력한 정보를 이용해 아이디를 찾을 수 있습니다.</span>
		<form name="userid_search" >
			<table>
				<colgroup>
					<col class="col-title">
					<col class="col-input">
					<col class="col-button">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">이름</th>
						<td>
							<input id="find-id-name" name="user_name" class="find-input-id"type="text">
						</td>
						<td class="cell-button" rowspan="2">
							<button id="id-find-button" class="button-check" type="button">확인</button>
						</td>
					</tr>
					<tr>
						<th scope="row">이메일</th>
						<td>
							<input id="find-id-email" name="user_keyword" class="find-input-id" type="text" >
						</td>
					</tr>
				</tbody>
			</table>
		</form>

		<div class="find_id">
			<p id="id-info">
			</p>
		</div>
		<div class="list_butt">
		<a href="login" class="btn btn-info">로그인</a>
		</div>
	</div>

	<div class="find-pw-table">
		<h3>비밀번호 찾기</h3>
		<span class="desc">회원가입시 입력한 정보를 이용해 비밀번호를 찾을 수 있습니다.</span>

		<form name="userpw_search" >
			<table>
				<colgroup>
					<col class="col-title">
					<col class="col-input">
					<col class="col-button">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">아이디</th>
						<td>
							<input id="find-pw-id" name="user_name" class="find-input-pw" type="text">
						</td>
						<td class="cell-button" rowspan="2">
 							<button id="pw-find-button" class="button-check" type="button">확인</button>
						</td>
					</tr>
					<tr>
						<th scope="row">이메일</th>
						<td>
							<input id="find-pw-email" name="user_keyword" class="find-input-pw" type="text" >
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<div class="find_id">
			<p id="pw-info">
				회원님의 비밀번호는 <br/><strong>RERE@naver.com</strong> 이메일로 발송되었습니다.
			</p>
		</div>
	 <div class="list_butt">
		<a href="login" class="btn btn-info">로그인</a>
		</div> 
	</div>
</div>
</body>