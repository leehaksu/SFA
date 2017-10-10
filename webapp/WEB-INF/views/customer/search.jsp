<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:import url="/WEB-INF/views/common/common.jsp"></c:import>
</head>
<body>
	<nav class="navbar navbar-default"> <c:import
		url="/WEB-INF/views/include/header.jsp">
		<c:param name="menu" value="main" />
	</c:import> </nav>
	<div id="wrapper">
		<div id="sidebar-wrapper">
			<c:import url="/WEB-INF/views/include/navigator.jsp">
				<c:param name="menu" value="main" />
			</c:import>
		</div>
	</div>
	<main id="page-content-wrapper" role="main">
	<div class="container" style="margin-left: 18%;">
		<br>
		<h3>�� ��ȸ</h3>
		<hr>
		<div class="search_wrap">
			<div class="search_list">
				<ul>
					<li class="all"><input class="ng-all" type="text"
						placeholder="����"></li>
					<li class="btn_group"><a href="#" class="button" type="button">�߰�</a>
						<a href="#" class="button" type="button">�˻�</a></li>
					<li><select name="ng-valid" class="ng-valid">
							<option value="������" selected>������</option>
							<option value="��Ʈ��">��Ʈ��</option>
							<option value="��Ʈ�ʻ�">��Ʈ�ʻ�</option>
					</select></li>
					<li><select name="ng-valid" class="ng-valid">
							<option value="�����" selected>�����</option>
							<option value="��븮">��Ʈ��</option>
							<option value="������">��Ʈ�ʻ�</option>
					</select></li>
				</ul>
			</div>
			<div class="search_mt">
				<div class="left">
					<span class="ng-binding">0��</span>
				</div>
				<div class="right">
					<a class="on" href="#">����� ��</a> <a class="on" href="#">���� ��</a> <a
						class="on default" href="#">������ ��</a>
				</div>
			</div>
		</div>
		<hr>
		<div>
			<h4>�˸��� ����</h4>
			<small>����� ���۱� �Ŵ�浿 <i class="glyphicon glyphicon-map-marker"> </i>
			</small>
			<p>
				<i class="fa fa-user" aria-hidden="true"></i>�����:����<br />
				<i class="glyphicon glyphicon-envelope"></i>email@example.com <br />
				<i class="fa fa-phone" aria-hidden="true"></i>010-1234-5678
			</p>

		</div>
	</div>
	</main>
</body>
</html>