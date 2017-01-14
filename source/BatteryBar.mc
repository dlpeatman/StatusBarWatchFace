using Toybox.Graphics as Gfx;
using Toybox.System as System;
using Toybox.WatchUi as Ui;

class BatteryBar extends Ui.Drawable {

    var barStartPos = (System.getDeviceSettings().screenShape == System.SCREEN_SHAPE_RECTANGLE) ? 9 : 48;
    var numSegments = (System.getDeviceSettings().screenShape == System.SCREEN_SHAPE_RECTANGLE) ? 16 : 15;
    var segmentHeight = 15;

    // Percent thresholds for setting bar color
    var orangeThreshold = 15;
    var yellowThreshold = 30;
    var greenThreshold = 50;

    function draw(dc) {
        var batteryLevel = System.getSystemStats().battery;

        dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_BLACK);
        var startPolygon = [[0,0],
                [barStartPos-1, 0],
                [barStartPos+2, segmentHeight/2],
                [barStartPos-1, segmentHeight],
                [0, segmentHeight]];
        dc.fillPolygon(startPolygon);

        var polygon = [[barStartPos, 0],
                [barStartPos + segmentHeight/2, 0],
                [barStartPos + 10, segmentHeight/2],
                [barStartPos + 7, segmentHeight],
                [barStartPos, segmentHeight],
                [barStartPos+3, segmentHeight/2]];

        for (var i=0; i<numSegments; i++) {
            var percentFilled = 100.0*i/numSegments;
            if (percentFilled > batteryLevel) {
                return;
            }

            setBarColor(dc, percentFilled);
            dc.fillPolygon(polygon);
            movePolygon(polygon, 8, 0);
        }

        if (batteryLevel >= 99) {
            var endPolygon = [polygon[0],
                    [dc.getWidth(), 0],
                    [dc.getWidth(), segmentHeight],
                    polygon[4],
                    polygon[5]];
            dc.fillPolygon(endPolygon);
        }
    }

    function setBarColor(dc, percentFilled) {
        if (percentFilled > greenThreshold) {
            dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_BLACK);
        } else if (percentFilled > yellowThreshold) {
            dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_BLACK);
        } else if (percentFilled > orangeThreshold) {
            dc.setColor(Gfx.COLOR_ORANGE, Gfx.COLOR_BLACK);
        } else {
            dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_BLACK);
        }
    }

    function movePolygon(polygon, x, y) {
        for (var i=0; i<polygon.size(); i++) {
            polygon[i][0] = polygon[i][0] + x;
            polygon[i][1] = polygon[i][1] + y;
        }
    }
}