using Toybox.Graphics as Gfx;
using Toybox.System as System;
using Toybox.WatchUi as Ui;
using Toybox.Activity as Activity;

class StatusBar extends Ui.Drawable {
    
    var font = Ui.loadResource(Rez.Fonts.agencyFBSmall);
    
    const boxHeight = 22;
    const boxWidth = 20;
    
    function draw(dc) {
        var notificationCount = System.getDeviceSettings().notificationCount;
        var phoneConnected = System.getDeviceSettings().phoneConnected;
    
        if (notificationCount > 0) {
            // Create the notification box
            dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_BLACK);
            dc.drawRoundedRectangle(dc.getWidth()/2 - boxWidth/2, dc.getHeight() - boxHeight, boxWidth, boxHeight, 3);
            
            // Fill with the number of notifications
            dc.drawText(dc.getWidth()/2, dc.getHeight()-Gfx.getFontHeight(font)-2, font, notificationCount, Gfx.TEXT_JUSTIFY_CENTER);
        } else if (phoneConnected) {
            // Create the notification box
            dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_BLACK);
            dc.drawRoundedRectangle(dc.getWidth()/2 - boxWidth/2, dc.getHeight() - boxHeight, boxWidth, boxHeight, 3);
            
            // Fill with the number of notifications
            dc.drawText(dc.getWidth()/2+1, dc.getHeight()-Gfx.getFontHeight(font)-2, font, "BT", Gfx.TEXT_JUSTIFY_CENTER);
        }
    }
}