import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class TimeManager {
  private static var timeFont;
  private var watchFaceView;

  public function initialize(
    timeFontResource as FontResource,
    watchFaceViewInstance as garminWatchFaceView
  ) {
    timeFont = timeFontResource;
    watchFaceView = watchFaceViewInstance;
  }

  private function getTimeString() as String {
    var clockTime = System.getClockTime() as ClockTime;
    var hour = clockTime.hour as Number;
    if (hour > 12) {
      hour -= 12;
    }
    return Lang.format("$1$:$2$", [hour, clockTime.min.format("%02d")]);
  }

  public function drawTime(dc as Toybox.Graphics.Dc) as Void {
    dc /*>timeString<*/ = getTimeString();
    var view =
      watchFaceView.getWatchView().findDrawableById("TimeLabel") as Text;

    if (view != null) {
      view.setText(dc /*>timeString<*/);
      view.setBackgroundColor(0x0000ff as Toybox.Graphics.ColorValue);
      view.setColor(0x00ff00 as Toybox.Graphics.ColorValue);
    } else {
      System.println("Error: TimeLabel view not found!");
    }
  }
}
