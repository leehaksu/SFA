window.onload = function() {
	init();
}		
var map;
var mapW, mapH;     // 지도의 가로, 세로 크기(Pixel단위) 를 지정 합니다. 
var cLonLat, zoom;      //중심 좌표와 지도레벨을 정의 합니다. 
//pr_3857 인스탄스 생성.
var pr_3857 = new Tmap.Projection("EPSG:3857");

//pr_4326 인스탄스 생성.
var pr_4326 = new Tmap.Projection("EPSG:4326");

//		/*	function get4326LonLat(coordX, coordY){
//				return new Tmap.LonLat(coordX, coordY).transform(pr_3857, pr_4326);
//			}
//			function get3857LonLat(coordX, coordY){
//				return new Tmap.LonLat(coordX, coordY).transform(pr_4326, pr_3857);
//			}*/
			function setVariables(){    
				cLonLat = new Tmap.LonLat(37.497959, 127.027621).transform(pr_4326,pr_3857);
                        //중심점 좌표 입니다. EPSG3857 좌표계 형식 입니다. 
                zoom = 16;  // zoom level입니다.  0~19 레벨을 서비스 하고 있습니다. 
                mapW = '500px';  // 지도의 가로 크기 입니다. 
                mapH = '400px';  // 지도의 세로 크기 입니다. 
               // console.log(cLonLat);
            }

            function init() {

            	setVariables();
            	map = new Tmap.Map({div:'map_div', width:'670px', height:'240px', animation:true}); 
                // div : 지도가 생성될 div의 id값과 같은 값을 옵션으로 정의 합니다.
                // Tmap,Map 클래스에 대한 상세 사항은 "JavaScript" 하위메뉴인 "기본 기능" 페이지를 참조 해주세요. 
            	
                map.setCenter(cLonLat,zoom);
                 map.addControl(new Tmap.Control.MousePosition());  // 지도 오른쪽 아래 좌표 표시
                // map.addControl(new Tmap.Control. OverviewMap());   //지도에 미니맵 버튼 생성


             // 마커 만들기 
             var markerLayer = new Tmap.Layer.Markers();
             map.addLayer(markerLayer);

             var lonlat = new Tmap.LonLat(37.497959, 127.027621).transform(pr_4326,pr_3857);

             var size = new Tmap.Size(24,38);
             var offset = new Tmap.Pixel(-(size.w/2),-(size.h/2));
             var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_a.png', size, offset); 
             //아이콘 이미지 찾아서 바꿔보기.
             
             var marker = new Tmap.Marker(lonlat, icon);
             markerLayer.addMarker(marker);

             // map에 이벤트 등록 
             map.events.register("click",map,onClickMap)
             function onClickMap(evt){
             	console.log("type = "+evt.type);
             	console.log("clientX = "+evt.clientX);
             	console.log("clientY = "+evt.clientY);
             }
              // marker에 mouseover이벤트 적용
              var popup;
              popup = new Tmap.Popup("p1",
              	new Tmap.LonLat(14140653, 4508878),
              	new Tmap.Size(200, 200),
              	"<div>This is Popup Content</div>"
              	); 
              map.addPopup(popup);
              popup.hide();
              marker.events.register("mouseover", popup, onMouseMarker);
              marker.events.register("mouseout", popup, onMouseMarker);

              function onMouseMarker (evt){
              	if(evt.type == "mouseover"){
              		this.show();
              	} else {
              		this.hide();
              	}
              }
          }
