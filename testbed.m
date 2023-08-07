% File : testbed.m
% Description : Write tests for equations

PROC = ProcessModule();
ECON = EconomicsModule();

format longg

% === Input Parameters ===

% --- UI --- (TODO: APPEND IN)

IN_total_laser_energy_per_pulse = 20;
IN_repetition_rate = 1;
IN_laser_efficiency = 0.036;
IN_target_gain = 150;
IN_increased_gain_by_x_factor = 2;
IN_duty_cycle = 0.66;
IN_electricity_generator_efficiency = 0.4;
IN_electricity_rate = 72;
IN_x_factor = 0;
IN_total_cost_of_x_factor = 100;
IN_capacitive_coil_and_hydrogen_cone = 1;
IN_number_of_years_in_service = 25;
IN_number_of_staff = 300;
IN_mass_flow_rate = 32000;


% --- SET ---

reactor_shielding_initial_cost = 20;
instrumentation_and_control_system_cost = 5.2;
turbine_plant_equipment = 186700000;
production_failure_rate = 0.1;
fuel_pellet_mass = 1;
hydrogen_precursor_mass = 0.040;
cost_of_hydrogen = 5;
fuel_pellet_percentage_boron_nitride = 1;
cost_of_boron_nitride = 120;
cost_of_manufacturing_per_pellet = 0.08;
cost_of_manufacturing_per_capacitive_coil_and_hydrogen_cone = 0.15;
total_cost_of_fuel_development = 100000000;
total_cost_of_manufacturing_facilities = 50000000;
total_manufacturing_overhead_costs = 3000000;
final_assembly_cost_per_target = 0.06;
storage_cost = 1000;
storage_footprint_per_target = 0.009;
required_redundancy = 90;
stack_height = 50;
cost_of_fuel_delivery_robot = 250000;
total_cost_of_fuel_storage = 923788.80;
diode_replacement_cost = 1000000;
turbine_generators_replacement_cost = 75000000;
lifetime_wall_replacement_cost = 20000000;
cost_of_maintenance_per_kwh = 0.00588;
turbine_replacement_interval = 25.01;
coolant_replacement_interval = 4;
diode_replacement_interval = 7;
land_cost = 10.1;
reactor_building_cost = 321.85;
turbine_building_cost = 110;
cooling_tower_system_cost = 24.4;
power_supply_and_energy_storage_cost = 162.2;
ventilation_stack_cost = 2;
laser_construction_cost = 38;
miscellaneous_buildings_cost = 263.4;
inflation_coefficient = 0.045;
indirect_construction_cost = 214.3485;
decomissioning_cost_coefficient = 0.12;
mixed_mean_coolant_temperature_rise = 300;
specific_heat_of_coolant = 2414.17;
coolant_cost = 131;
coolant_volume = 100000;
coolant_density = 1.91;
cooling_system_pressure = 100000;
coolant_pipe_outlet_radius = 0.39;
average_hourly_wage = 55;
shielding_material_costs_for_vacuum_vessel = 0;
radius_of_vacuum_vessel = 10;
height_of_vacuum_vessel = 15;
wall_thickness_of_vacuum_vessel = 0.01;
density_of_vacuum_vessel_material = 8000;
vacuum_system_power_usage = 0.13;

% === Model ===

% [Primary Laser, Reactor, Power Generation]

laser_energy_output = PROC.LaserEnergyOutput(IN_total_laser_energy_per_pulse, IN_repetition_rate);
laser_energy_input = PROC.LaserEnergyInput(laser_energy_output, IN_laser_efficiency);
thermal_reaction_energy_output = PROC.ThermalReactionEnergyOutput(IN_x_factor, IN_increased_gain_by_x_factor, IN_target_gain, laser_energy_output);
gross_energy_output = PROC.GrossEnergyOutput(thermal_reaction_energy_output, IN_electricity_generator_efficiency);
realised_reactor_gain = PROC.RealisedReactorGain(gross_energy_output, laser_energy_input);
cooling_system_energy_consumption = PROC.CoolingSystemEnergyConsumption(thermal_reaction_energy_output);
total_reactor_energy_consumption = PROC.TotalReactorEnergyConsumption(laser_energy_input, cooling_system_energy_consumption, vacuum_system_power_usage);
net_energy_output = PROC.NetEnergyOutput(gross_energy_output, total_reactor_energy_consumption);
hours_in_operation_per_year = PROC.HoursInOperationPerYear(IN_duty_cycle);
yearly_net_energy_output = PROC.YearlyNetEnergyOutput(net_energy_output, hours_in_operation_per_year);
laser_equipment_cost = ECON.LaserEquipmentCost(net_energy_output);

% [Fuel Manufacturing Costs, Fuel Storage/Delivery, Maintenance Costs, Cooling System]

cooling_system_energy_consumption = PROC.CoolingSystemEnergyConsumption(thermal_reaction_energy_output);
total_coolant_cost = ECON.TotalCoolantCost(coolant_volume, coolant_density, coolant_cost);
coolant_flow_rate = PROC.CoolantFlowRate(thermal_reaction_energy_output, mixed_mean_coolant_temperature_rise, specific_heat_of_coolant);

required_targets_per_year = PROC.RequiredTargetsPerYear(IN_repetition_rate, IN_duty_cycle);
fuel_target_production_per_year = PROC.FuelTargetProductionPerYear(required_targets_per_year, production_failure_rate);
total_cost_per_pellet = ECON.TotalCostPerPellet(fuel_pellet_mass, fuel_pellet_percentage_boron_nitride, cost_of_boron_nitride, cost_of_manufacturing_per_pellet);
total_cost_per_target_with_x_factor = ECON.TotalCostPerTargetWithXFactor(IN_x_factor, IN_total_cost_of_x_factor);
total_material_cost_per_capacitive_coil_and_hydrogen_cone = ECON.TotalMaterialCostPerCapacitiveCoilAndHydrogenCone(hydrogen_precursor_mass, cost_of_hydrogen);
total_cost_per_capacitive_coil_and_hydrogen_cone = ECON.TotalCostPerCapacitiveCoilAndHydrogenCone(IN_capacitive_coil_and_hydrogen_cone, total_material_cost_per_capacitive_coil_and_hydrogen_cone, cost_of_manufacturing_per_capacitive_coil_and_hydrogen_cone);
total_cost_per_target = ECON.TotalCostPerTarget(total_cost_per_pellet, total_cost_per_target_with_x_factor, total_cost_per_capacitive_coil_and_hydrogen_cone, final_assembly_cost_per_target);
total_fuel_manufacturing_costs_upfront = ECON.TotalFuelManufacturingCostsUpfront(total_cost_of_fuel_development, total_cost_of_manufacturing_facilities);
total_fuel_manufacturing_costs_ongoing = ECON.TotalFuelManufacturingCostsOngoing(total_manufacturing_overhead_costs, fuel_target_production_per_year, total_cost_per_target);
total_cost_of_fuel_delivery_and_storage = ECON.TotalCostOfFuelDeliveryAndStorage(total_cost_of_fuel_storage, cost_of_fuel_delivery_robot);
number_of_targets_required_in_storage = PROC.NumberOfTargetsRequiredInStorage(IN_repetition_rate, IN_duty_cycle, required_redundancy);
yearly_regular_maintenance_cost = ECON.YearlyRegularMaintenanceCost(cost_of_maintenance_per_kwh, yearly_net_energy_output);
lifetime_maintenance_cost = ECON.LifetimeMaintenanceCost(IN_number_of_years_in_service, turbine_replacement_interval, turbine_generators_replacement_cost, diode_replacement_cost, laser_energy_input, diode_replacement_interval, IN_repetition_rate, lifetime_wall_replacement_cost, total_coolant_cost, coolant_replacement_interval, yearly_regular_maintenance_cost);


% [Construction, Personnel, Vacuum]

direct_construction_cost = ECON.DirectConstructionCost(land_cost, reactor_building_cost, turbine_building_cost, cooling_tower_system_cost, power_supply_and_energy_storage_cost, ventilation_stack_cost, miscellaneous_buildings_cost, laser_construction_cost);
total_construction_cost = ECON.TotalConstructionCost(indirect_construction_cost, direct_construction_cost);
decomissioning_cost = ECON.DecommissioningCost(decomissioning_cost_coefficient, direct_construction_cost);

hourly_personnel_cost = ECON.HourlyPersonnelCost(IN_number_of_staff, average_hourly_wage);
yearly_personnel_cost = ECON.YearlyPersonnelCost(hourly_personnel_cost);

mass_of_vacuum_vessel = PROC.MassOfVacuumVessel(height_of_vacuum_vessel, radius_of_vacuum_vessel, wall_thickness_of_vacuum_vessel, density_of_vacuum_vessel_material);
total_cost_of_vacuum_system = ECON.TotalCostOfVacuumSystem(mass_of_vacuum_vessel, shielding_material_costs_for_vacuum_vessel, IN_mass_flow_rate);





