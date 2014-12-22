<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap 101 Template</title>
<script type="text/javascript" src="js/jquery-2.1.3.js"></script>
<link rel="stylesheet" type="text/css" media="screen"
	href="//cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/master/build/css/bootstrap-datetimepicker.min.css" />
<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/semantic.css" rel="stylesheet">
<script type="text/javascript" src="js/moment.js"></script>
<script type="text/javascript" src="js/semantic.js"></script>
<script type="text/javascript"
	src="//cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/master/src/js/bootstrap-datetimepicker.js"></script>
<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

<script>
	var basicurl = "http://localhost:8080/CloudFinal/";
	var uid;
	var pword;
	var prefs;
	var currentPreference;

	var wsocket;
	var serviceLocation = "ws://localhost:8080/CloudFinal/Message/";
	var $message;
	var $chatWindow;
	var room = '1233';

	/////////// easy to hash
	String.prototype.hashCode = function() {
		var hash = 0, i, chr, len;
		if (this.length == 0)
			return hash;
		for (i = 0, len = this.length; i < len; i++) {
			chr = this.charCodeAt(i);
			hash = ((hash << 5) - hash) + chr;
			hash |= 0; // Convert to 32bit integer
		}
		return hash;
	};

	////////////////////////WebSocketStuff!!!!!

	function onMessageReceived(evt) {
		//var msg = eval('(' + evt.data + ')');
		var msg = JSON.parse(evt.data); // native API
		var $messageLine = '<tr><td class="received">'
				+ new Date().toLocaleTimeString()
				+ '</td><td class="user label label-info">' + msg.sender
				+ '</td><td class="message badge">' + msg.message
				+ '</td></tr>';
		$chatWindow.append($messageLine);
	}
	function sendMessage() {
		var msg = '{"message":"' + $message.val() + '", "sender":"' + uid
				+ '","room":"' + room + '", "processed":false}';
		wsocket.send(msg);
		$message.val('').focus();
	}

	function connectToChatserver(roomname) {
		if (wsocket == null) {
			room = roomname;
			wsocket = new WebSocket(serviceLocation + room);
			wsocket.onmessage = onMessageReceived;
		}
	}

	function leaveRoom() {
		wsocket.close();
		$chatWindow.empty();
		$('.chat-wrapper').hide();
	}

	/////////////////////////////////////////////////////////////////////////////

	function loadXMLDoc() {
		uid = document.getElementById("username").value;
		pword = document.getElementById("password").value;
		document.getElementById("signin").disabled = true;
		$.ajax({
			url : basicurl + "Login",
			type : 'POST',
			dataType : "json",
			data : JSON.stringify({
				username : document.getElementById("username").value,
				password : document.getElementById("password").value
			}),
			processData : false,
			ContentType : 'application/json',
			dataType : 'json',
			success : AjaxSucceeded,
			error : AjaxFailed
		});
	}

	function AjaxSucceeded(result) {
		if (result.result) {
			//document.getElementById("welcome").innerHTML = "EventList";
			var a = document.getElementById("signin");
			document.getElementById("signin").parentElement
					.removeChild(document.getElementById("signin"));
			var b = document.getElementById("signup");
			document.getElementById("signup").parentElement
					.removeChild(document.getElementById("signup"));
			var c = document.getElementById("username");
			document.getElementById("username").parentElement
					.removeChild(document.getElementById("username"));
			var d = document.getElementById("password");
			document.getElementById("password").parentElement
					.removeChild(document.getElementById("password"));
			$("#test0").show(1000);
			$("#test1").show(1000);
			$("#nav").show(1000);
			$("#test3").show();
			google.maps.event.trigger(map, 'resize');
			$("#logout").show(100);
			getAndCreateAllPreference();
			getProfile();
		} else {
			document.getElementById('undiv').className += ' has-error';
			document.getElementById('pwdiv').className += ' has-error';
			document.getElementById("signin").disabled = false;
		}
	}
	function AjaxFailed(result) {
		alert("bad");
		alert(result.status + ' ' + result.statusText);
	}

	function singup() {
		uid = document.getElementById("username").value;
		pword = document.getElementById("password").value;
		document.getElementById("signup").disabled = true;
		$.ajax({
			url : basicurl + "Register",
			type : 'POST',
			dataType : "json",
			data : JSON.stringify({
				username : document.getElementById("username").value,
				password : document.getElementById("password").value
			}),
			processData : false,
			ContentType : 'application/json',
			dataType : 'json',
			success : signupSucceeded,
			error : AjaxFailed
		});
	}

	function signupSucceeded(result) {
		if (result.result) {
			var a = document.getElementById("signin");
			document.getElementById("signin").parentElement
					.removeChild(document.getElementById("signin"));
			var b = document.getElementById("signup");
			document.getElementById("signup").parentElement
					.removeChild(document.getElementById("signup"));
			var c = document.getElementById("username");
			document.getElementById("username").parentElement
					.removeChild(document.getElementById("username"));
			var d = document.getElementById("password");
			document.getElementById("password").parentElement
					.removeChild(document.getElementById("password"));
			$("#test0").show(1000);
			$("#test1").show(1000);
			$("#test3").show();
			$("#nav").show(1000);
			google.maps.event.trigger(map, 'resize');
			$("#logout").show(100);
			getAndCreateAllPreference();
			getProfile();
		} else {
			document.getElementById('undiv').className += ' has-error';
			document.getElementById('pwdiv').className += ' has-error';
			document.getElementById("signup").disabled = false;
		}
	}

	function addPref() {
		var element = document.createElement("li");
		element.

		uid = document.getElementById("addPref").value;
		var selectop = document.getElementById("activity_name");
		var array = {
			"plantform" : "haha",
			"preference" : {
				"user_id" : uid,
				"preference_name" : (new Date()).getTime() + ":"
						+ document.getElementById("preference_name").value,
				"location_id" : document.getElementById("maddress").value
						.hashCode(),
				"distance_to_tolerance" : parseFloat(document
						.getElementById("distance_to_tolerance").value),
				"start_time" : parseInt(Date.parse(document
						.getElementById("start_time").value)),
				"end_time" : parseInt(Date.parse(document
						.getElementById("end_time").value)),
				"key_word" : "Hello",
				"activity_name" : selectop.options[selectop.selectedIndex].innerHTML,
				"number_limit_from" : parseInt(document
						.getElementById("number_limit_from").value),
				"number_limit_to" : parseInt(document
						.getElementById("number_limit_to").value)
			}
		};
		$.ajax({
			url : basicurl + "InsertLocation",
			type : 'POST',
			dataType : "json",
			data : JSON.stringify({
				"plantform" : "haha",
				"location" : {
					"location_id" : document.getElementById("maddress").value
							.hashCode(),
					"address" : document.getElementById("maddress").value,
					"longitude" : parseFloat(document
							.getElementById("xCoordinate").value),
					"latitude" : parseFloat(document
							.getElementById("yCoordinate").value)
				}
			}),
			processData : false,
			ContentType : 'application/json',
			dataType : 'json',
			success : function(result) {
				if (result.result) {
					$.ajax({
						url : basicurl + "InsertPreference",
						type : 'POST',
						dataType : "json",
						data : JSON.stringify(array),
						processData : false,
						ContentType : 'application/json',
						dataType : 'json',
						success : function(result) {
							getAndCreateAllPreference();
						},
						error : AjaxFailed
					});
				}
			},
			error : AjaxFailed
		});
	}
	//get and create all preference
	function getAndCreateAllPreference() {
		var myNode = document.getElementById("motherlist");
		while (myNode.firstChild) {
			myNode.removeChild(myNode.firstChild);
		}

		$.ajax({
			url : basicurl + "LookUpPreference",
			type : 'POST',
			dataType : "json",
			data : JSON.stringify({
				plantform : "aads",
				userid : uid
			}),
			processData : false,
			ContentType : 'application/json',
			dataType : 'json',
			success : function(result) {
				prefs = result.preference;
				var indexforpresu = 0;
				for ( var ke in prefs) {
					createSublist(prefs[ke].preference_name, indexforpresu);
					indexforpresu = indexforpresu + 1;
				}
			},
			error : AjaxFailed
		});
	}

	//create a list item
	function createSublist(prefname, indexi) {
		var n = prefname.indexOf(":");
		var elementa = document.createElement("li");
		var elementb = document.createElement("a");
		elementb.onclick = function() {
			currentPreference = indexi;
			$("#test2").hide(100);
			$("#test1").hide(200);
			$("#event-table").hide();
			$("#preference-table").show(600);
			document.getElementById("set_preferencename").innerHTML = prefs[indexi].preference_name
					.substring(n + 1);
			document.getElementById("set_activity").innerHTML = prefs[indexi].activity_name;
			document.getElementById("set_location").innerHTML = prefs[indexi].address
					.substring(0, prefs[indexi].address.indexOf(","));
			document.getElementById("set_starttime").innerHTML = (new Date(
					prefs[indexi].start_time)).toDateString();
			document.getElementById("set_endtime").innerHTML = (new Date(
					prefs[indexi].end_time)).toDateString();
			document.getElementById("set_numberlimitfrom").innerHTML = prefs[indexi].number_limit_from;
			document.getElementById("set_numberlimitto").innerHTML = prefs[indexi].number_limit_to;

			var myNode = document.getElementById("event-table-detail");
			while (myNode.firstChild) {
				myNode.removeChild(myNode.firstChild);
			}

			$.ajax({
				url : basicurl + "LookUpEvent",
				type : 'POST',
				dataType : "json",
				data : JSON.stringify({
					plantform : "aads",
					userid : uid,
					preferencename : prefs[indexi].preference_name
				}),
				processData : false,
				ContentType : 'application/json',
				dataType : 'json',
				success : function(result) {
					var events = result.event;
					for ( var ke in events) {
						addEvents(events[ke].address, events[ke].activity_name,
								(new Date(events[ke].start_time))
										.toDateString(),
								events[ke].number_limit_from,
								events[ke].number_limit_to,
								events[ke].number_of, events[ke].event_id,
								events[ke].is_enrolled);
						addEventMarker(events[ke].latitude,
								events[ke].longitude);
					}
				},
				error : AjaxFailed
			});
			clearEventMarker();
			addMarker(parseFloat(prefs[indexi].latitude),
					parseFloat(prefs[indexi].longitude));
			for (var i = 0; i < events.length; i++) {

			}
			$("#test2").show(400);
		};
		elementb.innerHTML = prefname.substring(n + 1);
		elementa.appendChild(elementb);
		document.getElementById('motherlist').appendChild(elementa);
	}
	//this function is called to show addPreference page and hide Preference detail page
	function addPreference() {
		$("#test1").show(400);
		$("#test2").hide(200);
	}
	//delete preference
	function deletePreference() {
		$
				.ajax({
					url : basicurl + "DeletePreference",
					type : 'POST',
					dataType : "json",
					data : JSON
							.stringify({
								plantform : "aads",
								user_id : uid,
								preference_name : prefs[currentPreference].preference_name
							}),
					processData : false,
					ContentType : 'application/json',
					dataType : 'json',
					success : function(result) {
						if (result.result) {
							getAndCreateAllPreference();
							$("#test2").hide(200);
							$("#test1").show(400);
							document.getElementById('maddress').value = "";
							document.getElementById('xCoordinate').value = "";
							document.getElementById('yCoordinate').value = "";
						} else {
							alert("Sorry guys, but you should leave the event before you delete this preference.");
						}
					},
					error : function() {
						alert("Sorry guys, an error happens.");
					}
				});

	}
</script>
<script type="text/javascript"
	src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
<script type="text/javascript">
	var marker = [];
	var tmpMarker;
	var infowindow = [];
	var infowindow2 = [];
	var mapline = [];
	var address;
	var x;
	var y;
	var map;
	var pinImage;
	//var addressRes;
	var geocoder = new google.maps.Geocoder();
	function geocodePosition(pos) {
		geocoder
				.geocode(
						{
							latLng : pos
						},
						function(responses) {
							if (responses && responses.length > 0) {
								address = responses[0].formatted_address;
								document.getElementById('maddress').value = address;
								updateMarkerAddress(responses[0].formatted_address);
							} else {
								updateMarkerAddress('Cannot determine address at this location.');
							}
						});
	}

	// write current address to screen
	function updateMarkerAddress(str) {
		document.getElementById('maddress').innerHTML = str;
	}
	// write current location to screen
	function updateMarkerPosition(latLng) {
		document.getElementById('xCoordinate').value = x;
		document.getElementById('yCoordinate').value = y;
	}
	window.onload = function() {
		var mapOptions = {
			center : new google.maps.LatLng(40.786341754739205,
					-73.97232055664062),
			zoom : 13,
			mapTypeId : google.maps.MapTypeId.ROADMAP
		};

		var infoWindow = new google.maps.InfoWindow();
		var latlngbounds = new google.maps.LatLngBounds();
		map = new google.maps.Map(document.getElementById("dvMap"), mapOptions);
		var pinColor = "0000ff";
		pinImage = new google.maps.MarkerImage(
				"http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|"
						+ pinColor, new google.maps.Size(21, 34),
				new google.maps.Point(0, 0), new google.maps.Point(10, 34));
		// mouse click event
		google.maps.event.addListener(map, 'click',
				function(e) {
					var latLng = new google.maps.LatLng(e.latLng.lat(),
							e.latLng.lng());
					x = e.latLng.lng();
					y = e.latLng.lat();
					clearEventMarker();
					tmpMarker = new google.maps.Marker({
						map : map,
						position : new google.maps.LatLng(y, x),
						icon : pinImage
					});
					//marker = new google.maps.Marker({position: event.latLng, map: map});
					geocodePosition(latLng);
					updateMarkerPosition(latLng);
				});
	}

	function mapFromMiddleToRight() {

	}
</script>


</head>
<body>
	<nav class="navbar navbar-inverse" role="navigation">
	<div class="container-fluid">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#">CloudFinal</a>
		</div>

		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<div class="navbar-form navbar-left">
				<ul id="nav" class="nav nav-tabs">
					<li id="homePage" role="presentation" class="active"><a
						href="#" onclick="setHomePage()">Home</a></li>
					<li id="profile" role="presentation"><a href="#"
						onclick="setProfile()">Profile</a></li>
					<li id="message" role="presentation"><a href="#"
						onclick="setMessage()">Messages</a></li>
					<li id="events" role="presentation"><a href="#"
						onclick="setEvents()">Events</a></li>
				</ul>
			</div>

			<div class="navbar-form navbar-right">
				<div class="form-group" id="undiv">
					<input type="text" class="form-control" id="username"
						placeholder="Username">
				</div>
				<div class="form-group" id="pwdiv">
					<input type="password" class="form-control" id="password"
						placeholder="Password">
				</div>
				<div class="form-group">
					<button class="btn btn-default" onclick="loadXMLDoc()" id="signin">SignIn</button>
				</div>
				<div class="form-group">
					<button class="btn btn-default" onclick="singup()" id="signup">SignUp</button>
				</div>
				<div class="form-group" id="logout">
					<button class="btn btn-default">
						<a href="">Log out</a>
					</button>
				</div>
			</div>
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container-fluid --> </nav>
	<div>
		<div class="row">
			<div class="col-sm-2 col-md-2 sidebar" id="test0">
				<ul class="nav nav-sidebar">
					<li><a href="#" onclick="addPreference()">New Preference</a></li>
				</ul>
				<ul class="nav nav-sidebar" id="motherlist">
				</ul>
			</div>
			<div class="col-sm-4 col-md-4" id="test1">
				<div class="jumbotron">
					<div class="container">
						<div class="row" id="divt">
							<div class='col-sm-12 col-md-12'>
								<input type="text" class="form-control" id="preference_name"
									placeholder="Enter Your Preference Name">
							</div>
							<div class='col-sm-12 col-md-12'>
								<input id="distance_to_tolerance" type="text"
									class="form-control" placeholder="I prefer within">
							</div>
						</div>
						<div class="row" id="divt">
							<div class='col-sm-12 col-md-12'>
								<div class='input-group date' id='datetimepicker1'>
									<input id="start_time" type='text' class="form-control"
										placeholder="Start Time To" /> <span
										class="input-group-addon"><span
										class="glyphicon glyphicon-calendar"></span></span>
								</div>
							</div>
							<div class='col-sm-12 col-md-12'>
								<div class='input-group date' id='datetimepicker2'>
									<input id="end_time" type='text' class="form-control"
										placeholder="Start Time To" /> <span
										class="input-group-addon"><span
										class="glyphicon glyphicon-calendar"></span> </span>
								</div>
							</div>
							<div class='col-sm-6 col-md-6'>
								Select an activity <select id="activity_name"
									class="form-control">
									<option value="one">basketball</option>
								</select> <input id="number_limit_from"></input><label>number_limit_from</label>
								<input id="number_limit_to"></input><label>number_limit_to</label>
								<input id="maddress"></input><label>address</label> <input
									id="xCoordinate"></input><label>longitude</label> <input
									id="yCoordinate"></input><label>latitude</label>
							</div>
						</div>
						<div class="row" id="divt">
							<div class="col-sm-6 col-md-6 col-lg-6">
								<button type="button" class="btn btn-primary btn-block"
									id="addPref" onclick="addPref()">AddPref</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-4 col-md-4" id="test2">
				<div class="panel panel-default">
					<div class="panel-heading">
						<a href="#" onclick="togglePreference()">Preference Detail</a> <a
							href="#" onclick="deletePreference()" style="float: right">Delete
							it</a>
					</div>
					<div id="preference-table" class="panel-body">
						<table class="table">
							<tbody>
								<tr>
									<td>Preference Name</td>
									<td id="set_preferencename"></td>
								</tr>
								<tr>
									<td>Activit</td>
									<td id="set_activity"></td>
								</tr>
								<tr>
									<td>Prefered Location</td>
									<td id="set_location"></td>
								</tr>
								<tr>
									<td>Start Time</td>
									<td id="set_starttime"></td>
								</tr>
								<tr>
									<td>End Time</td>
									<td id="set_endtime"></td>
								</tr>
								<tr>
									<td>Number Limit From</td>
									<td id="set_numberlimitfrom"></td>
								</tr>
								<td>Number Limit To</td>
								<td id="set_numberlimitto"></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-heading">
						<a href="#" onclick="toggleEvent()">Current Event</a>
					</div>
					<div id="event_loading">
						<div id="event-table" class="panel-body" style="height: 300px">
							<div class="row" id="event-table-detail"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-6 col-md-6" style="float: right" id="test3">
				<div id="dvMap" style="height: 400px"></div>
			</div>
			<div class="col-sm-12 col-md-12" id="profileView">
				<div class="col-sm-12 col-md-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<a href="#" onclick="toggleEvent()">Current Event</a>
						</div>
						<div id="event-table" class="panel-body">
							<div class="row" id="event-table-detail">
								<div class="col-sm-4 col-md-4">
									<img id="userImage"
										src="https://s3-us-west-2.amazonaws.com/eventplanner/765-default-avatar.png"
										class="img-thumbnail">
									<form method="post" enctype="multipart/form-data"
										action="Center">
										<input type="file" name="images" id="images" multiple /> <input
											type="hidden" id="user_id" name="user_id" value="" />
										<button type="submit" id="btn">Upload Files!</button>
									</form>
									<div id="response"></div>
								</div>
								<div class="col-sm-4 col-md-4">
									<table class="table">
										<tbody>
											<tr>
												<td>Account</td>
												<td><input type="text" class="form-control"
													id="set_account" readonly></td>
											</tr>
											<tr>
												<td>Password</td>
												<td><button class="btn btn-default">Change</button></td>
											</tr>
											<tr>
												<td>User Name</td>
												<td><input type="text" class="form-control"
													id="set_username"></td>
											</tr>
											<tr>
												<td>Date of Birth</td>
												<td><input type="text" class="form-control"
													id="set_dob"></td>
											</tr>
											<tr>
												<td>Nationality</td>
												<td><input type="text" class="form-control"
													id="set_nationality"></td>
											</tr>
											<tr>
												<td>Gender</td>
												<td><input type="text" class="form-control" id="gender" /></td>
											</tr>
										</tbody>
									</table>
									<button class="btn btn-default">edit</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-12 col-md-12" id="eventsView">
				<div class="col-sm-12 col-md-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<a href="#" onclick="toggleEvent()">Current Event</a>
						</div>
						<div id="eventsDetail" class="panel-body">
							<div class="row" id="event-table-detail">
								<div class="col-sm-6 col-md-6"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="container chat-wrapper">
		<form id="do-chat">
			<h2 class="alert alert-success"></h2>
			<div id="chatresponse"></div>
			<fieldset>
				<legend>Enter your message..</legend>
				<div class="controls">
					<input type="text" class="input-block-level"
						placeholder="Your message..." id="chatmessage"
						style="height: 60px" /> <input type="submit"
						class="btn btn-large btn-block btn-primary" value="Send message" />
					<button class="btn btn-large btn-block" type="button"
						id="leave-room">Leave room</button>
				</div>
			</fieldset>
		</form>
	</div>


	<script type="text/javascript">
		$(function() {
			$('#datetimepicker1').datetimepicker();
		});
		$(function() {
			$('#datetimepicker2').datetimepicker();
		});
	</script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.min.js"></script>
	<script type="text/javascript">
		function addMarker(lat, longi) {
			marker[marker.length] = new google.maps.Marker({
				map : map,
				position : new google.maps.LatLng(lat, longi),
				icon : pinImage
			});
		}
		function clearEventMarker() {
			for (var i = 0; i < marker.length; i++) {
				marker[i].setMap(null);
			}
			marker = [];
		}
		function togglePreference() {
			$("#preference-table").toggle("slow");
		}
		function toggleEvent() {
			$("#event-table").toggle("slow");
		}

		function addEventMarker(lat, longi) {
			marker[marker.length] = new google.maps.Marker({
				map : map,
				position : new google.maps.LatLng(lat, longi),
			});
		}
	</script>
	<script type="text/javascript">
		function addMarker(lat, longi) {
			marker[marker.length] = new google.maps.Marker({
				map : map,
				position : new google.maps.LatLng(lat, longi),
				icon : pinImage
			});
			map.setCenter(new google.maps.LatLng(lat, longi));
		}
		function addEevntMarker(lat, longi) {
			marker[marker.length] = new google.maps.Marker({
				map : map,
				position : new google.maps.LatLng(lat, longi)
			});
		}
		function clearEventMarker() {
			for (var i = 0; i < marker.length; i++) {
				marker[i].setMap(null);
			}
			marker = [];
			if (tmpMarker != null) {
				tmpMarker.setMap(null);
			}
			tmpMarker = null;
		}
		function togglePreference() {
			$("#preference-table").toggle("slow");
			$("#event-table").hide(200);
		}
		function toggleEvent() {
			$("#event-table").toggle("slow");
			$("#preference-table").hide(200);
		}
		/*element.appendChild(para);
		event-table-detail
		<div class="thumbnail">
		<img src="" alt="">
		<div class="caption">
			<p>number:14</p>
			<button class="btn btn-primary">Join</button>
		</div>
		</div>*/
		function addEvents(location, activityName, startTime, numberLimitFrom,
				numberLimitTo, currentNumber, eventid, is_enrolled) {
			var bt;
			if (currentNumber == 0) {
				bt = createB("Create", "button");
				bt.setAttribute("class", "btn btn-success");
			} else {
				bt = createB("Join", "button");
				bt.setAttribute("class", "btn btn-primary");
			}
			bt.setAttribute("id", "btn btn-primary");
			bt.id = "1_" + eventid;

			var bt2 = createB("leave", "button");
			bt2.setAttribute("class", "btn btn-danger");
			bt2.id = "2_" + eventid;

			bt.onclick = function(e) {
				document.getElementById("event_loading").className = "ui loading segment";
				$
						.ajax({
							url : basicurl + "JoinEvent",
							type : 'POST',
							dataType : "json",
							data : JSON
									.stringify({
										plantform : "aads",
										userid : uid,
										eventid : eventid,
										preferencename : prefs[currentPreference].preference_name
									}),
							processData : false,
							ContentType : 'application/json',
							dataType : 'json',
							success : function(result) {
								if (result.result) {
									var myNode = document
											.getElementById("event-table-detail");
									while (myNode.firstChild) {
										myNode.removeChild(myNode.firstChild);
									}
									$
											.ajax({
												url : basicurl + "LookUpEvent",
												type : 'POST',
												dataType : "json",
												data : JSON
														.stringify({
															plantform : "aads",
															userid : uid,
															preferencename : prefs[currentPreference].preference_name
														}),
												processData : false,
												ContentType : 'application/json',
												dataType : 'json',
												success : function(result) {
													var events = result.event;
													for ( var ke in events) {
														addEvents(
																events[ke].address,
																events[ke].activity_name,
																(new Date(
																		events[ke].start_time))
																		.toDateString(),
																events[ke].number_limit_from,
																events[ke].number_limit_to,
																events[ke].number_of,
																events[ke].event_id,
																events[ke].is_enrolled);
													}
													document
															.getElementById("event_loading").className = "";
												},
												error : function() {
													document
															.getElementById("event_loading").className = "";
												}
											});
								}
							},
							error : function() {
								document.getElementById("event_loading").className = "";
							}
						});

			};

			bt2.onclick = function(e) {
				document.getElementById("event_loading").className = "ui loading segment";
				$
						.ajax({
							url : basicurl + "Leave",
							type : 'POST',
							dataType : "json",
							data : JSON.stringify({
								plantform : "aads",
								userid : uid,
								eventid : eventid
							}),
							processData : false,
							ContentType : 'application/json',
							dataType : 'json',
							success : function(result) {
								if (result.result) {
									var myNode = document
											.getElementById("event-table-detail");
									while (myNode.firstChild) {
										myNode.removeChild(myNode.firstChild);
									}
									$
											.ajax({
												url : basicurl + "LookUpEvent",
												type : 'POST',
												dataType : "json",
												data : JSON
														.stringify({
															plantform : "aads",
															userid : uid,
															preferencename : prefs[currentPreference].preference_name
														}),
												processData : false,
												ContentType : 'application/json',
												dataType : 'json',
												success : function(result) {
													var events = result.event;
													for ( var ke in events) {
														addEvents(
																events[ke].address,
																events[ke].activity_name,
																(new Date(
																		events[ke].start_time))
																		.toDateString(),
																events[ke].number_limit_from,
																events[ke].number_limit_to,
																events[ke].number_of,
																events[ke].event_id,
																events[ke].is_enrolled);
													}
													document
															.getElementById("event_loading").className = "";
												},
												error : function() {
													document
															.getElementById("event_loading").className = "";
												}
											});
								}
							},
							error : function() {
								document.getElementById("event_loading").className = "";
							}
						});

			}

			var d1 = createElement("div");
			d1.setAttribute("class", "caption");
			d1.appendChild(createP("Location: " + location, "p"));
			d1.appendChild(createP("activityName: " + activityName, "p"));
			d1.appendChild(createP("startTime: " + startTime, "p"));
			d1.appendChild(createP("Limit:", "p"));
			var currentonline = createP(currentNumber + "/" + numberLimitTo,
					"p");
			currentonline.id = "3_" + eventid;
			d1.appendChild(currentonline);
			d1.appendChild(bt);
			d1.appendChild(bt2);
			var image = createElement("img");
			image.src = "";
			var d2 = createElement("div");
			d2.setAttribute("class", "thumbnail");
			d2.appendChild(image);
			d2.appendChild(d1);
			var d3 = createElement("div");
			d3.setAttribute("class", "col-sm-6 col-md-4");
			d3.appendChild(d2);
			var outer = document.getElementById("event-table-detail");
			outer.appendChild(d3);
			if (is_enrolled) {
				document.getElementById("1_" + eventid).disabled = true;
				document.getElementById("2_" + eventid).disabled = false;
			} else {
				document.getElementById("1_" + eventid).disabled = false;
				document.getElementById("2_" + eventid).disabled = true;
			}
		}
		function createP(str, type) {
			var result = document.createElement(type);
			var node = document.createTextNode(str);
			result.setAttribute("style", "font-size:10px");
			result.appendChild(node);
			return result;
		}
		function createB(str, type) {
			var result = document.createElement(type);
			var node = document.createTextNode(str);
			result.appendChild(node);
			return result;
		}
		function createElement(type) {
			var result = document.createElement(type);
			return result;
		}
		function createDiv(ratio) {
			var d = createElement("div");
			d.setAttribute("class", "col-sm-" + ratio + " col-md-" + ratio);
			return d;
		}
		function setHomePage() {
			setActive("homePage");
			clearActive("profile");
			clearActive("message");
			clearActive("events");
			$("#test1").show(500);
			$("#test0").show(500);
			$("#test3").show(500);
			$("#test2").hide(500);
			$("#profileView").hide(500);
			$("#eventsView").hide(500);
			$("#nav").show(200);
		}
		function setProfile() {
			setActive("profile");
			clearActive("homePage");
			clearActive("message");
			clearActive("events");
			$("#profileView").show(500);
			$("#test1").hide(500);
			$("#test2").hide(500);
			$("#test0").hide(500);
			$("#test3").hide(500);
			$("#eventsView").hide(500);
			$("#nav").show(200);
			addUid();

			//hide chat
			$(".chat-wrapper").hide(500);
		}
		function setMessage() {
			setActive("message");
			clearActive("events");
			clearActive("profile");
			clearActive("homePage");
			$("#nav").show(200);

			/////////show message
			$(".chat-wrapper").hide(500);
			$("#test1").hide(500);
			$("#test2").hide(500);
			$("#test0").hide(500);
			$("#eventsView").hide();
			$("#test3").hide(500);
			$("#profileView").hide(500);
		}

		function setMessageInEventView(roomname) {
			setActive("message");
			clearActive("events");
			clearActive("profile");
			clearActive("homePage");
			$("#nav").show(200);

			/////////show message
			connectToChatserver(roomname);
			$(".chat-wrapper").show(500);
			$("#test1").hide(500);
			$("#test2").hide(500);
			$("#test0").hide(500);
			$("#eventsView").hide();
			$("#test3").hide(500);
			$("#profileView").hide(500);
		}

		function setEvents() {
			var myNode = document.getElementById("eventsDetail");
			while (myNode.firstChild) {
				myNode.removeChild(myNode.firstChild);
			}

			$.ajax({
				url : basicurl + "LookUpUserEvents",
				type : 'POST',
				dataType : "json",
				data : JSON.stringify({
					plantform : "asd",
					username : uid
				}),
				processData : false,
				ContentType : 'application/json',
				dataType : 'json',
				success : function(result) {
					var ress = result.event;
					for ( var indsa in ress) {
						var res = ress[indsa];
						createDetailEvent(res.event_id, res.address,
								res.activity_name, res.start_time,
								res.number_limit_from, res.number_limit_to,
								res.number_of, res.is_enrolled);
						var list = res.urlList;
						for (li in list) {
							insertPicture(res.event_id, list[li]);
						}
					}
				},
				error : AjaxFailed
			});

			setActive("events");
			clearActive("message");
			clearActive("profile");
			clearActive("homePage");
			$("#test1").hide(500);
			$("#test2").hide(500);
			$("#test0").hide(500);
			$("#test3").hide(500);
			$("#profileView").hide(500);
			$("#eventsView").show(500);
			$("#nav").show(200);

			//hide chat
			$(".chat-wrapper").hide(500);

		}
		function setActive(elementId) {
			var e = document.getElementById(elementId);
			e.setAttribute("class", "active");
		}
		function clearActive(elementId) {
			var e = document.getElementById(elementId);
			e.className = "";
		}
		function addUid() {
			var e = document.getElementById("user_id");
			e.value = uid;
		}

		function edit_profile() {
			var newprofile = {
				"plantform" : "asd",
				"user_id" : uid,
				"password" : pword,
				"profile" : {
					"user_id" : uid,
					"password" : "",
					"name" : document.getElementById("set_username").value,
					"date_of_birth" : document.getElementById("set_dob").value,
					"nationality" : document.getElementById("set_nationality").value,
					"gender" : document.getElementById("gender").value,
					"location_id" : 0,
					"image" : "",
					"online" : ""
				}
			};
			$.ajax({
				url : basicurl + "UpdateProfile",
				type : 'POST',
				dataType : "json",
				data : JSON.stringify(newprofile),
				processData : false,
				ContentType : 'application/json',
				dataType : 'json',
				success : function(result) {
					if (result.result) {
						getProfile();
					} else {
						alert("fail");
					}

				},
				error : function() {
				}
			});
		}
		function createDetailEvent(eventid, location, activityName, startTime,
				numberLimitFrom, numberLimitTo, currentNumber, is_enrolled) {
			var bt2 = createB("leave", "button");
			bt2.setAttribute("class", "btn btn-danger");
			bt2.id = "2_" + eventid;
			
			bt2.onclick=function(){
				$("#eventsView").hide(200);		
				$
				.ajax({
					url : basicurl + "Leave",
					type : 'POST',
					dataType : "json",
					data : JSON.stringify({
						plantform : "aads",
						userid : uid,
						eventid : this.id.substring(2)
					}),
					processData : false,
					ContentType : 'application/json',
					dataType : 'json',
					success : function(result) {
						setEvents();
						$("#eventsView").show(400);
					},
					error : function() {
					}
				});			
			}
			var bt3 = createB("chat", "button");
			bt3.setAttribute("class", "btn btn-success");
			bt3.id = "button" + eventid;
			bt3.onclick = function(e) {
				//alert(this.id);
				setMessageInEventView(e.id);
			}
			var divMidButton = createDiv(4);
			divMidButton.appendChild(bt2);
			var divRightButton = createDiv(4);
			divRightButton.appendChild(bt3);
			var d1 = createDiv("12");
			d1.setAttribute("class", "caption");
			d1.appendChild(createP("Location: " + location, "p"));
			d1.appendChild(createP("activityName: " + activityName, "p"));
			d1.appendChild(createP("startTime: " + startTime, "p"));
			d1.appendChild(createP("Limit:", "p"));
			var currentonline = createP(currentNumber + "/" + numberLimitTo,
					"p");
			currentonline.id = "3_" + eventid;
			d1.appendChild(currentonline);
			var image = createElement("img");
			image.src = "";
			var divInfo = createDiv(12);
			divInfo.appendChild(d1);
			var divLeft = createDiv(4);
			divLeft.appendChild(divInfo);
			divLeft.appendChild(divMidButton);
			divLeft.appendChild(divRightButton);
			var divRight = createDiv(8);
			divRight.appendChild(createCarousel(eventid));
			var uploadDiv = createDiv(12);
			var input = generateElement("input", [ [ "type", "file" ],
					[ "name", "images" ] ], null, null);
			input.id = eventid + "image";
			var inputAttribute = generateElement("input", [
					[ "type", "hidden" ], [ "name", "event_id" ],
					[ "value", eventid ] ], null, null);
			var uploadButton = generateElement("button",
					[ [ "type", "submit" ] ], null, "Upload photo!");
			var form = generateElement("form", [ [ "method", "post" ],
					[ "enctype", "multipart/form-data" ],
					[ "action", "EventImageUpload" ] ], null, null);
			form.appendChild(input);
			form.appendChild(inputAttribute);
			form.appendChild(uploadButton);
			uploadDiv.appendChild(form);
			divRight.appendChild(uploadDiv);
			//addCarouselController(eventid);
			/*<form method="post" enctype="multipart/form-data"
										action="Center">
										<input type="file" name="images" id="images" multiple /> <input
											type="hidden" id="user_id" name="user_id" value="" />
										<button type="submit" id="btn">Upload Files!</button>
									</form>*/
			var outer = document.getElementById("eventsDetail");
			var frame = createDiv(6);
			frame.appendChild(divLeft);
			frame.appendChild(divRight);
			outer.appendChild(frame);
			addCarouselController(eventid);
			document.getElementById("2_" + eventid).disabled = false;
		}
		function createCarousel(event_id) {
			var img = generateElement(
					"img",
					[ [ "src",
							"https://s3-us-west-2.amazonaws.com/eventplanner/765-default-avatar.png" ] ],
					null, null);
			var divUnder = generateElement("div", [ [ "class",
					"carousel-caption" ] ], null, null);
			var inner = generateElement("div", [ [ "class", "item active" ] ],
					null, null);
			inner.appendChild(img);
			inner.appendChild(divUnder);
			var imageFrame = generateElement("div", [
					[ "class", "carousel-inner" ], [ "role", "listbox" ] ],
					null, null);
			imageFrame.appendChild(inner);
			var li = generateElement("li", [
					[ "data-target", "#" + event_id + "carousel" ],
					[ "data-slide-to", "0" ], [ "class", "active" ] ], null,
					null)
			var ol = generateElement("ol",
					[ [ "class", "carousel-indicators" ] ], null, null);
			ol.appendChild(li);
			var car = generateElement("div", [ [ "class", "carousel slide" ],
					[ "data-ride", "carousel" ] ], null, null);
			car.appendChild(ol);
			car.appendChild(imageFrame);
			car.id = event_id + "carousel";
			return car;
		}
		function insertPicture(event_id, url) {
			var car = document.getElementById(event_id + "carousel");
			var img = generateElement("img", [ [ "src", url ],
					[ "alt", "...." ] ], null, null);
			var divUnder = generateElement("div", [ [ "class",
					"carousel-caption" ] ], null, null);
			var number = car.childNodes[0].children.length;
			var inner = generateElement("div", [ [ "class", "item" ] ], null,
					null);
			inner.appendChild(img);
			inner.appendChild(divUnder);
			var li = generateElement("li", [
					[ "data-target", "#" + event_id + "carousel" ],
					[ "data-slide-to", number ] ], null, null);
			car.childNodes[1].appendChild(inner);
			car.childNodes[0].appendChild(li);
		}
		function addCarouselController(event_id) {
			var controller = document.getElementById(event_id + "carousel");
			var ls1 = generateElement("span", [
					[ "class", "glyphicon glyphicon-chevron-left" ],
					[ "aria-hidden", "true" ] ], null, null);
			var ls2 = generateElement("span", [ "class", "sr-only" ], null,
					"Prev");
			var la = generateElement("span", [
					[ "class", "left carousel-control" ],
					[ "href", "#" + event_id + "carousel" ],
					[ "role", "button" ], [ "date-slide", "prev" ] ], null,
					null);
			la.appendChild(ls1);
			la.appendChild(ls2);
			var rs1 = generateElement("span", [
					[ "class", "glyphicon glyphicon-chevron-right" ],
					[ "aria-hidden", "true" ] ], null, null);
			var rs2 = generateElement("span", [ "class", "sr-only" ], null,
					"Next");
			var ra = generateElement("span", [
					[ "class", "right carousel-control" ],
					[ "href", "#" + event_id + "carousel" ],
					[ "role", "button" ], [ "date-slide", "next" ] ], null,
					null);
			ra.appendChild(rs1);
			ra.appendChild(rs2);
			controller.appendChild(la);
			controller.appendChild(ra);
		}
		/*<div id="carousel-example-generic" class="carousel slide"
			data-ride="carousel">
			<!-- Indicators -->
			<ol class="carousel-indicators">
				<li data-target="#carousel-example-generic" data-slide-to="0"
					class="active"></li>
				<li data-target="#carousel-example-generic" data-slide-to="1"></li>
				<li data-target="#carousel-example-generic" data-slide-to="2"></li>
			</ol>

			<!-- Wrapper for slides -->
			<div class="carousel-inner" role="listbox">
				<div class="item active">
					<img
						src="https://s3-us-west-2.amazonaws.com/eventplanner/765-default-avatar.png"
						alt="...">
					<div class="carousel-caption">...</div>
				</div>
			</div>

			<!-- Controls -->
			<a class="left carousel-control"
				href="#carousel-example-generic" role="button"
				data-slide="prev"> <span
				class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				<span class="sr-only">Previous</span>
			</a> <a class="right carousel-control"
				href="#carousel-example-generic" role="button"
				data-slide="next"> <span
				class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				<span class="sr-only">Next</span>
			</a>
		</div>*/
		function generateElement(elementType, attributes, childrenToAppend,
				innerHTML) {
			var i, isIE = navigator.appName == 'Microsoft Internet Explorer';
			if (isIE)
				tagCode = '<' + elementType;
			else
				newElement = document.createElement(elementType);
			if (attributes != null) {
				for (i = 0; i < attributes.length; i++) {
					if (attributes[i]) {
						if (isIE)
							tagCode += ' ' + attributes[i][0] + '="'
									+ attributes[i][1] + '"';
						else
							newElement.setAttribute(attributes[i][0],
									attributes[i][1]);
					}
				}
			}
			if (isIE)
				newElement = document.createElement(tagCode + '>');
			if (childrenToAppend != null) {
				for (i = 0; i < childrenToAppend.length; i++) {
					newElement.appendChild(childrenToAppend[i]);
				}
			}
			if (innerHTML)
				newElement.innerHTML = innerHTML;
			return newElement;
		}
		function learnRegExp(s) {
			var regexp = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;
			return regexp.test(s);
		}

		function getProfile() {
			$
					.ajax({
						url : basicurl + "GetProfile",
						type : 'POST',
						dataType : "json",
						data : JSON.stringify({
							userid : uid,
							plantform : ""
						}),
						processData : false,
						ContentType : 'application/json',
						dataType : 'json',
						success : function(result) {
							if (result.result) {
								var tmp = result.profile;
								document.getElementById("set_account").value = uid;
								document.getElementById("set_username").value = tmp.name;
								document.getElementById("set_dob").value = tmp.date_of_birth;
								document.getElementById("set_nationality").value = tmp.nationality;
								document.getElementById("gender").value = tmp.gender;
								if (learnRegExp(tmp.image)
										&& tmp.hasOwnProperty('image')) {
									document.getElementById("userImage").src = tmp.image;
								}
							}
						},
						error : AjaxFailed
					});
		}
	</script>
	<script type="text/javascript">
		$("#test1").hide();
		$("#test2").hide();
		$("#test0").hide();
		$("#test3").hide();
		$("#logout").hide();
		$("#nav").hide();
		$("#eventsView").hide();
		$("#profileView").hide();
		$(".chat-wrapper").hide();
		$message = $('#chatmessage');
		$chatWindow = $('#chatresponse');
		$('#do-chat').submit(function(evt) {
			evt.preventDefault();
			sendMessage();
		});
		$('#leave-room').click(function() {
			leaveRoom();
			setEvents();
		});
	</script>
</body>
</html>
