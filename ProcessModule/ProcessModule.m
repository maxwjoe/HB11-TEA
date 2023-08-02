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
        
        % --- Laser ---

        %{ 
            LaserEnergyOutput : Output energy of laser
            Inputs : Total laser energy per pulse (MJ), Repetition Rate (Hz)
            Outputs : Laser Energy output in MWh 
        
        %}
        function laser_out = LaserEnergyOutput(pulse_energy, rep_rate)
            
            laser_out = pulse_energy * rep_rate;
     
        end

        %{ 
            LaserEnergyInput : Input energy to laser
            Inputs : Laser efficiency (%), Laser Energy output (MWh)
            Outputs : Laser Energy output in MWH 
        
        %}
        function laser_in = LaserEnergyInput(laser_eff, laser_out)

            laser_in = (laser_out / laser_eff);

        end

        % --- Reactor ---
        
        %{ 
            ReactionOutput : Output of the reaction
            Inputs : Target Gain, Laser energy output (MWh)
            Outputs : Target output (MWh)
        
        %}
        function target_out = ReactorEnergyTargetOutput(tgt_gain, laser_out, has_hohlraum, hohlraum_gain)
           

            target_out = tgt_gain * laser_out;

            if has_hohlraum
                target_out = target_out * hohlraum_gain;
            end
        
        end

        %{ 
            RealisedReactorGain : [TODO]
            Inputs : 
            Outputs : 
        %}
        function gain = RealisedReactorGain(react_out, elec_gen_eff, laser_input)
        
            gain = (react_out * elec_gen_eff) / laser_input;
        
        end

        
        % --- Power Generation ---
        
        %{ 
            GrossPowerOutput : [TODO]
            Inputs : 
            Outputs : 
        %}
        function gross = GrossPowerOutput(react_out, elec_gen_eff)
            
            gross = react_out * elec_gen_eff;
        
        end

        %{ 
            TotalReactorEnergyConsumption : [TODO]
            Inputs : 
            Outputs : 
        %}
        function energy_in = TotalReactorEnergyConsumption(laser_in, cool_sys_in, vacuum_in)
            
            energy_in = laser_in + cool_sys_in + vacuum_in;
        
        end

        %{ 
            NetPowerOutput : [TODO]
            Inputs : 
            Outputs : 
        %}
        function net_power = NetPowerOutput(gross_output, react_in)
        
            net_power = gross_output - react_in;
        
        end

        %{ 
            HoursInOperationPerYear : [TODO]
            Inputs : 
            Outputs : 
        %}
        function hours = HoursInOperationPerYear(duty_cycle)

            hours = duty_cycle * 24 * 365;

        end

        %{ 
            YearlyNetPowerOutput : [TODO]
            Inputs : 
            Outputs : 
        %}
        function yearly_net_power = YearlyNetPowerOutput(net_power, hours_in_op)
        
            yearly_net_power = net_power * hours_in_op;
        
        end
    

        % --- Fuel Manufacturing Costs ---

        %{ 
            FuelTargetProductionPerYear : [TODO]
            Inputs : 
            Outputs : 
        %}

        function target_prod = FuelTargetProductionPerYear(required_tgts_yr, failure_rate)
            
            target_prod = required_tgts_yr / (1 - failure_rate);
        
        end

        %{ 
            RequiredTargetsPerYear : [TODO]
            Inputs : 
            Outputs : 
        %}
        
        function required_tgts = RequiredTargetsPerYear(rep_rate, duty_cycle)
        
            required_tgts = rep_rate * duty_cycle * 365 * 24 * 3600;

        end

        

    end

    % === Static Private Methods ===
    methods (Static, Access = private)
        
        

    end

    % === Private Properties ===
    properties (Access = private)
    end

end