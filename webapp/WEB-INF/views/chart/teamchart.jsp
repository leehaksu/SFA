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
			<strong>차트 조회</strong>
		</h3>
	</div>
	<div class="container">
		<h4>
			<i class="fa fa-chevron-circle-left" aria-hidden="true"
				onClick="subValue()"></i><span id="date"></span>년<i
				class="fa fa-chevron-circle-right" aria-hidden="true"
				onClick="addValue()"></i>
		</h4>
		<table>
			<thead>
				<tr>
					<th style="text-align: center;">월 별 영업 매출 실적</th>
					<th style="text-align: center;">월 별주행 거리량</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${authUser.level == '팀원'}">
						<tr>
							<td><canvas id="performanceChart" width="400" height="400"></canvas></td>
							<td><canvas id="distanceDriven" width="400" height="400"></canvas></td>
						</tr>
					</c:when>
					<c:otherwise>

						<tr>
							<td><canvas id="performanceChart" width="400" height="400"></canvas></td>
							<td><canvas id="distanceDriven" width="400" height="400"></canvas></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<th style="text-align: center;">부서별 영업 매출 실적</th>
							<th style="text-align: center;">부서별 주행 거리량</th>
						</tr>
						<tr>
							<td><canvas id="performanceChart2" width="400" height="400"></canvas></td>
							<td><canvas id="distanceDriven2" width="400" height="400"></canvas></td>
						</tr>


					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>
	</main>


	<script>
		var date ='<c:out value="${date}"/>';
		var level = '<c:out value="${authUser.level}"/>';
		var label = [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월",
				"10월", "11월", "12월" ];
		var ctx = document.getElementById("performanceChart");
		var myChart = new Chart(ctx, {
			type : 'bar',
			data : {
				labels : label,
				datasets : [ {
					label : '영업 매출액',
					data : [ 0,0,0,0,0,0,0,0,0,0,0,0 ],
					backgroundColor : 'rgba(54, 162, 235, 0.2)',
					borderColor : 'rgba(54, 162, 235, 1)',
					borderWidth : 1
				}, {
					label : '예상 매출액',
					data : [ 0,0,0,0,0,0,0,0,0,0,0,0 ],
					backgroundColor : 'rgba(255, 99, 132, 0.2)',
					borderColor : 'rgba(255,99,132,1)',
					borderWidth : 1
				} ]
			},
			options : {
				scales : {
					xAxes : [ {
						stacked : true
					} ],
					yAxes : [ {
						stacked : true,
						scaleLabel : {
							display : true,
							labelString : "매출실적(만원)",
							fontColor : "black"
						}
					} ]
				}
			}
		});
		var ctx2 = document.getElementById("distanceDriven");
		var myChart2 = new Chart(ctx2, {
			type : 'line',
			data : {
				labels : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월",
						"9월", "10월", "11월", "12월" ],
				datasets : [ {
					label : '월 주행거리',
					data : [ 0,0,0,0,0,0,0,0,0,0,0,0 ],
					backgroundColor : 'rgba(54, 162, 235, 0.2)',
					borderColor : 'rgba(54, 162, 235, 1)',
					borderWidth : 1
				}, {
					label : '월 예상거리',
					data : [ 0,0,0,0,0,0,0,0,0,0,0,0 ],
					backgroundColor : 'rgba(255, 99, 132, 0.2)',
					borderColor : 'rgba(255,99,132,1)',
					borderWidth : 1
				} ]
			},
			options : {
				scales : {
					xAxes : [ {
						stacked : true,
					} ],
					yAxes : [ {
						stacked : true,
						scaleLabel : {
							display : true,
							labelString : "주행미터(km)",
							fontColor : "black"
						}
					} ]
				}
			}
		});

		if(level=="팀장")
		{
		var ctx3 = document.getElementById("performanceChart2");
		var myChart3 = new Chart(ctx3, {
			type : 'bar',
			data : {
				labels : label,
				datasets : [ {
					label : '영업 매출액',
					data : [ 0,0,0,0,0,0,0,0,0,0,0,0 ],
					backgroundColor : 'rgba(54, 162, 235, 0.2)',
					borderColor : 'rgba(255,99,132,1)',
					borderWidth : 1
				}, {
					label : '예상 매출액',
					data : [ 0,0,0,0,0,0,0,0,0,0,0,0 ],
					backgroundColor : 'rgba(255, 99, 132, 0.2)',
					borderColor : 'rgba(54, 162, 235, 1)',
					borderWidth : 1
				} ]
			},
			options : {
				scales : {
					xAxes : [ {
						stacked : true
					} ],
					yAxes : [ {
						stacked : true,
						scaleLabel : {
							display : true,
							labelString : "매출실적(만원)",
							fontColor : "black"
						}
					} ]
				}
			}
		});
		var ctx4 = document.getElementById("distanceDriven2");
		var myChart4 = new Chart(ctx4, {
			type : 'line',
			data : {
				labels : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월",
						"9월", "10월", "11월", "12월" ],
				datasets : [ {
					label : '월 주행거리',
					data : [ 0,0,0,0,0,0,0,0,0,0,0,0 ],
					backgroundColor : 'rgba(54, 162, 235, 0.2)',
					borderColor : 'rgba(54, 162, 235, 1)',
					borderWidth : 1
				}, {
					label : '월 예상거리',
					data : [ 0 ],
					backgroundColor : 'rgba(255, 99, 132, 0.2)',
					borderColor : 'rgba(255,99,132,1)',
					borderWidth : 1
				} ]
			},
			options : {
				scales : {
					xAxes : [ {
						stacked : true,
					} ],
					yAxes : [ {
						stacked : true,
						scaleLabel : {
							display : true,
							labelString : "주행미터(km)",
							fontColor : "black"
						}
					} ]
				}
			}
		});

		}
		
		function update(chart, number, doc) {
			chart.data.datasets[number].data[0] = doc.data.Jan;
			chart.data.datasets[number].data[1] = doc.data.Feb;
			chart.data.datasets[number].data[2] = doc.data.Mar;
			chart.data.datasets[number].data[3] = doc.data.Apr;
			chart.data.datasets[number].data[4] = doc.data.May;
			chart.data.datasets[number].data[5] = doc.data.Jun;
			chart.data.datasets[number].data[6] = doc.data.Jul;
			chart.data.datasets[number].data[7] = doc.data.Aug;
			chart.data.datasets[number].data[8] = doc.data.Sep;
			chart.data.datasets[number].data[9] = doc.data.Oct;
			chart.data.datasets[number].data[10] = doc.data.Nov;
			chart.data.datasets[number].data[11] = doc.data.Dec;
			chart.update();
		}

		function updateDate(chart, number, label_array, sale_array) {
			chart.data.labels = label_array;
			for (i = 0; i < label_array.length; i++) {
				chart.data.datasets[number].data[i] = sale_array[i];
			}
			chart.update();
		}
		function subValue() {
			date = date - 1;
			$("#date").text(date);
			getChart(date);
		}
		function addValue() {
			date = date + 1;
			$("#date").text(date);
			getChart(date);
		}

		function getChart(date) {
			$
					.ajax({
						url : '/sfa/chart/sale',
						type : 'POST',
						dataType : 'json',
						data : "date=" + date,
						contentType : "application/x-www-form-urlencoded; charset=UTF-8",
						success : function(doc) {
							update(myChart, 0, doc);
						}
					});
			$
					.ajax({
						url : '/sfa/chart/sale/estimate',
						type : 'POST',
						dataType : 'json',
						data : "date=" + date,
						contentType : "application/x-www-form-urlencoded; charset=UTF-8",
						success : function(doc) {
							update(myChart, 1, doc);
						}
					});
			$
					.ajax({
						url : '/sfa/chart/mile',
						type : 'POST',
						dataType : 'json',
						data : "date=" + date,
						contentType : "application/x-www-form-urlencoded; charset=UTF-8",
						success : function(doc) {
							update(myChart2, 0, doc);
						}
					});
			$
					.ajax({
						url : '/sfa/chart/mile/estimate',
						type : 'POST',
						dataType : 'json',
						data : "date=" + date,
						contentType : "application/x-www-form-urlencoded; charset=UTF-8",
						success : function(doc) {
							update(myChart2, 1, doc);
						}
					});

			if(level=="팀장")
				{
				console.log("여기 나와??");
				$
				.ajax({
					url : '/sfa/chart/sale/dept',
					type : 'POST',
					dataType : 'json',
					data : "date=" + date,
					contentType : "application/x-www-form-urlencoded; charset=UTF-8",
					success : function(doc) {
						console.log(doc);
 						var label_array = new Array();
						var sale_array = new Array();
						for (i = 0; i < doc.data.length; i++) {
							label_array.push(doc.data[i].dept);
							sale_array.push(doc.data[i].total_sale)
						}
						updateDate(myChart3, 0, label_array, sale_array);
					}
				});
		$
				.ajax({
					url : '/sfa/chart/sale/dept/estimate',
					type : 'POST',
					dataType : 'json',
					data : "date=" + date,
					contentType : "application/x-www-form-urlencoded; charset=UTF-8",
					success : function(doc) {
						console.log(doc);
						var label_array = new Array();
						var sale_array = new Array();
						for (i = 0; i < doc.data.length; i++) {
							label_array.push(doc.data[i].dept);
							sale_array.push(doc.data[i].total_sale)
						}
						updateDate(myChart3, 1, label_array, sale_array);
					}
				});

		$
				.ajax({
					url : '/sfa/chart/mile/dept',
					type : 'POST',
					dataType : 'json',
					data : "date=" + date,
					contentType : "application/x-www-form-urlencoded; charset=UTF-8",
					success : function(doc) {
						console.log(doc);
						var label_array = new Array();
						var mile_array = new Array();
						for (i = 0; i < doc.data.length; i++) {
							label_array.push(doc.data[i].dept);
							mile_array.push(doc.data[i].total_mile)
						}
						updateDate(myChart4, 0, label_array, mile_array);
					}
				});

		$.ajax({
					url : '/sfa/chart/mile/dept/estimate',
					type : 'POST',
					dataType : 'json',
					data : "date=" + date,
					contentType : "application/x-www-form-urlencoded; charset=UTF-8",
					success : function(doc) {
						console.log(doc);
						var label_array = new Array();
						var mile_array = new Array();
						if (doc.data== null) {

						} else {
							for (i = 0; i < doc.data.length; i++) {

								label_array.push(doc.data[i].dept);
								mile_array.push(doc.data[i].estimate_distance)
							}

						}

						updateDate(myChart4, 1, label_array, mile_array);
					}
				});

				}
			
			
			 
		}

		$(document).ready(function() {
			console.log(date);
			$("#date").text(date);
			getChart(date);
		});
	</script>
</body>
</html>