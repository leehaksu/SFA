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
<!-- Start of Body -->
<div class="id_pw_wrap">
	<div class="find-id-table">
		<h3>아이디 찾기</h3>
		<span class="desc">회원가입시 입력한 정보를 이용해 아이디를 찾을 수 있습니다.</span>
		<form name="frm" id="w_frm">
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
							<input name="user_name" class="find-input-name"type="text">
						</td>
						<td class="cell-button" rowspan="2">
							<button class="button-check" type="button">확인</button>
						</td>
					</tr>
					<tr>
						<th scope="row">이메일</th>
						<td>
							<input name="user_keyword" class="find-input-name" type="text" >
						</td>
					</tr>
				</tbody>
			</table>
		</form>

		<div class="find_id">
			<p>
				회원님의 아이디는 <a href="#">RERE***</a>입니다
			</p>
		</div>
		<div class="list_butt">
			<ul class="link_list">
				<li><a href="#" class="btn btn-default">로그인</a></li>
			</ul>
		</div>
	</div>

	<div class="find-pw-table">
		<h3>비밀번호 찾기</h3>
		<span class="desc">회원가입시 입력한 정보를 이용해 비밀번호를 찾을 수 있습니다.</span>

		<form name="frm" id="w_frm">
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
							<input name="user_name" class="find-input-name" type="text">
						</td>
						<td class="cell-button" rowspan="2">
							<button class="button-check" type="button">확인</button>
						</td>
					</tr>
					<tr>
						<th scope="row">이름</th>
						<td>
							<input name="user_keyword" class="find-input-name" type="text" >
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<div class="find_id">
			<p>
				회원님의 비밀번호는 <br/><a href="#">RERE@naver.com</a> 이메일로 발송되었습니다.
			</p>
		</div>
		<div class="list_butt">
			<ul class="link_list">
				<li><a href="#" class="btn btn-default">로그인</a></li>
			</ul>
		</div>
	</div>
</div>
</body>