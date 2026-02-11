within EVRanger.Interfaces;

connector VelocitySignal
  Units.Velocity vel;
  annotation(
    Icon(graphics = {Ellipse(fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-98, 98}, {98, -98}}, endAngle = 360), Text(origin = {-5.68434e-14, 16},extent = {{98, -98}, {-98, 98}}, textString = "v")}));
end VelocitySignal;
