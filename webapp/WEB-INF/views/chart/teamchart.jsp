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
			 <i class="fa fa-chevron-circle-left" aria-hidden="true"></i>
					2017년
		  	 <i class="fa fa-chevron-circle-right" aria-hidden="true"></i>
		</h4>
		<table>
			<thead>
				<tr>
					<th>영업 매출 실적</th>
					<th>주행 거리량</th>
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
							<td><canvas id="performanceChart" width="400" height="400"></canvas></td>
							<td><canvas id="distanceDriven" width="400" height="400"></canvas></td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>
	</main>


	<script>
		var ctx = document.getElementById("performanceChart");
		var myChart = new Chart(
				ctx,
				{
					type : 'bar',
					data : {
						labels : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월",
								"8월", "9월", "10월", "11월", "12월" ],
						datasets : [
								{
									label : '영업 매출액',
									data : [ 12, 19, 3, 5, 2, 3, 8, 9, 12, 65,
											88, 18 ],
									backgroundColor : 'rgba(54, 162, 235, 0.2)',
									borderColor : 'rgba(54, 162, 235, 1)',
									borderWidth : 1
								},
								{
									label : '예상 매출액',
									data : [10,20,30,40,50,60,70,80,90,100,110,120],
									backgroundColor : 'rgba(255, 99, 132, 0.2)',
									borderColor : 'rgba(255,99,132,1)',
									borderWidth : 1
								} ]
					},
					options : {
						scales : {
							xAxes : [{
								stacked : true
								  }],
							yAxes : [ {
								stacked : true,
								scaleLabel: {
							        display: true,
							        labelString: "매출실적(만원)",
							        fontColor: "black"
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
					data : [ 12, 19, 3, 5, 2, 3, 8, 9, 12, 65, 88, 18 ],
					backgroundColor : 'rgba(54, 162, 235, 0.2)',
					borderColor : 'rgba(54, 162, 235, 1)',
					borderWidth : 1
				}, {
					label : '월 예상거리',
					data : [ 1, 3, 4, 7, 2, 4, 8, 2, 4, 35, 0, 0 ],
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
						scaleLabel: {
					        display: true,
					        labelString: "주행미터(km)",
					        fontColor: "black"
					      }
					} ]
				}
			}
		});
	</script>
</body>
</html>