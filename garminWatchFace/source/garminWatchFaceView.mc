import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class garminWatchFaceView extends WatchUi.WatchFace {
  private var timeFont;
  private var dataFont;
  private var dateFont;
  private var stepsIcon;
  private var heartIcon;

  function initialize() {
    WatchFace.initialize();
    timeFont = Application.loadResource(Rez.Fonts.TimeFont);
  }

  // Load your resources here
  function onLayout(dc as Dc) as Void {
    setLayout(Rez.Layouts.WatchFace(dc));
  }

  // Called when this View is brought to the foreground. Restore
  // the state of this View and prepare it to be shown. This includes
  // loading resources into memory.
  function onShow() as Void {}

  // Update the view
  function onUpdate(dc as Dc) as Void {
    drawTime(dc);
    View.onUpdate(dc);
  }

  function drawTime(dc as Dc) as Void {
    var clockTime = System.getClockTime();
    var hour = clockTime.hour;
    if (hour > 12) {
      hour -= 12;
    }
    var timeString = Lang.format("$1$:$2$", [
      hour,
      clockTime.min.format("%02d"),
    ]);

    var view = View.findDrawableById("TimeLabel") as Text;

    if (view != null) {
      view.setText(timeString);
      view.setBackgroundColor(Graphics.COLOR_DK_BLUE);
      view.setColor(Graphics.COLOR_GREEN);
    } else {
      System.println("Error: TimeLabel view not found!");
    }
  }

  // Called when this View is removed from the screen. Save the
  // state of this View here. This includes freeing resources from
  // memory.
  function onHide() as Void {}

  // The user has just looked at their watch. Timers and animations may be started here.
  function onExitSleep() as Void {}

  // Terminate any active timers and prepare for slow updates.
  function onEnterSleep() as Void {}
}
