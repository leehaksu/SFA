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
//현재 날짜를 moment.js를 활용하여 "YYYY-MM-DD"형식으로 받아온다.
var today = moment().format("YYYY-MM-DD");



$(document).ready(function() {
	advicecount=0;   //상담일지 개수 확인
	$("#start-date").val(today);
	$("#end-date").val(today);
	
	//report리스트들의 li 크기를 각각 내용에 따라 맞춰주기
	var min_parent_height = jQuery(".report-list").height()+"px";
	jQuery("#report-thumnail").css({'min-height':min_parent_height});
	
	$( "#start-date" ).datepicker({
		defaultDate: null,
		dateFormat: 'yy-mm-dd', 
	    beforeShow: function(input, inst) {
	    	var offset = $(input).offset();
	        var height = $(input).height();
	         window.setTimeout(function () {
	             inst.dpDiv.css({ top: (offset.top + height + 4) + 'px', left: offset.left + 'px' })}, 1);
	    },
		onSelect: function(dateText,inst){
			$("#start-date").val(dateText);
		}
	});
	
	$( "#end-date" ).datepicker({
		defaultDate: null,
		dateFormat: 'yy-mm-dd', 
	    beforeShow: function(input, inst) {
	    	var offset = $(input).offset();
	         var height = $(input).height();
	         window.setTimeout(function () {
	             inst.dpDiv.css({ top: (offset.top + height + 4) + 'px', left: offset.left + 'px' })
	         }, 1);
	    },
		onSelect: function(dateText,inst){
			$("#end-date").val(dateText);
		}		
	});
	
	$("#search-report").on("click", function(){
		var date1 = $("#end-date").val();
		var date2 = $("#start-date").val();

		var approval=$("#approval option:selected").val();
		console.log(approval);
		
		if(moment(date2).isBefore(date1)){
			var temp= date1;
				date1=date2;
				date2=temp;
		}
		
		 $.post("search",
		    {
			 startDate: date1,
			 endDate: date2,
			 approval: approval
		    },
		    function(response, status){
		        console.log(response.data);
		        $("#content > ul").empty();
		        if(response.data==null)
		       {
		        	$("#search-count").html("조회: 0건");
		       }else
		    	   {
		    	   $("#search-count").html("조회: "+ response.data.length+" 건");
			        
			        for(i=0; i<response.data.length;i++){	
			        	$("#content > ul").append('<li class="report-thumnail"></li>');
			        	$("#content > ul > li").eq(i).append('<a class="report-detail hvr-wobble-horizontal" href="${pageContext.servletContext.contextPath}/report/search?report_no='+response.data.report_no+'"></a>');		        	
			        	        	
			        	if(response.data[i].approval == 0){
			        		$(".report-detail").eq(i).append('<img class="report-state" src="${pageContext.servletContext.contextPath}/assets/image/write.png" alt="레포트 상태 이미지">');		
			        	}else if(response.data[i].approval == 1){
			        		$(".report-detail").eq(i).append('<img class="report-state" src="${pageContext.servletContext.contextPath}/assets/image/review.png" alt="레포트 상태 이미지">');		
	 		        	}else if(response.data[i].approval == 2){
			        		$(".report-detail").eq(i).append('<img class="report-state" src="${pageContext.servletContext.contextPath}/assets/image/approve.png" alt="레포트 상태 이미지">');		
			        	}else{
			        		$(".report-detail").eq(i).append('<img class="report-state" src="${pageContext.servletContext.contextPath}/assets/image/reject.png" alt="레포트 상태 이미지">');		
			        	}
			        	
			        	var opinion =response.data[i].opinion;
			        	if(opinion == null){
			        		opinion ="";		
			        	}
			        	$(".report-detail").eq(i).append('<table class="table report-list"><thead><tr><th>보고 일자:'+response.data[i].date+'</th></tr></thead><tbody><tr><td>제목: '+response.data[i].title+'</td></tr><tr><td>작성일자: '+response.data[i].reg_date+'</td></tr><tr><td>팀장의견: '+opinion+'</td></tr></tbody></table>');
			        	
			        	
			        	
			        	if(response.data[i].approval == 0){
			            	$("#content > ul > li").eq(i).append('<div><button type="button" class="btn btn-default submit-btn hvr-shadow-radial">제출</button> <form class="reportnoform" action="submit" method="POST"><input type="hidden" id="report_no" name="report_no" value="'+response.data[i].report_no+'"><input type="hidden" id="approval" name="approval" value=1></form>');		
			        	}else if(response.data[i].approval == 1){
			            	$("#content > ul > li").eq(i).append('<div><div class="btn btn-default report-stat">제출 완료</div></div>');		
	 		        	}else if(response.data[i].approval == 2){
	 		        		$("#content > ul > li").eq(i).append('<div><div class="btn btn-default report-stat">승인 완료</div></div>');		
			        	}else{
			        		$("#content > ul > li").eq(i).append('<div><div class="btn btn-default report-stat">반려</div></div>'); 
			        	}
			        }
		    	   }
		        
		        $(".report-thumnail").css({"border": "1px solid gray","overflow": "hidden"});
		        $(".report-detail").css({"float": "left", "width": "100%"});
		        $(".report-state").css({"width": "77px", "float": "left"});
		        $(".report-list").css({"margin-left": "100px", "width": "auto"});
		        $(".submit-btn").css({"margin-left": "-100px", "float": "right", "z-index": "100", "margin-top": "25px", "position": "absolute"});
		        $(".report-stat").css({"margin-left": "-100px", "float": "right", "z-index": "100", "margin-top": "25px", "position": "absolute"});
		         
		    });
	});
	
	$(".submit-btn").click(function(){
		var form = $(this).next();
		console.log(form);
		form.submit();
	})
	$(document).on("click",".submit-btn",function(){
		var form = $(this).next();
		console.log(form);
 		form.submit();
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
	<div class="content-header">
		<h3>
			<strong>보고서 조회</strong>
		</h3>
	</div>
	<article id="reportsearch-content">
		<div>
			<button type="button" class="btn btn-default"
				onclick="location.href='insert'"
				style="float: right; display: inline-block;">보고서 추가</button>
		</div>
		<form>
			<table
				style="border-spacing: 20px 0; border-collapse: separate; margin-top: 10px;">
				<tr>
					<td><label for="start-date"></label><input id="start-date"
						class="form-control"></td>
					<td><h4>~</h4></td>
					<td><label for="end-date"></label><input id="end-date"
						class="form-control"></td>
					<td><select class="form-control" id="approval">
							<option value="4" selected>전체</option>
							<option value="2">승인</option>
							<option value="1">제출</option>
							<option value="0">미제출</option>
							<option value="3">반려</option>
					</select></td>
					<td>
						<button id="search-report" type="button" class="btn btn-default">조회</button>
					</td>
				</tr>
			</table>
		</form>
		<p></p>
		<div id="search-count">조회: ${fn:length(list)} 건</div>
		<hr>
	</article>
	<article>
		<div id="report-content">
			<ul>
				<c:forEach items="${list}" var="dayreportVo" varStatus="status">
					<li id="report-thumnail"
						style="border: 1px solid gray; overflow: hidden;"><a
						href="${pageContext.servletContext.contextPath}/report/detail?report_no=${dayreportVo.report_no}"
						class="hvr-wobble-horizontal" style="float: left; width: 100%;">
							<c:choose>
								<c:when test="${dayreportVo.approval == 0}">
									<img
										src="${pageContext.servletContext.contextPath}/assets/image/write.png"
										alt="승인/미승인 이미지" style="width: 77px; float: left">
								</c:when>
								<c:when test="${dayreportVo.approval == 1}">
									<img
										src="${pageContext.servletContext.contextPath}/assets/image/review.png"
										alt="승인/미승인 이미지" style="width: 77px; float: left">
								</c:when>
								<c:when test="${dayreportVo.approval == 2}">
									<img
										src="${pageContext.servletContext.contextPath}/assets/image/approve.png"
										alt="승인/미승인 이미지" style="width: 77px; float: left">
								</c:when>
								<c:otherwise>
									<img
										src="${pageContext.servletContext.contextPath}/assets/image/reject.png"
										alt="승인/미승인 이미지" style="width: 77px; float: left">
								</c:otherwise>
							</c:choose>
							<table class="table report-list"
								style="margin-left: 100px; width: auto;">
								<thead>
									<tr>
										<th>보고 일자:${dayreportVo.date}</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>제목: ${dayreportVo.title}</td>
									</tr>
									<tr>
										<td>작성일자: ${dayreportVo.reg_date}</td>
									</tr>
									<tr>
										<td>팀장의견: ${dayreportVo.opinion}</td>
									</tr>
									<!-- 팀장 페이지에서 조회엔 누가 썻는지 알아야 하므로 부서,이름,직급이 표기 되어야 하기 때문에 tr이 한줄 더 필요하다. -->
								</tbody>
							</table>
					</a> <c:choose>
							<c:when test="${dayreportVo.approval == 0}">
								<div>
									<button type="button"
										class="btn btn-default submit-btn hvr-shadow-radial"
										style="margin-left: -100px; float: right; z-index: 100; margin-top: 25px; position: absolute;">제출</button>
									<form class="reportnoform" action="submit" method="POST">
										<input type="hidden" id="report_no" name="report_no"
											value="${dayreportVo.report_no}"> <input
											type="hidden" id="approval" name="approval" value=1>
									</form>
								</div>
							</c:when>
							<c:when test="${dayreportVo.approval == 1}">
								<div>
									<div class="btn btn-default report-stat"
										style="margin-left: -100px; float: right; z-index: 100; margin-top: 25px; position: absolute;">제출
										완료</div>
								</div>
							</c:when>
							<c:when test="${dayreportVo.approval == 2}">
								<div>
									<div class="btn btn-default report-stat"
										style="margin-left: -100px; float: right; z-index: 100; margin-top: 25px; position: absolute;">승인
										완료</div>
								</div>
							</c:when>
							<c:otherwise>
								<div>
									<div class="btn btn-default report-stat"
										style="margin-left: -100px; float: right; z-index: 100; margin-top: 25px; position: absolute;">반려됨</div>
								</div>
							</c:otherwise>
						</c:choose></li>
				</c:forEach>
			</ul>
		</div>
	</article>
	</main>
</body>
</html>