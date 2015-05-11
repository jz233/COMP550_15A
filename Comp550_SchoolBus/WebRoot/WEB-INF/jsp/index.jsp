<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
	<title>School Bus</title>	
	
    <style>
      html, body, #map-canvas {
        height: 100%;
        margin: 0px;
        padding: 0px
      }
      #panel {
        position: absolute;
        top: 5px;
        left: 50%;
        margin-left: -180px;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
      }
    </style>
	<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true&language=en-nz">
    </script>
    <script  type="text/javascript">
        var directionsDisplay;
        var directionsService = new google.maps.DirectionsService();
        var map;
        var start;
		var waypoints_array = [];
	
		function setwaypoints_array(waypts_array){
			waypoints_array = waypts_array;
		}
		function getwaypoints_array(){
			return waypoints_array;
		}
		
		function setMap(set_map){
			map = set_map;
		}
		function getMap(){
			return map;
		}
		
        function initialize(){
			//initialize startpoint
			start = convert(document.getElementById('start').value);
			
            directionsDisplay = new google.maps.DirectionsRenderer();
            var uow = new google.maps.LatLng(-37.795487, 175.328610);
            var mapOptions = {
                zoom: 15,
                center: uow
            };
            map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
            directionsDisplay.setMap(map);
			directionsDisplay.setPanel(document.getElementById('directions_panel'));
        }
		
        function convert(location){
			var arr = location.split("+");
			return new google.maps.LatLng(arr[0],arr[1]);
		}
	
		function calc() {
//			var waypoints = getWaypoints();
			var waypoints = getwaypoints_array();
			console.log(waypoints);
			calcRoute(waypoints, start);
		}
		
		
		function getWaypoints(){
			var info="";
			var waypts_array = [];
			
			$.get("${pageContext.request.contextPath}/toGetWayPoints.do",
				function(data){
					$.each(data,function(index, user){
						info += '<li>'+user.user_lat+' &nbsp;&nbsp;&nbsp;'+user.user_lng+'</li>';
						waypoints_array.push(user.user_lat+'+'+user.user_lng);
					});
					$("#waypoints").html(info);
					console.log();
					setwaypoints_array(waypoints_array);
			});
			
			return waypoints_array;
		}
		
        function calcRoute(waypoints,start){
//            var start = convert(document.getElementById('start').value);
            var end = convert(document.getElementById('end').value);
        	var waypts = [];
			alert(waypoints);
		    for (var i = 0; i < waypoints.length; i++) {
				alert(waypoints[i]);
                    waypts.push({
                        location: convert(waypoints_array[i]),
                        stopover: true
                    });
                
            }
			
            var request = {
                origin: start,
                destination: end,
                waypoints: waypts,
                optimizeWaypoints: true,
                travelMode: google.maps.TravelMode.DRIVING,
				unitSystem: google.maps.DirectionsUnitSystem.METRIC
            };
            directionsService.route(request, function(response, status){
                if (status == google.maps.DirectionsStatus.OK) {
                    directionsDisplay.setDirections(response);
                  /*  var route = response.routes[0];
                    var summaryPanel = document.getElementById('directions_panel');
                    summaryPanel.innerHTML = '';
                    // For each route, display summary information.
                    for (var i = 0; i < route.legs.length; i++) {
                        var routeSegment = i + 1;
                        summaryPanel.innerHTML += '<b>Route Segment: ' + routeSegment + '</b><br>';
                        summaryPanel.innerHTML += route.legs[i].start_address + ' to ';
                        summaryPanel.innerHTML += route.legs[i].end_address + '<br>';
                        summaryPanel.innerHTML += route.legs[i].duration.text + '<br>';
                        summaryPanel.innerHTML += route.legs[i].distance.text + '<br><br>';
                    }
                    */
                }
            });
        }
		
		function addMarker(){
			 var myLatlng = new google.maps.LatLng(-37.792592,175.325896);
			 
			  var marker = new google.maps.Marker({
			      position: myLatlng,
			      map: getMap(),
			      title: 'Hello World!'
			  });
		}
		var getLocation;
		function updateLocation(){
			getLocation = setInterval(listenPosChange, 5000);
		}
		function listenPosChange(){
			$.get("${pageContext.request.contextPath}/toUpdate.do",
				function(response){
					changeStartPoint(response);
					
				});
		}
		function changeStartPoint(response){
			var newStartPoint = new google.maps.LatLng(response[0],response[1]);
			calcRoute(getWaypoints(),newStartPoint);
		}
		
		function stopUpdate(){
			clearInterval(getLocation);
		}
		
        google.maps.event.addDomListener(window, 'load', initialize);
    </script>
  </head>
  <body>
      <div id="map-canvas" style="float:left;width:70%;height:100%;">
      </div>
      <div id="control_panel" style="float:right;width:30%;text-align:left;padding-top:20px">
          <div style="margin:20px;border-width:2px;">
              <b>Start:</b>
              <select id="start">
                  <option value="-37.786865+175.318447">University of Waikato, Hamilton</option>
              </select>
              <br>
              <b>Waypoints:</b>
             <!-- <select multiple id="waypoints">
                  <option value="-37.788948,175.308205">The Warehouse, Clyde Street, Hillcrest, Hamilton</option>
                  <option value="-37.780149,175.272129">PAK'nSAVE Mill Street, Hamilton</option>
                  <option value="-37.750520,175.278890">Westfield Chartwell</option>
              </select>-->
			  <ul id="waypoints"></ul>
              <br>
              <b>End:</b>
               <select id="end">
                 <option value="-37.786865+175.318447">University of Waikato, Hamilton</option>
              </select>
              <br>
              <input type="submit" value="submit "onclick="calc();">
			  <input type="button" value="Get WayPoints" id="add" onclick="getWaypoints();">
			  <input type="button" value="marker" id="marker" onclick="addMarker();">
			  <input type="button" value="update" onclick="updateLocation()">
			  <input type="button" value="stop" onclick="stopUpdate()">
          </div>
          <div id="directions_panel" style="margin:20px;background-color:#FFEE77;">
          </div>
      </div>
  </body>
</html>
