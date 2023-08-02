% File : testbed.m
% Description : Write tests for equations

PROC = ProcessModule();
ECON = EconomicsModule();

% --- Input Parameters ---

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
cooling_system_energy_consumption = 20.149;
vacuum_system_power_usage = 0.13;

% --- Model ---

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

% --- Display Outputs ---

% * Laser *
sprintf("Laser Energy Output = %f\n", laser_energy_output);
sprintf("Laser Energy Input = %f\n", laser_energy_input);

% * Reactor *
sprintf("Reaction Output = %f\n", reaction_output);
sprintf("Realised Reactor Gain = %f\n", realised_reactor_gain);

% * Power Generation *
sprintf("Gross Power Output = %f\n", gross_power_output)
sprintf("Total Reactor Energy Consumption = %f\n", total_reactor_energy_consumption)
sprintf("Total Reactor Energy Consumption Cost = %f\n", total_reactor_energy_consumption_cost)
sprintf("Net Power Output = %f\n", net_power_output)
sprintf("Hours In Operation Per Year = %f\n", hours_in_operation_per_year)
sprintf("Yearly Net Power Output = %f\n", yearly_net_power_output)





