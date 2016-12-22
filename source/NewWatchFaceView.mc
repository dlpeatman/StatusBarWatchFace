using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time as Time;
using Toybox.Time.Gregorian as Gregorian;

class NewWatchFaceView extends Ui.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the viewd
    function onUpdate(dc) {
        // Get and show the current time
        var clockTime = Sys.getClockTime();
        
        var hour = (Sys.getDeviceSettings().is24Hour) ? clockTime.hour : (clockTime.hour > 12) ? clockTime.hour - 12 : clockTime.hour;
        var minute = clockTime.min.format("%02d");
        var timeString = Lang.format("$1$:$2$", [hour, minute]);
        var view = View.findDrawableById("TimeLabel");
        view.setText(timeString);
        var date = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var view2 = View.findDrawableById("DateLabel");
        var dateString = Lang.format("$1$ $2$, $3$",[date.month, date.day, date.year]);
        view2.setText(dateString);
        

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}

class CustomBatterySegment extends Ui.Drawable {
    function draw(dc) {
    
    }
}
