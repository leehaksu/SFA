	var date = new Date();
	
	//날짜 형식에 맞춰 오늘 날짜를 받는 변수
	var today = moment().format("YYYY-MM-DD");

	//날짜 비교 변수 
	var testnumber = moment('2010-10-20').isBefore('2010-10-21');
	//moment('2017-09-05','YYYY-MM-DD').diff('2017-09-04','day');

	//달력에서 클릭 한 날짜를 담는 변수
	var dayClick;
	var current;// ajax를 위해 변화하는 달 정보담는 변수	

	//입력 체크 변수
	var daychangecheck = false;

	
	
	//샘플
   /*  function searchRoute(){
    	if(routecheck == false){
	    	map.addLayers([vector_layer]);
	    	
	    	//좌표 배열 객체화
	    	 lineString = new Tmap.Geometry.LineString(routeList);
	    	 console.log("루트들");
	    	console.log(routeList);
	    	//vector feature 객체화
	    	mLineFeature = new Tmap.Feature.Vector(lineString, null, style_red);
	  
	    	//벡터 레이어에 등록
	    	vector_layer.addFeatures([mLineFeature]);
			
	    	console.log("경로탐색~");
	    	
	    	routecheck= true;
	    	var routes =""; 
	    	for(i=0; i < routeNames.length; i++){
	   		 		routes += routeNames[i] +"->";		
	    		}
    			routes = routes.substring(0,routes.length-2);
    			$("#datetable-branch").val(routes);
	    		$("#datetable-branch").attr("title",routes);	    			    		
	    		$('#datetable-branch').tooltip(); 
	    	
	    	//출발 지점과 도착지점 일때 	
	    	 if(routeList.length == 2){
	    		console.log(routeList.length);
		    	loadGetAddressFromLonLat(routeList);		
	    	} 
	    		$.ajax({
	    			url : 'https://apis.skplanetx.com/tmap/routes?version=1',
	    			type : 'POST',
	    			data : {'startX': 14140669.59746090,'startY': 4508640.36061872,'endX': 14135428.84691669,'endY':4505733.44979528},
	    			dataType : 'json',
	    			contentType: "application/json; charset=UTF-8",
	    			success : function(response) {
	    				console.log(response);
	    			},
	    			error : function(xhr,status,error) {
	    				alert(xhr + " 와 " + status + " 와 " + error);
	    			}
	        	});
    	}
    	else{
    		alert("이미 검색된 경로 결과가 존재합니다.");
    	}
    } */