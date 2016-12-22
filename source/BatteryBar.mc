using Toybox.Graphics as Gfx;
using Toybox.System as System;
using Toybox.WatchUi as Ui;

class BatteryBar extends Ui.Drawable {
    
    var barStartPos = 45;
    var barEndPos = 164;
    var barWidth = barEndPos - barStartPos;
    var numSegments = 17;
    var segmentHeight = 15;
    var segmentWidth = (barEndPos - barStartPos)/numSegments;
    
    var orangeThreshold = .15;
    var yellowThreshold = .30;
    var greenThreshold = .50;
    
    function draw(dc) {
        var batteryLevel = System.getSystemStats().battery;
        
        dc.setColor(Gfx.COLOR_RED,Gfx.COLOR_BLACK);
        
        // Fill in the initial bar
        dc.fillRectangle(0,0, barStartPos, segmentHeight);
        
        for (var i=0; i<numSegments; i++) {
            var percentFilled = (i+1.0)/numSegments;
            
            // Change the color of the segment depending on the battery percentage
            if (percentFilled > greenThreshold) {
                dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_BLACK);
            } else if (percentFilled > yellowThreshold) {
                dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_BLACK);
            } else if (percentFilled > orangeThreshold) {
                dc.setColor(Gfx.COLOR_ORANGE, Gfx.COLOR_BLACK);
            }
            
            dc.fillRectangle(barStartPos + i*segmentWidth, 0, segmentWidth-1, segmentHeight);
            
            // If battery level is 99% or higher, the final bar will be drawn below
            if (percentFilled*100 > batteryLevel+1) {
                return;
            }
        }
        
        // Fill the last battery full bar
        dc.fillRectangle(barEndPos, 0, 40, segmentHeight);
    }
}