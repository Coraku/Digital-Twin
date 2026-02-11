within EVRanger.Interfaces;

connector AccelerationSignal
Units.Acceleration acc;
  annotation(
    Diagram,
    Icon(graphics = {Ellipse(fillColor = {170, 255, 127}, fillPattern = FillPattern.Solid, extent = {{-98, 98}, {98, -98}}, endAngle = 360), Text(origin = {0, -80}, extent = {{98, 0}, {-98, 196}}, textString = "a")}));
end AccelerationSignal;
