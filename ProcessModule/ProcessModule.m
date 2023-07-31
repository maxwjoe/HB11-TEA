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

        %{ 
            LaserEnergyOutput : Output energy of laser
            Inputs : Total laser power per pulse (MJ), Repetition Rate (Hz)
            Outputs : Laser Energy output in MWh 
        
        %}
        function laser_out = LaserEnergyOutput(pulse_power, rep_rate)
            
            laser_out = pulse_power * rep_rate;
     
        end

        %{ 
            LaserEnergyInput : Input energy to laser
            Inputs : Laser efficiency (%), Laser Energy output (MWh)
            Outputs : Laser Energy output in MWH 
        
        %}
        function laser_in = LaserEnergyInput(laser_eff, laser_out)

            laser_in = (laser_out / laser_eff) * 100.0;

        end


        %{ 
            ReactorTargetOutput : Target output of reaction
            Inputs : Target Gain, Laser energy output (MWh)
            Outputs : Target output (MWh)
        
        %}
        function target_out = ReactorEnergyTargetOutput(tgt_gain, laser_out)
        
            target_out = tgt_gain * laser_out;
        
        end

        %{ 
            ReactorPowerOutput : Reactor gross power output
            Inputs : Target Output (MWh), Electricity gen efficiency (%)
            Outputs : Gross power output (MWh)
        
        %}
        function power_out = ReactorPowerOutput(tgt_out, elec_gen_eff)

            power_out = (tgt_out * elec_gen_eff) / 100.0;

        end

        %{ 
            ReactorPowerInput : Reactor total power input
            Inputs : Laser energy input (MWh), Cooling system power (MWh)
            Outputs : Reactor power input (MWh)
        
        %}
        function power_in = ReactorPowerInput(laser_in, cool_power)
            
            power_in = laser_in + cool_power;

        end

        %{ 
            ReactorPowerNet : Net reactor power output
            Inputs : Gross power output (MWh), Reactor power input (MWh)
            Outputs : Net reactor output (MWh)
        %}
        function power_net = ReactorPowerNet(power_out, power_in)

            power_net = power_out - power_in;

        end

        %{ 
            p_ReactorOperatingHoursYear : Reactor yearly hours in operation
            Inputs : Duty cycle 
            Outputs : Yearly operating hours
        %}
        function operating_hrs = ReactorOperatingHoursYear(duty_cycle)

            operating_hrs = duty_cycle * 365 * 24;

        end

        %{ 
            ReactorPowerNetYearly : Reactor yearly net power output
            Inputs : Net reactor output (MWh), Duty Cycle
            Outputs : Net yearly reactor output (MWh)
        %}
        function power_yearly = ReactorPowerNetYearly(power_net, duty_cycle)
            
            op_hrs = ProcessModule.ReactorOperatingHoursYear(duty_cycle);
            power_yearly = power_net * op_hrs;

        end


        

    end

    % === Static Private Methods ===
    methods (Static, Access = private)
        
        

    end

    % === Private Properties ===
    properties (Access = private)
    end

end