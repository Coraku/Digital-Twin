within EVRanger;

package Units
  extends EVRanger.Icons.UnitsSymb;
  
  type Time = Real(
    final quantity = "Time",
    final unit = "s"
    );

  // Electrical

  type Voltage = Real(
    final quantity = "ElectricPotential",
    final unit = "V"
  );

  type Current = Real(
    final quantity = "ElectricCurrent",
    final unit = "A"
  );

  type Resistance = Real(
    final quantity = "Resistance",
    final unit = "Ohm"
  );

  type Charge = Real(
    final quantity = "ElectricCharge",
    final unit = "C"
  );

  type Power = Real(
    final quantity = "Power",
    final unit = "W"
  );

  // Thermal

  type Temperature_degC = Real(
    final quantity = "ThermodynamicTemperature",
    final unit = "°C"
  );

  type HeatFlowRate = Real(
    final quantity = "Power",
    final unit = "W"
  );

  type SpecificHeatCapacity = Real(
    final quantity = "SpecificHeatCapacity",
    final unit = "J/(kg.K)"
  );
  
  type HeatTransferCoefficient = Real(
    final quantity = "HeatTransferCoefficient",
    final unit = "W/(m2.K)"
  );

  // Mechanical

  type Mass = Real(
    final quantity = "Mass",
    final unit = "kg"
  );

  type Area = Real(
    final quantity = "Area",
    final unit = "m^2"
  );
  
  type Length = Real(
    final quantity = "Length",
    final unit = "m"
  );
  
  type Velocity = Real(
    final quantity = "Velocity",
    final unit = "m/s"
  );
  
  type Acceleration = Real(
    final quantity = "Acceleration",
    final unit = "m/s2"
  );
  
  type Force = Real(
    final quantity = "Force",
    final unit = "N"
  );
  
  type Torque = Real(
    final quantity = "Torque",
    final unit = "N.m"
  );
  
  type AngularVelocity = Real(
    final quantity = "AngularVelocity",
    final unit = "rad/s"
  );
  
  type Density = Real(
    final quantity = "Density",
    final unit = "kg/m3"
  );
  
  // Dimensionless vehicle quantities
  
  type RoadSlope = Real(
    final quantity = "RoadSlope",
    final unit = "1",
    displayUnit = "%"
  );

  // Battery specific

  type ResistanceFactor = Real(
    final quantity = "ResistanceFactor",
    final unit = "1"
  );

  type DegradationRate = Real(
    final quantity = "DegradationRate",
    final unit = "1/A.s"
  );

  
  type TemperatureCoefficient = Real(
    final quantity = "TemperatureCoefficient",
    final unit = "1/K"
  );
  
  
  // Motor Specific
  
  type MotorConstant = Real(
    final quantity = "MotorConstant",
    final unit = "N.m/A"
  );
  
  type MotorSpeedConstant = Real(
    final quantity = "SpeedConstant",
    final unit = "rpm/V"
  );

end Units;

