% File : EconomicsModule.m
% Description : Defines the economics module

classdef EconomicsModule < handle


    % === Public Methods ===
    methods (Access = public)
    end

    % === Static Public Methods ===
    methods (Static, Access = public)

        % --- Power Generation ---

        %{ 
            TotalEnergyConsumptionCost : [TODO]
            Inputs : 
            Outputs : 
        %}
        function cost = TotalEnergyConsumptionCost(reactor_in, elec_rate)

            cost = reactor_in * elec_rate;

        end

    end

    % === Static Private Methods ===
    methods (Static, Access = private)
    end

    % === Private Properties ===
    properties (Access = public)
    end


end