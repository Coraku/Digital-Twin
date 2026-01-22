within EVRanger.Interfaces;

connector BatteryAvailableSignal
  Boolean batteryAvailable;
  annotation(
    Icon(graphics = {Ellipse(fillColor = {255, 85, 127}, fillPattern = FillPattern.Solid, extent = {{-98, 98}, {98, -98}}, endAngle = 360), Polygon(origin = {4, 4}, fillPattern = FillPattern.Solid, points = {{-23, 74}, {27, 74}, {5, 10}, {35, 10}, {-22, -88}, {-11, -15}, {-28, -15}, {-23, 74}})}));
end BatteryAvailableSignal;
