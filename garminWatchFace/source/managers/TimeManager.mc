import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

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

    public function drawTime(dc as Toybox.Graphics.Dc) as Void {
        var timeString = getTimeString();
        var view = watchFaceView.getWatchView().findDrawableById("TimeLabel") as Text;

        if (view != null) {
            view.setText(timeString);
            view.setBackgroundColor(Graphics.COLOR_DK_BLUE);
            view.setColor(Graphics.COLOR_GREEN);
        } else {
            System.println("Error: TimeLabel view not found!");
        }
    }
}
