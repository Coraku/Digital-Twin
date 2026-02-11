within EVRanger.Interfaces;

connector TorqueSignal
  Units.Torque tau; // % of max torque -> encapsulation, no back and forth
  annotation(
    Icon(graphics = {Ellipse( fillColor = {170, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-98, 98}, {98, -98}}, endAngle = 360), Text(origin = {0, 16},extent = {{-100, 100}, {100, -100}}, textString = "τ")}));
end TorqueSignal;
