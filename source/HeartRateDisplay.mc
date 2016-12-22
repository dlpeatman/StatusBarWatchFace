using Toybox.Graphics as Gfx;
using Toybox.System as System;
using Toybox.WatchUi as Ui;
using Toybox.Activity as Activity;

class HeartRateDisplay extends Ui.Drawable {
    
    //var font = Ui.loadResource(Rez.Fonts.agencyFBSmall);
    
    function draw(dc) {
        //dc.drawText(dc.getWidth() - dc.getWidth()/4 - 20, dc.getHeight() - Gfx.getFontHeight(font)-2, font, Activity.getActivityInfo().currentHeartRate, Gfx.TEXT_JUSTIFY_CENTER);
    }
}