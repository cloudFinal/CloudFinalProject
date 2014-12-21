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
<script src="js/upload.js"></script>
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
	var prefs;
	var currentPreference;

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

	function loadXMLDoc() {
		uid = document.getElementById("username").value;
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
			$("#logout").show(100);
			getAndCreateAllPreference();
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
			$("#logout").show(100);
			getAndCreateAllPreference();
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
					}
				},
				error : AjaxFailed
			});
			clearEventMarker();
			addMarker(parseFloat(prefs[indexi].latitude),
					parseFloat(prefs[indexi].longitude));
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
						<div id="event-table" class="panel-body">
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
										<input type="file" name="images" id="images" multiple />
										<input type="hidden" id="user_id" name="user_id" value="askjdhkasjdh"/>
										<button type="submit" id="btn">Upload Files!</button>
									</form>
									<div id="response"></div>
								</div>
								<div class="col-sm-4 col-md-4">
									<table class="table">
										<tbody>
											<tr>
												<td>Account</td>
												<td id="set_account"></td>
											</tr>
											<tr>
												<td>Password</td>
												<td><button class="btn btn-default">Change</button></td>
											</tr>
											<tr>
												<td>User Name</td>
												<td id="set_username">1</td>
											</tr>
											<tr>
												<td>Date of Birth</td>
												<td id="set_dob">1</td>
											</tr>
											<tr>
												<td>Nationality</td>
												<td id="set_nationality">1</td>
											</tr>
											<tr>
												<td>Location</td>
												<td id="set_currentlocation">1</td>
											</tr>

										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
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
		$("#test1").hide();
		$("#test2").hide();
		$("#test0").hide();
		$("#logout").hide();
		$("#profileView").hide();
	</script>
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
													document.getElementById("event_loading").className = "";
												},
												error :function() {
													document.getElementById("event_loading").className = "";
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
													document.getElementById("event_loading").className = "";
												},
												error : function(){
													document.getElementById("event_loading").className = "";
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
					"p")
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
		function setHomePage() {
			setActive("homePage");
			clearActive("profile");
			clearActive("message");
			$("#test1").show(500);
			$("#test2").hide(500);
			$("#test0").show(500);
			$("#test3").show(500);
			$("#profileView").hide(500);
			$("#nav").show(200);
		}
		function setProfile() {
			setActive("profile");
			clearActive("homePage");
			clearActive("message");
			$("#test1").hide(500);
			$("#test2").hide(500);
			$("#test0").hide(500);
			$("#test3").hide(500);
			$("#profileView").show(500);
			$("#nav").show(200);
			addUid();
		}
		function setMessage() {
			setActive("message");
			clearActive("profile");
			clearActive("homePage");
			$("#nav").show(200);
		}
		function setActive(elementId) {
			var e = document.getElementById(elementId);
			e.setAttribute("class", "active");
		}
		function clearActive(elementId) {
			var e = document.getElementById(elementId);
			e.className = "";
		}
		function addUid(){
			var e =document.getElementById("user_id");
			e.setAttribute("user_id", "zhang");
		}
	</script>
</body>
</html>
