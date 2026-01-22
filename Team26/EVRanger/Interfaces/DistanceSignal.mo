within EVRanger.Interfaces;

connector DistanceSignal
Real x;
  annotation(
    Icon(graphics = {Ellipse( fillColor = {255, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-98, 98}, {98, -98}}, endAngle = 360), Text(origin = {1.42109e-14, 16},extent = {{-98, 98}, {98, -98}}, textString = "s")}));
end DistanceSignal;
