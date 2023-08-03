% File : testbed.m
% Description : Write tests for equations

PROC = ProcessModule();
ECON = EconomicsModule();

% === Input Parameters ===

% * Laser *
total_laser_energy_per_pulse = 20;
repetition_rate = 1;
laser_eff = 0.036;

% * Reactor *
target_gain = 150;
cost_of_proton_beam = 100;
instrumentation_and_control_system_cost = 5.2;
increased_gain_by_hohlraum = 10;
duty_cycle = 0.66;
hohlraum = 0;
electricity_generator_efficiency = 0.4;

% * Power Generation *
turbine_plant_equipment = 186700000;
elec_rate = 72;
vacuum_system_power_usage = 0.13;

% * Fuel Manufacturing Costs *
production_failure_rate = 0.1;
fuel_pellet_mass = 1;
fuel_pellet_perc_hydrogen = 0;
cost_of_hydrogen = 5;
fuel_pellet_perc_boron_nitride = 100;
cost_of_boron_nitride = 20;
cost_of_manu_per_pellet = 0.03;
total_mat_cost_per_hohlraum = 500;
cost_of_manu_per_hohlraum = 10000;
capacitive_coil_and_focusing_cone = 1;
total_mat_cost_per_cap_coil_and_focus_cone = 0.05;
cost_of_manu_per_cap_coil_and_focus_cone = 0.08;
total_cost_fuel_dev = 100000000;
total_cost_manu_facilities = 25000000;
manu_overhead_costs = 3000000;
final_assem_cost_per_target = 0.03;

% * Fuel Storage / Delivery *
storage_cost = 1;
storage_footprint_per_target = 0.009;
required_redundancy = 90;
stack_height = 50;
cost_of_fuel_delivery_robot = 250000;
total_cost_of_fuel_storage = 923.79;

% * Cooling System *
specific_heat_of_coolant = 335;
coolant_cost = 1000;
coolant_volume = 1000;
coolant_density = 6.095;
cooling_system_pressure = 30000;
coolant_replacement_interval = 4;

% * Maintenance Cost *
diode_replacement_cost = 1000000;
turbine_generators_replacement_cost = 75000000;
lifetime_wall_replacement_cost = 20000000;
number_of_years_in_service = 26;
cost_of_maintenance_per_kwh = 0.00588;
turbine_replacement_interval = 25.01;
diode_replacement_interval = 7;


% === Model ===

% * Laser *
laser_energy_output = PROC.LaserEnergyOutput(total_laser_energy_per_pulse, repetition_rate);
laser_energy_input = PROC.LaserEnergyInput(laser_eff, laser_energy_output);

% * Reactor *
reaction_output = PROC.ReactorEnergyTargetOutput(target_gain, laser_energy_output, hohlraum, increased_gain_by_hohlraum);
realised_reactor_gain = PROC.RealisedReactorGain(reaction_output, electricity_generator_efficiency, laser_energy_input);

% * Power Generation *
gross_power_output = PROC.GrossPowerOutput(reaction_output, electricity_generator_efficiency);
total_reactor_energy_consumption = PROC.TotalReactorEnergyConsumption(laser_energy_input, cooling_system_energy_consumption,vacuum_system_power_usage);
total_reactor_energy_consumption_cost = ECON.TotalEnergyConsumptionCost(total_reactor_energy_consumption, elec_rate);
net_power_output = PROC.NetPowerOutput(gross_power_output, total_reactor_energy_consumption);
hours_in_operation_per_year = PROC.HoursInOperationPerYear(duty_cycle);
yearly_net_power_output = PROC.YearlyNetPowerOutput(net_power_output, hours_in_operation_per_year);

% * Fuel Manufacturing Costs *
required_target_per_year = PROC.RequiredTargetsPerYear(repetition_rate, duty_cycle);
fuel_target_production_per_year = PROC.FuelTargetProductionPerYear(required_target_per_year, production_failure_rate);
total_cost_per_pellet = ECON.TotalCostPerPellet(fuel_pellet_mass, fuel_pellet_perc_hydrogen, cost_of_hydrogen, fuel_pellet_perc_boron_nitride, cost_of_boron_nitride, cost_of_manu_per_pellet);
total_cost_per_hohlraum = ECON.TotalCostPerHohlraum(hohlraum, total_mat_cost_per_hohlraum, cost_of_manu_per_hohlraum);
total_cost_per_capacitive_coil_and_focusing_cone = ECON.TotalCostPerCapacitiveCoilAndFocusingCone(capacitive_coil_and_focusing_cone, total_mat_cost_per_cap_coil_and_focus_cone, cost_of_manu_per_cap_coil_and_focus_cone);
total_cost_per_target = ECON.TotalCostPerTarget(total_cost_per_pellet, total_cost_per_hohlraum, total_cost_per_capacitive_coil_and_focusing_cone,final_assem_cost_per_target);
total_fuel_manu_cost_upfront = ECON.TotalFuelManufacturingCostsUpfront(total_cost_fuel_dev, total_cost_manu_facilities);
total_fuel_manu_cost_ongoing = ECON.TotalFuelManufacturingCostsOngoing(manu_overhead_costs, fuel_target_production_per_year, total_cost_per_target);

% * Fuel Storage / Delivery *
total_cost_of_fuel_delivery_and_storage = ECON.TotalCostOfFuelDeliveryAndStorage(total_cost_of_fuel_storage, cost_of_fuel_delivery_robot);
number_of_targets_required_in_storage = PROC.NumberOfTargetsRequiredInStorage(repetition_rate, duty_cycle, required_redundancy);

% * Cooling System *
mixed_mean_coolant_temperature_rise = PROC.MixedMeanCoolantTemperatureRise(reaction_output);
coolant_flow_rate = PROC.CoolantFlowRate(reaction_output, mixed_mean_coolant_temperature_rise, specific_heat_of_coolant);
cooling_system_energy_consumption = PROC.CoolingSystemEnergyConsumption(coolant_flow_rate, cooling_system_pressure);
total_coolant_cost = ECON.TotalCoolantCost(coolant_volume, coolant_density, coolant_cost);

% * Maintenance Cost * 
% yearly_regular_maintenance_cost = ECON.YearlyRegularMaintenanceCosts(cost_of_maintenance_per_kwh, yearly_net_power_output);
% lifetime_maintenance_cost = ECON.LifetimeMaintenanceCost(number_of_years_in_service, turbine_replacement_interval, turbine_generators_replacement_cost, diode_replacement_cost, laser_energy_input, diode_replacement_interval, repetition_rate, lifetime_wall_replacement_cost, , , , );
% 

% === Display Outputs ===

% * Laser *
sprintf("Laser Energy Output = %f\n", laser_energy_output);
sprintf("Laser Energy Input = %f\n", laser_energy_input);

% * Reactor *
sprintf("Reaction Output = %f\n", reaction_output);
sprintf("Realised Reactor Gain = %f\n", realised_reactor_gain);

% * Power Generation *
sprintf("Gross Power Output = %f\n", gross_power_output);
sprintf("Total Reactor Energy Consumption = %f\n", total_reactor_energy_consumption);
sprintf("Total Reactor Energy Consumption Cost = %f\n", total_reactor_energy_consumption_cost);
sprintf("Net Power Output = %f\n", net_power_output);
sprintf("Hours In Operation Per Year = %f\n", hours_in_operation_per_year);
sprintf("Yearly Net Power Output = %f\n", yearly_net_power_output);

% * Fuel Manufacturing Costs *
sprintf("Required Targets Per Year = %f\n", required_target_per_year);
sprintf("Fuel target production per year = %f\n", fuel_target_production_per_year);
sprintf("Total cost per pellet = %f\n", total_cost_per_pellet);
sprintf("Total cost per hohlraum = %f\n", total_cost_per_hohlraum);
sprintf("Total cost per cap coil and focus cone = %f\n", total_cost_per_capacitive_coil_and_focusing_cone);
sprintf("Total cost per target = %f\n", total_cost_per_target);
sprintf("Total fuel manufacturing cost upfront = %f\n",total_fuel_manu_cost_upfront);
sprintf("Total fuel manufacturing cost ongoing = %f\n",total_fuel_manu_cost_ongoing);

% * Fuel Storage / Delivery *
sprintf("Total Cost of fuel delivery and storage = %f\n",total_cost_of_fuel_delivery_and_storage);
sprintf("Number of targets required in storage = %f\n",number_of_targets_required_in_storage);

% * Cooling System *
sprintf("Mixed mean coolant temperature rise = %f\n",mixed_mean_coolant_temperature_rise)
sprintf("Coolant flow rate = %f\n",coolant_flow_rate)
sprintf("Cooling system energy consumption = %f\n",cooling_system_energy_consumption)
sprintf("Total coolant cost = %f\n",total_coolant_cost)

% * Maintenance Cost * 

