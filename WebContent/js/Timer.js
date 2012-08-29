var Timer;
var TotalSeconds;
var TriggerOnComplete;


function CreateTimer(TimerID, Time) {
        Timer = document.getElementById(TimerID);
        TotalSeconds = Time;
        
        UpdateTimer();
        window.setTimeout("TickEvent()", 1000);
}
function CreateTimerEvent(Event, Time) {
    TriggerOnComplete = Event;
    TotalSeconds = Time;
    
    window.setTimeout("TickEvent()", 1000);
}

function TickEvent() {
		if(TotalSeconds <= 0) {
			TriggerOnComplete;
            return;
		}
        TotalSeconds -= 1;
        //UpdateTimer();
        window.setTimeout("TickEvent()", 1000);
}
//Show seconds in html
function UpdateTimer() {
        Timer.innerHTML = TotalSeconds;
}
