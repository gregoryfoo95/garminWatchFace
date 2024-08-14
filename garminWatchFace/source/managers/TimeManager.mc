import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Graphics;

class TimeManager { 
    private static var timeFont as FontResource;
    private var watchFaceView as garminWatchFaceView;

    public function initialize(timeFontResource as FontResource, watchFaceViewInstance as garminWatchFaceView) {
        timeFont = timeFontResource;
        watchFaceView = watchFaceViewInstance;
    }

    private function getTimeString() as String {
        var clockTime = System.getClockTime() as ClockTime;
        var hour = clockTime.hour as Number;
        if (hour > 12) {
            hour -= 12;
        }
        return Lang.format("$1$:$2$", [
            hour,
            clockTime.min.format("%02d"),
        ]);
    }

     // Method to draw the time on the screen
    public function drawTime(dc as Dc) as Void {
        var timeString = getTimeString();
        var timeLabel = getTimeLabel("TimeLabel");

        if (watchFaceView != null) {
            updateView(timeLabel, timeString);
        } else {
            handleError("TimeLabel view not found!");
        }
    }

    // Encapsulate timeLabel retrieval
    private function getTimeLabel(labelId as String) as WatchUi.Text {
        return watchFaceView.getWatchView().findDrawableById(labelId) as WatchUi.Text;
    }

    // Update the view with the time string and styles
    private function updateView(view as WatchUi.Text, timeString as String) as Void {
        view.setText(timeString);
        view.setBackgroundColor(Graphics.COLOR_DK_BLUE);
        view.setColor(Graphics.COLOR_GREEN);
    }

    // Handle errors gracefully
    private function handleError(message as String) as Void {
        System.println("Error: " + message);
    }
}
