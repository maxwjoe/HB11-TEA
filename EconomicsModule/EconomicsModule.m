% File : EconomicsModule.m
% Description : Defines the economics module

classdef EconomicsModule < handle


    % === Public Methods ===
    methods (Access = public)
    end

    % === Static Public Methods ===
    methods (Static, Access = public)

        %{ 
            ReactorPowerRevenue : Revenue from power generation
            Inputs : Net power output (MWh), Electricity rate ($/MWh)
            Outputs : Reactor revenue
        %}
        function revenue = ReactorPowerRevenue(power_net, elec_rate)
            
            revenue = power_net * elec_rate;

        end

        %{ 
            ReactorPowerCostHourly : Reactor power cost per hour
            Inputs : power_in (MWh), electricity rate ($/MWh)
            Outputs : Reactor hourly power cost
        %}
        function cost_hourly = ReactorPowerCostHourly(power_in, elec_rate)
        
            cost_hourly = power_in * elec_rate;

        end


    end

    % === Static Private Methods ===
    methods (Static, Access = private)
    end

    % === Private Properties ===
    properties (Access = public)
    end


end