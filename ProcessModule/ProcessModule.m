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

    end

    % === Private Methods ===
    methods (Access = private)
    end

    % === Private Properties ===
    properties (Access = private)
    end

end