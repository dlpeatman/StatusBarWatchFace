using Toybox.Graphics as Gfx;
using Toybox.System as System;
using Toybox.WatchUi as Ui;
using Toybox.ActivityMonitor as ActivityMonitor;

class StatusBar extends Ui.Drawable {
    
    var font = Ui.loadResource(Rez.Fonts.agencyFBMedium);
    var heartIcon = Ui.loadResource(Rez.Drawables.Heart);
    var messageIcon = Ui.loadResource(Rez.Drawables.MessageIcon);
    var bluetoothIcon = Ui.loadResource(Rez.Drawables.Bluetooth);
    var footprintIcon = Ui.loadResource(Rez.Drawables.FootprintIcon);
    
    const barHeight = 28;
    const boxHeight = 26;
    const boxBuffer = 2;
    const boxPadding = 3;
    
    function draw(dc) {
        var notificationCount = System.getDeviceSettings().notificationCount;
        var phoneConnected = System.getDeviceSettings().phoneConnected;
        var heartRate = ActivityMonitor.getHeartRateHistory(1, true).next().heartRate;
        var stepCount = ActivityMonitor.getInfo().steps;
    
        // Draw the status bar background
        dc.setColor(Gfx.COLOR_DK_BLUE,Gfx.COLOR_DK_BLUE);
        dc.fillRectangle(0, dc.getHeight() - barHeight, dc.getWidth(), barHeight);
    
        var statusPairs = new [0];
        if (notificationCount > 0) {
            statusPairs.add([messageIcon, notificationCount.toString()]);
        } else if (phoneConnected) {
            statusPairs.add([bluetoothIcon, ""]);
        }
        
        if (heartRate > 0 && heartRate < 255) {
            statusPairs.add([heartIcon, heartRate.toString()]);
        } else {
            statusPairs.add([heartIcon, "--"]);
        }
        statusPairs.add([footprintIcon, stepCount.toString()]); 
        
        var totalWidth = 0;
        for (var i=0; i<statusPairs.size(); i++) {
            totalWidth += calculateBoxWidth(dc, statusPairs[i], font) + boxBuffer;
        }
        
        var xPos = dc.getWidth()/2 - totalWidth/2;
        for (var i=0; i<statusPairs.size(); i++) {
            drawBox(dc, xPos, font, statusPairs[i]);
            xPos += calculateBoxWidth(dc, statusPairs[i], font) + boxBuffer;
        }
    }
    
    function drawBox(dc, xPos, font, statusPair) {
        var boxWidth = calculateBoxWidth(dc, statusPair, font);
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_WHITE);
        dc.fillRoundedRectangle(xPos, dc.getHeight() - boxHeight - (barHeight-boxHeight)/2, boxWidth, boxHeight, 3);
        var resource = statusPair[0];
        dc.drawBitmap(xPos + boxPadding, dc.getHeight() - Math.ceil(resource.getHeight()/2.0) - boxHeight/2, resource);
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
        dc.drawText(xPos + resource.getWidth() + boxBuffer*2 + 1, dc.getHeight() - Gfx.getFontHeight(font)-1, font, statusPair[1], Gfx.TEXT_JUSTIFY_LEFT);
    }
    
    function calculateBoxWidth(dc, statusPair, font) {
        var resourceWidth = statusPair[0].getWidth() - 1;
        if (statusPair[1].length() > 0) {
            return resourceWidth + dc.getTextDimensions(statusPair[1], font)[0] + boxPadding*3;
        } else {
            return resourceWidth + 2*boxPadding;
        }
    }
}