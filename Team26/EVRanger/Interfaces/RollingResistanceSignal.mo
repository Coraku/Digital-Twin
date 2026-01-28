within EVRanger.Interfaces;

connector RollingResistanceSignal
  Real mu_rr "Rolling resistance coefficient";

annotation(
    Icon(graphics = {Ellipse(fillColor = {255, 170, 127}, fillPattern = FillPattern.Solid, extent = {{-98, 98}, {98, -98}}, endAngle = 360), Text(origin = {1, 18}, extent = {{-99, 80}, {99, -80}}, textString = "µ")})); 
end RollingResistanceSignal;
