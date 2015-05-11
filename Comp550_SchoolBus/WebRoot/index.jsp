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
    <title>Waypoints in directions</title>
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
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true&language=en-nz">
    </script>
    <script>
        var directionsDisplay;
        var directionsService = new google.maps.DirectionsService();
        var map;
        
        function initialize(){
            directionsDisplay = new google.maps.DirectionsRenderer();
            var uow = new google.maps.LatLng(-37.795487, 175.328610);
            var mapOptions = {
                zoom: 15,
                center: uow
            };
            map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
            directionsDisplay.setMap(map);
        }
		
        function convert(location){
			var arr = location.split(",");
			return new google.maps.LatLng(arr[0],arr[1]);
		}
		
        function calcRoute(){
            var start = convert(document.getElementById('start').value);
            var end = convert(document.getElementById('end').value);
            var waypts = [];
            var checkboxArray = document.getElementById('waypoints');
            for (var i = 0; i < checkboxArray.length; i++) {
                if (checkboxArray.options[i].selected == true) {
                    waypts.push({
                        location: convert(checkboxArray[i].value),
                        stopover: true
                    });
                }
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
                    var route = response.routes[0];
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
                }
            });
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
                  <option value="-37.786865,175.318447">University of Waikato, Hamilton</option>
                  <option value="-37.748457,175.234313">The Base, Hamilton, Waikato</option>
                  <option value="-37.785761,175.278014">Transport Centre, Hamilton, Waikato</option>
              </select>
              <br>
              <b>Waypoints:</b>
              <br>
              <i>(Ctrl-Click for multiple selection)</i>
              <br>
              <select multiple id="waypoints">
                  <option value="-37.788948,175.308205">The Warehouse, Clyde Street, Hillcrest, Hamilton</option>
                  <option value="-37.780149,175.272129">PAK'nSAVE Mill Street, Hamilton</option>
                  <option value="-37.750520,175.278890">Westfield Chartwell</option>
              </select>
              <br>
              <b>End:</b>
               <select id="end">
                 <option value="-37.786865,175.318447">University of Waikato, Hamilton</option>
                  <option value="-37.748457,175.234313">The Base, Hamilton, Waikato</option>
                  <option value="-37.785761,175.278014">Transport Centre, Hamilton, Waikato</option>
              </select>
              <br>
              <input type="submit" name="start" onclick="calcRoute();">
          </div>
          <div id="directions_panel" style="margin:20px;background-color:#FFEE77;">
          </div>
      </div>
  </body>
</html>
