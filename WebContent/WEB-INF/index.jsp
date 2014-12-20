<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap 101 Template</title>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<link
	href="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.2.2/css/bootstrap-combined.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" media="screen"
	href="http://tarruda.github.com/bootstrap-datetimepicker/assets/css/bootstrap-datetimepicker.min.css">
<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

<script>
	var uid;
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
			url : 'http://localhost:8080/CloudFinal/Login',
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
			document.getElementById("welcome").innerHTML = "Success!";
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
			$("#test3").show(1000);
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
			url : 'http://localhost:8080/CloudFinal/Register',
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
			document.getElementById("welcome").innerHTML = "Success!";
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
			$("#test3").show(1000);
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
		var array = {
			"plantform" : "haha",
			"preference" : {
				"user_id" : uid,
				"preference_name" : document.getElementById("preference_name").value,
				"location_id" : document.getElementById("address").value
						.hashCode(),
				"distance_to_tolerance" : document
						.getElementById("distance_to_tolerance").value,
				"start_time" : document.getElementById("start_time").value,
				"end_time" : document.getElementById("end_time").value,
				"key_word" : document.getElementById("key_word").value,
				"activity_name" : document.getElementById("activity_name").value,
				"number_limit_from" : document
						.getElementById("number_limit_from").value,
				"number_limit_to" : document.getElementById("number_limit_to").value
			}
		};
		$
				.ajax({
					url : 'http://localhost:8080/CloudFinal/InsertLocation',
					type : 'POST',
					dataType : "json",
					data : JSON
							.stringify({
								"plantform" : "haha",
								"location" : {
									"location_id" : document
											.getElementById("address").value
											.hashCode(),
									"address" : document
											.getElementById("address").value,
									"longitude" : document
											.getElementById("longitude").value,
									"latitude" : document
											.getElementById("latitude").value
								}
							}),
					processData : false,
					ContentType : 'application/json',
					dataType : 'json',
					success : function(result) {
						if (result.result) {
							$
									.ajax({
										url : 'http://localhost:8080/CloudFinal/InsertPreference',
										type : 'POST',
										dataType : "json",
										data : JSON.stringify(array),
										processData : false,
										ContentType : 'application/json',
										dataType : 'json',
										success : function(result) {
											alert("GOOGOGOGOGOOGGO!!");
										},
										error : AjaxFailed
									});
						}
					},
					error : AjaxFailed
				});
	}
</script>
<script type="text/javascript">
	var marker = [];
	var tmpMarker;
	var infowindow = [];
	var infowindow2 = [];
	var mapline = [];
	var address;
	var x;
	var y;
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
		document.getElementById('address').innerHTML = str;
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
		var map = new google.maps.Map(document.getElementById("dvMap"),
				mapOptions);
		var pinColor = "0000ff";
		var pinImage = new google.maps.MarkerImage(
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
					if (tmpMarker != null) {
						tmpMarker.setMap(null);
					}
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
</script>


</head>
<body>
	<nav class="navbar navbar-default" role="navigation">
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
			<ul class="nav navbar-nav">
				<li class="active"><a href="#">Link <span class="sr-only">(current)</span></a></li>
				<li><a href="#">Link</a></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-expanded="false">Dropdown
						<span class="caret"></span>
				</a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="#">Action</a></li>
						<li><a href="#">Another action</a></li>
						<li><a href="#">Something else here</a></li>
						<li class="divider"></li>
						<li><a href="#">Separated link</a></li>
						<li class="divider"></li>
						<li><a href="#">One more separated link</a></li>
					</ul></li>
			</ul>
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
			</div>
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container-fluid --> </nav>
	<div>
		<div class="row">
			<div class="col-sm-2 col-md-2 sidebar" id="test0">
				<ul class="nav nav-sidebar">
					<li><a href="#"
						onclick="$( '#test1' ).show(600);$( '#test2' ).hide(400)">New
							Preference</a></li>
				</ul>
				<ul class="nav nav-sidebar" id="preflist">
					<li><a href="#"
						onclick="$( '#test1' ).hide(400);$( '#test2' ).show(600)">Reports</a></li>
					<li><a href="#">Analytics</a></li>
					<li><a href="#">Export</a></li>
				</ul>
			</div>
			<div class="col-sm-5 col-md-5" id="test1">
				<div class="jumbotron">
					<div class="container">
						<div class="row" id="divt">
							<input type="text" class="form-control" id="preferencename"
								placeholder="preference">
							<div>
								<input id="distance_to_tolerance"></input><label>distance_to_tolerance</label>
								<input id="start_time"></input><label>start_time</label> <input
									id="end_time"></input><label>end_time</label> <input
									id="key_word"></input><label>key_word</label> <input
									id="activity_name"></input><label>activity_name</label> <input
									id="number_limit_from"></input><label>number_limit_from</label>
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
			<div class="well">
				<div id="datetimepicker" class="input-append date">
					<input type="text"></input> <span class="add-on"> <i
						data-time-icon="icon-time" data-date-icon="icon-calendar"></i>
					</span>
				</div>
			</div>
			<div class="col-sm-4 col-md-4" id="test2">
				<div class="jumbotron">
					<h1 class="text-center" id="welcome">SHA!</h1>
					<div class="container">
						<div class="row" id="divt">
							<div class="col-sm-6 col-md-6 col-lg-6">
								<button type="button" class="btn btn-primary btn-block"
									id="addPref" onclick="addPref()">AddPref</button>
							</div>
							<div>
								<input id="preference name"></input><label>preference
									name</label> <input id="distance_to_tolerance"></input><label>distance_to_tolerance</label>
								<input id="start_time"></input><label>start_time</label> <input
									id="end_time"></input><label>end_time</label> <input
									id="key_word"></input><label>key_word</label> <input
									id="activity_name"></input><label>activity_name</label> <input
									id="number_limit_from"></input><label>number_limit_from</label>
								<input id="number_limit_to"></input><label>number_limit_to</label>
								<input id="address"></input><label>address</label> <input
									id="longitude"></input><label>longitude</label> <input
									id="latitude"></input><label>latitude</label>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-5 col-md-5" style="float: right" id="test3">
				<div id="dvMap" style="height: 400px"></div>
			</div>
		</div>
	</div>
	<script type="text/javascript"
		src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
	<script type="text/javascript"
		src="http://cdnjs.cloudflare.com/ajax/libs/jquery/1.8.3/jquery.min.js">
		
	</script>
	<script type="text/javascript"
		src="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.2.2/js/bootstrap.min.js">
		
	</script>
	<script type="text/javascript"
		src="http://tarruda.github.com/bootstrap-datetimepicker/assets/js/bootstrap-datetimepicker.min.js">
		
	</script>
	<script type="text/javascript"
		src="http://tarruda.github.com/bootstrap-datetimepicker/assets/js/bootstrap-datetimepicker.pt-BR.js">
		
	</script>
	<script type="text/javascript">
		$('#datetimepicker').datetimepicker({
			format : 'dd/MM/yyyy hh:mm:ss',
			language : 'pt-BR'
		});
	</script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$("#test1").hide();
		$("#test2").hide();
		$("#test3").hide();
		$("#test0").hide();
	</script>
</body>
</html>