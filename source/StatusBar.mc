using Toybox.Graphics as Gfx;
using Toybox.System as System;
using Toybox.WatchUi as Ui;
using Toybox.ActivityMonitor as ActivityMonitor;

class StatusBar extends Ui.Drawable {
    
    var font = Ui.loadResource(Rez.Fonts.agencyFBMedium);
    
    const barHeight = 28;
    const boxHeight = 26;
    const boxBuffer = 2;
    const boxPadding = 3;
    
    function draw(dc) {
        var notificationCount = System.getDeviceSettings().notificationCount;
        var phoneConnected = System.getDeviceSettings().phoneConnected;
        var heartRate = ActivityMonitor.getHeartRateHistory(1, true).next().heartRate;
    
        // Draw the status bar background
        dc.setColor(Gfx.COLOR_DK_BLUE,Gfx.COLOR_DK_BLUE);
        dc.fillRectangle(0, dc.getHeight() - barHeight, dc.getWidth(), barHeight);
    
        var textArray = new [0];
        if (notificationCount > 0) {
            textArray.add(notificationCount.toString());
        } else if (phoneConnected) {
            textArray.add("BT");
        }
        textArray.add(heartRate.toString());
        
        var totalWidth = 0;
        for (var i=0; i<textArray.size(); i++) {
            totalWidth += calculateBoxWidth(dc, textArray[i], font) + boxBuffer;
        }
        
        var xPos = dc.getWidth()/2 - totalWidth/2;
        for (var i=0; i<textArray.size(); i++) {
            drawBox(dc, xPos, font, textArray[i]);
            xPos += calculateBoxWidth(dc, textArray[i], font) + boxBuffer;
        }
    }
    
    function drawBox(dc, xPos, font, text) {
        var boxWidth = calculateBoxWidth(dc, text, font);
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_WHITE);
        dc.fillRoundedRectangle(xPos, dc.getHeight() - boxHeight - (barHeight-boxHeight)/2, boxWidth, boxHeight, 3);
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
        dc.drawText(xPos + boxWidth/2, dc.getHeight() - Gfx.getFontHeight(font)-1, font, text, Gfx.TEXT_JUSTIFY_CENTER);
    }
    
    function calculateBoxWidth(dc, text, font) {
        return dc.getTextDimensions(text, font)[0] + boxPadding*2;
    }
}