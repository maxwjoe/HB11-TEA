% File : ProcessModule.m
% Description : Defines the physical process module

classdef ProcessModule < handle

    % === Public Methods ===
    methods (Access = public)

        % Constructor 
        function obj = ProccessModule(obj)
        end

    end

    % === Static Public Methods ===
    methods (Static, Access = public)

        % --- UI Visible ---
        
        % ThermalReactionEnergyOutput : Thermal energy output
        function out = ThermalReactionEnergyOutput(x_factor, increased_gain_by_x_factor, target_gain, laser_energy_output)

            if x_factor ~= 0
                out = increased_gain_by_x_factor * target_gain * laser_energy_output;
            else
                out = target_gain * laser_energy_output;
            end

        end

        % RealisedReactorGain : Realised gain
        function gain = RealisedReactorGain(gross_energy_output, laser_energy_input)

            gain = gross_energy_output / laser_energy_input;

        end

        % GrossEnergyOutput : Gross output
        function out = GrossEnergyOutput(thermal_reaction_energy_output, electricity_generator_efficiency)

            out = thermal_reaction_energy_output * electricity_generator_efficiency;

        end

        % TotalReactorEnergyConsumption : Energy consumed by reactor
        function energy = TotalReactorEnergyConsumption(laser_energy_input, cooling_system_energy_consumption, vacuum_system_power_usage)

            energy = laser_energy_input + cooling_system_energy_consumption + vacuum_system_power_usage;

        end

        % NetEnergyOutput : Net output of reactor
        function out = NetEnergyOutput(gross_energy_output, total_reactor_energy_consumption)

            out = gross_energy_output - total_reactor_energy_consumption;

        end

        % HoursInOperationPerYear : Yearly hours in operation
        function hours = HoursInOperationPerYear(duty_cycle)

            hours = 365 * 24 * duty_cycle;

        end

        % YearlyNetEnergyOutput : Net energy output for a year
        function out = YearlyNetEnergyOutput(net_energy_output, hours_in_operation_per_year)
            
            out = net_energy_output * hours_in_operation_per_year;

        end
      

        % --- Not in UI ---

        
        % LaserEnergyOutput : Output energy of laser
        function out = LaserEnergyOutput(total_laser_energy_per_pulse, repetition_rate)

            out = total_laser_energy_per_pulse * repetition_rate;

        end

        % LaserEnergyInput : Input energy to laser
        function in = LaserEnergyInput(laser_energy_output, laser_efficiency)

            in = laser_energy_output * laser_efficiency;

        end


        % FuelTargetProductionPerYear : Yearly target production
        function targets = FuelTargetProductionPerYear(required_targets_per_year, production_failure_rate)

            targets = required_targets_per_year / (1 - production_failure_rate);

        end

        % RequiredTargetsPerYear : required fuel targets per year
        function targets = RequiredTargetsPerYear(repetition_rate, duty_cycle)

            targets = repetition_rate * duty_cycle * 365 * 24 * 3600;

        end

        % NumberOfTargetsRequiredInStorage : Number of targets to store
        function targets = NumberOfTargetsRequiredInStorage(repetition_rate, duty_cycle, required_redundancy)

            targets = repetition_rate*((duty_cycle*24)*3600)*required_redundancy;

        end

        % CoolingSystemEnergyConsumption : Energy consumed for cooling
        function in =  CoolingSystemEnergyConsumption(thermal_reaction_energy_output)

            in = 32*(thermal_reaction_energy_output/2605);

        end

        % CoolantFlowRate : Flow rate for coolant
        function rate = CoolantFlowRate(thermal_reaction_energy_output, mixed_mean_coolant_temperature_rise, specific_heat_of_coolant)

            rate = thermal_reaction_energy_output*10^6/mixed_mean_coolant_temperature_rise/specific_heat_of_coolant;

        end

        % MassOfVacuumVessel : Mass of the vacuum vessel
        function mass = MassOfVacuumVessel(height_of_vacuum_vessel, radius_of_vacuum_vessel, wall_thickness_of_vacuum_vessel, density_of_vacuum_vessel_material)

            mass = pi * height_of_vacuum_vessel * (radius_of_vacuum_vessel^2-(radius_of_vacuum_vessel - wall_thickness_of_vacuum_vessel)^2)*density_of_vacuum_vessel_material;

        end

        

    end

    % === Private Properties ===
    properties (Access = private)
    end

end