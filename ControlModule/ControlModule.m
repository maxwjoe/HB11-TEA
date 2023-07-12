% File : ControlModule.m
% Description : Class definition for control module API for UI

classdef ControlModule < handle
    
    % === Public Methods ===
    methods (Access = public)

        % Constructor
        function obj = ControlModule()

            % HACKY : Add paths
            oldpath = addpath("DataStoreModule/");
            oldpath = addpath("EconomicsModule/");
            oldpath = addpath("PhysicsModule/");

            obj.DS = DataStoreModule();
            obj.ECON = EconomicsModule(obj.DS);
            obj.PHYS = PhysicsModule(obj.DS);
        end

        % RunPhysDemo : Runs the phys demo function
        function result = RunPhysDemo(obj, burn_rate, burn_time)

            % Cast Inputs
            burn_rate = str2double(burn_rate);
            burn_time = str2double(burn_time);

            obj.PHYS.ComputeTotalFuelBurn(burn_rate, burn_time);
            dbl_result = obj.DS.read("TotalFuelBurn");
            
            % Cast Return Value
            result = string(dbl_result);
        end

        % RunEconDemo : Runs the econ demo function
        function result = RunEconDemo(obj, fuel_price)

            % Cast Inputs
            fuel_price = str2double(fuel_price);

            obj.ECON.ComputeTotalFuelCost(fuel_price);
            dbl_result = obj.DS.read("TotalFuelCost");

            % Cast Return Value
            result = string(dbl_result);
        end

    end

    % === Private Properties ===
    properties (Access = private)
        DS;
        ECON;
        PHYS;
    end

end