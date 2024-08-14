import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class garminWatchFaceView extends WatchUi.WatchFace {
  private var timeFont as FontResource;
  private var timeManager as TimeManager;

  function initialize() {
    WatchFace.initialize();
    timeFont = Application.loadResource(Rez.Fonts.TimeFont);

    timeManager = new TimeManager(timeFont, self);
    timeManager.initialize(timeFont, self);
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
    View.onUpdate(dc);
    timeManager.drawTime(dc);
    drawHeartRateLabel(dc);
  }

  function drawHeartRateLabel(dc as Dc) as Void {
    var heartRateLabel = View.findDrawableById("HeartRateLabel") as Text;
    heartRateLabel.setText(getHeartRateString());
  }
  private function getHeartRate() as Number {
    var heartrateIterator = Toybox.ActivityMonitor.getHeartRateHistory(1, true);
    return heartrateIterator.next().heartRate;
  }

  private function getHeartRateString() as String {
    return getHeartRate().format("%d");
  }

  // Called when this View is removed from the screen. Save the
  // state of this View here. This includes freeing resources from
  // memory.
  function onHide() as Void {}

  // The user has just looked at their watch. Timers and animations may be started here.
  function onExitSleep() as Void {}

  // Terminate any active timers and prepare for slow updates.
  function onEnterSleep() as Void {}

  public function getWatchView() as Toybox.WatchUi.View {
    return self;
  }
}
