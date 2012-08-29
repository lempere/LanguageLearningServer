var recordButton;
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

    }

    /**
     * These methods are called on clicks from the GUI.
     */

    function startRecording() {
	recordButton.setActivity(0);
	
	console.debug("Print from start recording " + idAudio);
	if(idAudio==null)
		Wami.startRecording("getAudio", "onRecordStart", "onRecordFinish", "onError");
	else
		Wami.startRecording("getAudio?audio="+idAudio, "onRecordStart", "onRecordFinish", "onError");		
    }

    function stopRecording() {
	Wami.stopRecording();
	clearInterval(recordInterval);
	recordButton.setEnabled(true);
	//Send what audio have to process with, start to get score
		getScore = true;
    }

    function startPlaying() {
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
    	tries = 7;
    	loadScore();
    }