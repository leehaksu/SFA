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
	$("#searchbutton").on("click",function(){
		var name=$("#customerName").val();
		
		$.get("search/name?name="+name, function(data, status){
	        console.log(data );
			if( data.result == "error")
			{
				alert(data.message);
			}
	    }).fail(function() {
	        alert( "error 발생 다시 시도해 주세요" );
	    });
	})
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
	<div class="panel-info">
		<div class="content-header panel-heading">
			<h3 >
				<strong>고객 조회</strong>
			</h3>
		</div>
		<div class="search_wrap">
			<div class="search_list">
				<ul>
					<li class="all"><input class="ng-all" type="text" id="customerName"
						placeholder="고객명">
						 <a href="#" id="searchbutton" class="button" type="button">검색</a>
						 <a href="${pageContext.servletContext.contextPath}/customer/insert" class="button" type="button">추가</a>
					</li>
				</ul>
			</div>
			<div class="search_mt">
				<div class="left">
				<c:set var = "len" value = "${fn:length(list)}" />
					<span class="ng-binding">${len} 건</span>
				</div>
			
			</div>
		</div>
		<hr>
		
		<c:forEach items="${list}" var="customerVo" varStatus="status">
		<div id="customer-info" class="well">
			<a href="${pageContext.servletContext.contextPath}/customer/detail?customer_code=${customerVo.customer_code}">
			<h4>${customerVo.name}</h4>
			<small>${customerVo.address}<i class="glyphicon glyphicon-map-marker"></i>			
			</small>
			<p>
				<i class="fa fa-user" aria-hidden="true"></i>담당자:${customerVo.manager_name}<br/> <i
					class="glyphicon glyphicon-envelope"></i>${customerVo.manager_email} <br />
				<i class="fa fa-phone" aria-hidden="true"></i>${customerVo.manager_contact}
			</p>
			</a>
		</div>
		</c:forEach>
		<%-- <c:forEach items="${customerList}" var="dayreportVo" varStatus="status">
		<div id="customer-info" class="well">
			<a href="${pageContext.servletContext.contextPath}/customer/customer_detail">
			<h4>${customerlist.name}</h4>
			<small>${customerlist.address}<i class="glyphicon glyphicon-map-marker"></i>			
			</small>
			<p>
				<i class="fa fa-user" aria-hidden="true"></i>담당자:${customerlist.manager_name}<br /> <i
					class="glyphicon glyphicon-envelope"></i>${customerlist.manager_email} <br />
				<i class="fa fa-phone" aria-hidden="true"></i>${customerlist.manager_contact}
			</p>
			</a>
		</div>
		</c:forEach> --%>
	</div>
	</main>

</body>
</html>