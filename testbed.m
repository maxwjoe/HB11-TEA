% File : testbed.m
% Description : Write tests for equations

PROC = ProcessModule();
ECON = EconomicsModule();

% --- Input Parameters ---

% * Laser
target_gain = 150;
pulse_power = 20;
rep_rate = 1;
elec_gen_eff = 40;
laser_eff = 3.6;

% * Power
elec_rate = 300;

% * Manufacturing
prod_fail_rate = 10;
fuel_pellet_mass = 1.00;
fuel_pct_hydrogen = 0;
hydrogen_cost = 5;
fuel_pct_hbn = 100.0;
hbn_cost = 20;
manufac_cost_pellet = 0.03;
hohlraum = 0;
total_mat_cost_hohlraum = 500;
manufac_cost_hohlraum = 20000;
cap_coil_cone = 1;
total_mat_cost_cap_coil_cone = 0.05;
manufac_cost_cap_coil_cone = 0.08;
fuel_dev_cost = 100;
manufac_facility_cost = 25;
manufac_overhead_cost = 3;
assembly_cost_per_target = 0.03;
cost_scaling_factor = 10;

% * Fuel Delivery/Storage
fuel_storage_cost_sqm = 50;
fuel_pellet_volume = 1;
required_storage_packet_days = 7;
cost_of_robot_insertion = 250000;
duty_cycle = 66.0;

% * Maintenance
diode_replacement_cost = 1000000;
turbine_generator_replacement_cost = 75000000;
lifetime_wall_replacement_cost = 20000000;
number_of_years_in_service = 25;

% * Construction Costs
inflation_conversion_coef = 1.71;
land_cost = 17;
reactor_building_cost = 31;
turbine_building_cost = 22;
cooling_tower_sys_cost = 8;
power_supply_energy_storage_cost = 10.5;
ventilation_stack_cost = 1;
laser_construction_cost = 22;
misc_building_cost = 86.5;
interest_discount_rate = 0.045;
indirect_construction_cost = 200;
decomission_cost_coeff = 0.25;

% * Utilities
specific_heat_coolant = 335;
power_to_grid = 275;
coolant_cost = 412.08;
kinetic_energy_per_fusion = 8.59;
laser_freq = 10;
num_fusion_per_pulse = 10e+17;
coolant_density = 6.095;
coolant_volume = 1;
coolant_pressure = 30000;

% * Personnel
num_staff = 300;
avg_hrly_wage = 55;

% * Vacuum System
vacuum_radius = 10;
vacuum_height = 6;
vacuum_wall_thickness = 0.01;
vacuum_mat_density = 8000;
mass_flow_rate = 3594240;


% --- Model ---

% * Laser
laser_energy_output = PROC.LaserEnergyOutput(pulse_power, rep_rate);
laser_energy_input = PROC.LaserEnergyInput(laser_eff, laser_energy_output);

% * Power
target_output = PROC.ReactorEnergyTargetOutput(target_gain, laser_energy_output);
gross_reactor_power_output = PROC.ReactorPowerOutput(target_output, elec_gen_eff);

% [HD] -> Cooling System Power
total_reactor_power_consumption = PROC.ReactorPowerInput(laser_energy_input, -1);

net_reactor_power_output = PROC.ReactorPowerNet(gross_reactor_power_output, total_reactor_power_consumption);
reactor_power_revenue = ECON.ReactorPowerRevenue(net_reactor_power_output, elec_rate);
reactor_cost_hrly = ECON.ReactorPowerCostHourly(total_reactor_power_consumption, elec_rate);
reactor_yearly_net_output = PROC.ReactorPowerNetYearly(net_reactor_power_output, duty_cycle);

% * Manufacturing


% --- Display Outputs ---







