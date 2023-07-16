% File : ApplicationModule.m
% Description : Class Definition for the Application Module

% ApplicationModule : UI to Backend Application Layer
classdef ApplicationModule < handle

    % === Public Methods ===
    methods (Access = public)

        % Constructor
        function obj = ApplicationModule()

            % Add Modules To Path
            addpath("DataStoreModule/");

            % Instantiate Modules
            obj.DS = DataStoreModule();

        end

        % --- Output Functions ---

        % LoadInputs : Load input values from UI into Data Layer
        function LoadInputs(obj, data)
            
            % Perform a batch write operation to the data store
            obj.DS.batchWrite(data);

        end

        % PostOutputs : Posts output values from Application Layer to UI
        function data = PostOutputs(obj, keys)
            
            % Perform a batch read operation on the data store and return
            data = obj.DS.batchRead(keys);

        end

        % RunModel : Runs the Technoeconomic Model
        function RunModel(obj)
        end

        % ElectricityGenerated : Compute time series data for electricity vs time
        function ElectricityGenerated(obj)
        end

        % CapitalCosts : Compute data for capital costs
        function CapitalCosts(obj)
        end

        % OngoingCosts : Compute data for ongoing costs
        function OngoingCosts(obj)
        end

        % InvestmentSummary : Compute data for investment summary
        function InvestmentSummary(obj)
        end

        % SaveState : Saves application state to file
        function SaveState(obj)
            obj.DS.dumpToFile("test.xml");
        end

        % OpenState : Loads application state from a file
        function OpenState(obj)
            obj.DS.loadFromFile("test.xml");
        end

        % ResetState : Restarts application
        function ResetState(obj)
        end

    end

    % === Private Methods ===
    methods (Access = private)

        

    end

    % === Private Properties ===
    properties (Access = private)
        DS;
    end

end