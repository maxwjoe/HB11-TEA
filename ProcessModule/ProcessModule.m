% File : ProcessModule.m
% Description : Defines the physical process module

classdef ProcessModule < handle

    % === Public Methods ===
    methods (Access = public)

        % Constructor 
        function obj = ProccessModule(obj)
        end

        % ComputeElectricityOut : Gets total elec output for a period
        function elec_out = ComputeElectricityOut(obj, mult_factor)
            elec_out = mult_factor * rand();
        end

        % TotalCostVS : Gets total capital cost of vacuum system
        function total_cost_vs = TotalCostVS(obj, radius)
            % Assumed Parameters:
            %   Mass flow rate: 3 594 240 m^3/day
            total_cost_vs = 90.69*MassVV(radius) + 13.04*3594240;
        end

    end

    % === Private Methods ===
    methods (Access = private)

        % MassVV : Calculates mass of vacuum vessel
        function mass_vv = MassVV(radius)
            % Assumed Parameters:
            %   Thickness:       0.01 m
            %   Density:         8000 kg/m^3 (316 LN stainless steel)
            %   Cylinder height: 6 m
            mass_vv = 2*pi*radius*0.01*8000*(radius + 6);
        end

    end

    % === Private Properties ===
    properties (Access = private)
    end

end