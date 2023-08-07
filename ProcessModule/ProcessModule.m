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
        
        % ThermalReactionEnergyOutput : Thermal energy output
        function out = ThermalReactionEnergyOutput()
        end

        % RealisedReactorGain : Realised gain
        function gain = RealisedReactorGain()
        end

        % GrossEnergyOutput : Gross output
        function out = GrossEnergyOutput()
        end

        % TotalReactorEnergyConsumption : Energy consumed by reactor
        function energy = TotalReactorEnergyConsumption()
        end

        % NetEnergyOutput : Net output of reactor
        function out = NetEnergyOutput()
        end

        % HoursInOperationPerYear : Yearly hours in operation
        function hours = HoursInOperationPerYear()
        end

        % YearlyNetEnergyOutput : Net energy output for a year
        function out = YearlyNetEnergyOutput()
        end
        

    end

    % === Static Private Methods ===
    methods (Static, Access = private)
        
        

    end

    % === Private Properties ===
    properties (Access = private)
    end

end