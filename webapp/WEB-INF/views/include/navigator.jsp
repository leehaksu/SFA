<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
$(document).ready(function() {
	jQuery(".panel-collapse").hide();
	//content 클래스를 가진 div를 표시/숨김(토글)
	  $(".accordion-toggle").click(function()
	  {
	    $(".panel-collapse").not($(this).next(".panel-collapse").slideToggle(500)).slideUp();
	  });
	});
</script>
			<aside id="sidebar">
				<ul id="sidemenu" class="sidebar-nav">
					<li>
					<a id="menu1"
						class="accordion-toggle collapsed toggle-switch"
						data-toggle="collapse" data-target="#submenu"> <span
							class="sidebar-icon"> <i class="fa fa-calendar"
								aria-hidden="true"></i>
						</span> <span class="sidebar-title">영업 관리</span> <b class="caret"></b>
					</a>
						<ul id="submenu" class="panel-collapse collapse panel-switch"
							role="menu">
							<li><a href="${pageContext.servletContext.contextPath}/week/"><i class="fa fa-caret-right"></i>영업 계획서</a></li>
							<li><a href="${pageContext.servletContext.contextPath}/report/"><i class="fa fa-caret-right"></i>영업 보고서</a></li>
							<li><a href="#"><i class="fa fa-caret-right"></i>영업 기획서</a></li>
						</ul></li>
					<li>
					<a id="menu2"
						class="accordion-toggle collapsed toggle-switch"
						data-toggle="collapse" href="#submenu-2"> <span
							class="sidebar-icon"> <i class="fa fa-address-book-o" aria-hidden="true"></i>
						</span> <span class="sidebar-title">고객 관리</span> <b class="caret"></b>
					</a>
						<ul id="submenu-2" class="panel-collapse collapse panel-switch"
							role="menu">
							<li><a href="${pageContext.servletContext.contextPath}/customer/search"><i class="fa fa-caret-right"></i>고객 조회</a></li>
							<li><a href="${pageContext.servletContext.contextPath}/customer/insert"><i class="fa fa-caret-right"></i>고객 등록</a></li>
						</ul></li>
					<li>
					<a id="menu3"
						class="accordion-toggle collapsed toggle-switch"
						 href="${pageContext.servletContext.contextPath}/chart/"> <span
							class="sidebar-icon"><i class="fa fa-line-chart"
								aria-hidden="true"></i></span> <span class="sidebar-title">통계 현황</span>
					</a>
					</li>
					<li>
					<a id="menu4" a href="${pageContext.servletContext.contextPath}/board/"> 
						<span class="sidebar-icon">
							<i class="fa fa-bell" aria-hidden="true"></i>
						</span> 
							<span class="sidebar-title">공지사항</span>
					</a>
					</li>	
					
					<li><a id="menu5" a href="#"> 
						<span class="sidebar-icon">
							<i class="fa fa-user" aria-hidden="true"></i>
						</span> 
							<span class="sidebar-title">마이페이지</span>
					</a>
					</li>	
						
					<li><a href="#"> <span class="sidebar-icon"><i
								class="fa fa-arrow-up" aria-hidden="true"></i></span> <span
							class="sidebar-title">top</span>
					</a></li>
				</ul>
			</aside>