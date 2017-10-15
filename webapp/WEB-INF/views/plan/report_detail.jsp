<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
	$(document).ready(function() {
		
		var content ='<c:out value="${dateReportVo.content}"/>'; 
		$(function() {
			$('.date-textarea').froalaEditor({
				toolbarButtons : [ 'bold', 'italic', 'paragraphFormat' ],
				paragraphFormat : {
					N : 'Normal',
					H1 : 'Heading 1',
					H2 : 'Heading 2',
					H3 : 'Heading 3'
				}
			});
		});
		
		$('#date-textarea').froalaEditor('html.set',content);
		
			$('.date-textarea').froalaEditor('edit.off');
		$(".dayreportform-input").attr("readonly", true);
		$(".advicereporttable-input").attr("readonly", true);
		$("#submitDay-datepicker").attr("readonly", true);
	});

	function update() {
		$(".dayreportform-input").attr("readonly", false);
	}
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
	<div class="panel-info" style="clear: both; margin-top: 10px;">
		<div class="content-header panel-heading">
			<h3>
				<strong>일일 보고서</strong> 
				<span style="float: right;"> 
				<a href="#" onclick=""> 
				<i class="fa fa-pencil fa-lg" aria-hidden="true"></i>
				</a> &nbsp; <a href="#" onclick=""> 
				<i class="fa fa-trash fa-lg"aria-hidden="true"></i>
				</a>
				</span>
			</h3>
		</div>
		<div id="reportmain_content">
			<form name="dayreport" id="dayreport-form" method="post">
				<table id="dayreporttable">
					<tr id="rpt-content1">
						<td>
							<div style="display: inline-block;">
								<label class="reporttable-label" for="show-day-title">예상
									목표액&nbsp;</label> <input id="dayreporttable-goal-sale"
									class="form-control dayreportform-input" type="Number"
									name="goal_sale" placeholder="ajax통신" value="${dateReportVo.goal_sale}"
									min="0" readonly>
							</div>
						</td>
						<td>
							<div style="display: inline-block;">
								<label class="reporttable-label" for="day">매 출 액 &nbsp;</label>
								<input id="dayreporttable-report-sale"
									class="form-control dayreportform-input" type="Number"
									name="report_sale" placeholder="일일 매출액"
									onkeydown='return onlyNumber(event)'
									onkeyup='removeChar(event)' min="0" value="${dateReportVo.report_sale}" required>
							</div>
						</td>
 						<td> 
							<div style="display: inline-block;">
								<label class="reporttable-label" for="day">달 성 률(%)
									&nbsp;</label> <input id="dayreporttable-achive-rank"
									class="form-control dayreportform-input" type="text"
									placeholder="일일 달성률" required readonly> <input
									type="hidden" id="achive-rank" value="${dateReportVo.achive_rank}"  name="achive_rank">
							</div>
						</td>
					</tr>
					<tr id="rpt-content2">
						<td>
							<div style="display: inline-block;">
								<label class="reporttable-label" for="show-day-title">출발
									계기판 &nbsp;</label> <input id="dayreporttable-startGauge"
									class="form-control dayreportform-input" type="Number"
									name="start_gauge" placeholder="출발 계기판"
									onkeydown='return onlyNumber(event)'
									onkeyup='removeChar(event)' value="${dateReportVo.start_gauge}" required>
							</div>
						</td>
						<td>
							<div style="display: inline-block;">
								<label class="reporttable-label" for="day">도착 계기판 </label> <input
									id="dayreporttable-endGauge"
									class="form-control dayreportform-input" type="Number"
									name="end_gauge" placeholder="도착 계기판"
									onkeydown='return onlyNumber(event)'
									onkeyup='removeChar(event)' value="${dateReportVo.end_gauge}" required>
							</div>
						</td>
						<td>
							<div style="display: inline-block;">
								<label class="reporttable-label" for="day">주행거리(km)
									&nbsp;</label> <input id="dayreporttable-mile"
									class="form-control dayreportform-input" type="text"
									name="mile" placeholder="주행거리" required readonly> <input
									type="hidden" id="mile" value="${dateReportVo.mile}" name="mile">
							</div>
						</td>
					</tr>
					<tr id="rpt-content3">
						<td colspan="2">
							<div style="display: inline-block;">
								<label class="reporttable-label" for="show-day-title">제목&nbsp;</label>
								<input id="dayreporttable-title"
									class="form-control dayreportform-input" type="text"
									name="title" placeholder="제목을 입력해 주세요"
									style="width: 430px; margin-right: 6px;" value="${dateReportVo.title}"required>
							</div>
						</td>
						<td><label class="reporttable-label" for="day">보고날짜&nbsp;</label>
							<input id="submitDay-datepicker" class="form-control" type="text"
							placeholder="보고날짜" required> <input id="dayreport-date"
							type="hidden" name="date" value="${dateReportVo.date}" class="dayreportform-input"></td>
					</tr>
				</table>
				<div class=" panel panel-default form-group"
					style="width: 100%; text-align: center">
					<div class="panel-heading">
						<strong>업무 보고 내용</strong>
					</div>
					<textarea id="report-content" name="content" class="date-textarea"></textarea>
				</div>
				<div class="panel panel-info" style="clear: both;">
					<div class="panel-heading">
						<strong>팀장 의견</strong>
					</div>
					<div class="panel-body">일 이따구로 할꺼야?</div>
				</div>
			</form>
			<div id="advice_contianer" style="padding: 5px;">
				<div class="page-header">
					<h4 style="width: 70%; display: inline-block;">
						<Strong>상담일지</Strong>
					</h4>
				</div>
				<div id="advice_content1" class="advice_content">
					<form id="advice_form">
						<div class="panel panel-info"
							style="clear: both; margin-top: 10px;">
							<div class="panel-heading" style="color: #fff;">
								<strong>상담카드</strong> <span style="float: right;"> <a
									href="#" onclick=""> <i class="fa fa-pencil fa-2x"
										aria-hidden="true"></i>
								</a> &nbsp; <a href="#" onclick=""> <i class="fa fa-trash fa-2x"
										aria-hidden="true"></i>
								</a>
								</span>
							</div>
							<div class="panel-body">
								<table id="advicereporttable"
									style="background-color: #fff; width: 100%; border-radius: 5px;">
									<tr style="margin-top: 5px;">
										<td colspan="3" id="adv-content1">
											<div class="form-group" style="margin-top: 15px;">
												<div style="display: inline-block;">
													<label for="show-day-title"
														style="width: 100px; text-align: center;">고객 코드
														&nbsp;</label> <input id="advicereporttable-code"
														class="form-control advicereporttable-input" type="text"
														name="code" placeholder="고객 코드" required
														data-toggle="modal" data-target="#AdviceModal"
														autocomplete="off">
												</div>
												<div style="display: inline-block;">
													<label for="day" style="width: 100px; text-align: center;">고객명</label>
													<input id="advicereporttable-customer"
														class="form-control advicereporttable-input" type="text"
														name="customer" placeholder="고객명" required
														data-toggle="modal" data-target="#AdviceModal"
														autocomplete="off">
												</div>
												<div style="display: inline-block;">
													<label for="day" style="width: 100px; text-align: center;">담당자
														&nbsp;</label> <input id="advicereporttable-manager_name"
														class="form-control advicereporttable-input" type="text"
														name="manager_name" placeholder="담당자" required>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td colspan="3" id="adv-content2">
											<div class="form-group">
												<div style="display: inline-block;">
													<label for="show-day-title"
														style="width: 100px; text-align: center">주소&nbsp;</label>
													<input id="advicereporttable-address"
														class="form-control advicereporttable-input" type="text"
														name="address" placeholder="주소 자동입력 "
														style="width: 415px; margin-right: 6px;" required
														data-toggle="modal" data-target="#AdviceModal"
														autocomplete="off">
												</div>
												<div style="display: inline-block; margin-top: 20px;">
													<label for="day" style="width: 100px; text-align: center">보고날짜&nbsp;</label>
													<input id="advicereporttable-date"
														class="form-control advicereporttable-input" type="text"
														name="date" placeholder="보고날짜"
														style="width: 220px; margin-right: 6px;" required readonly>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td colspan="3" id="adv-content3">
											<div class="form-group">
												<div style="display: inline-block;">
													<label for="show-day-title"
														style="width: 100px; text-align: center">제목&nbsp;</label>
													<input id="advicereporttable-title"
														class="form-control advicereporttable-input" type="text"
														name="title" placeholder="제목을 입력해 주세요" required
														autocomplete="off">
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td colspan="3" id="adv-content4">
											<div class="panel panel-default form-group"
												style="width: 95%; text-align: center; margin: 10px;">
												<textarea id="advice-textarea" class="date-textarea"></textarea>
											</div>
										</td>
									</tr>
								</table>

							</div>
						</div>
						<div style="clear: both; border-bottom: 1px solid #eee;"></div>
					</form>
				</div>
			</div>
		</div>
	</div>
	</main>

</body>
</html>