<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
  <!-- swfobject is a commonly used library to embed Flash content -->
  <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/swfobject/2.2/swfobject.js"></script>

  <!-- Setup the recorder interface -->
  <script type="text/javascript" src="js/recorder.js"></script>

  <!-- GUI code... take it or leave it -->
  <script type="text/javascript" src="js/gui.js"></script>

  <script>
    var recordButton, playButton;
    var recordInterval, playInterval;

    function setupRecorder() {
	Wami.setup(function () {
	    checkSecurity();
	}, "wami");
    }

    function checkSecurity() {
	var settings = Wami.getSettings();
	if (settings.microphone.granted) {
	    listen();
	    Wami.hide();
	    setupButtons();
	} else {
	    // Show any Flash settings panel you want using the string constants
	    // defined here:
	    // http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/system/SecurityPanel.html
	    Wami.showSecurity("privacy", "Wami.show", "checkSecurity", "zoomError");
	}
    }

    function listen() {
	Wami.startListening();
	// Continually listening when the window is in focus allows us to
	// buffer a little audio before the users clicks, since sometimes
	// people talk too soon. Without "listening", the audio would record
	// exactly when startRecording() is called.
	window.onfocus = function () {
	    Wami.startListening();
	};

	// Note that the use of onfocus and onblur should probably be replaced
	// with a more robust solution (e.g. jQuery's $(window).focus(...)
	window.onblur = function () {
	    Wami.stopListening();
	};

    }

    function zoomError() {
	// The minimum size for the flash content is 214x137. Browser's zoomed out
	// too far won't show the panel.
	// We could play the game of re-embedding the Flash in a larger DIV here,
	// but instead we just warn the user:
	alert("Your browser may be zoomed too far out to show the Flash security settings panel.  Zoom in, and refresh.");
    }

    function setupButtons() {
	recordButton = new Wami.Button("recordDiv", Wami.Button.RECORD);
	recordButton.onstart = startRecording;
	recordButton.onstop = stopRecording;
	recordButton.setEnabled(true);

	playButton = new Wami.Button("playDiv", Wami.Button.PLAY);
	playButton.onstart = startPlaying;
	playButton.onstop = stopPlaying;
	playButton.setEnabled(false);
    }

    /**
     * These methods are called on clicks from the GUI.
     */

    function startRecording() {
	recordButton.setActivity(0);
	playButton.setEnabled(false);
	Wami.startRecording("getAudio", "onRecordStart", "onRecordFinish", "onError");
    }

    function stopRecording() {
	Wami.stopRecording();
	clearInterval(recordInterval);
	recordButton.setEnabled(true);
    }

    function startPlaying() {
	playButton.setActivity(0);
	recordButton.setEnabled(false);
	Wami.startPlaying("getAudio", "onPlayStart", "onPlayFinish", "onError");
    }

    function stopPlaying() {
	Wami.stopPlaying();
    }

    /**
     * Callbacks from the flash indicating certain events
     */

    function onError(e) {
	alert(e);
    }

    function onRecordStart() {
	recordInterval = setInterval(function () {
	    if (recordButton.isActive()) {
		var level = Wami.getRecordingLevel();
		recordButton.setActivity(level);
	    }
	}, 200);
    }

    function onRecordFinish() {
	playButton.setEnabled(true);
    }

    function onPlayStart() {
	playInterval = setInterval(function () {
	    if (playButton.isActive()) {
		var level = Wami.getPlayingLevel();
		playButton.setActivity(level);
	    }
	}, 200);
    }

    function onPlayFinish() {
	clearInterval(playInterval);
	recordButton.setEnabled(true);
	playButton.setEnabled(true);
    }
</script>
</head>

<body onload="setupRecorder()">

  <!--  <div style="margin: 1em"> -->
   <div style="position: absolute; left: 400px; top: 20px; font-family: arial,sans-serif; font-size: 82%">
    <div id="recordDiv" style="display:inline-block;" ></div>
    <div id="playDiv" style="display:inline-block;"></div>
    <!--  <div id="wami-container"> -->
    <div id="wami"></div>
    <!--   </div> -->
  </div>
  <noscript><p>WAMI requires Javascript</p></noscript>
</body>
</html>
