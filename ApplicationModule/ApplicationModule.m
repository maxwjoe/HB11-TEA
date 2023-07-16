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
            addpath("ProcessModule/");

            % Instantiate Modules
            obj.DS = DataStoreModule();
            obj.PROC = ProcessModule();

        end

        % --- Output Functions ---

        % LoadInputs : Load input values from UI into Data Layer
        function LoadInputs(obj, data)
            
            % Perform a batch write operation to the data store
            obj.DS.batchWrite(data);

        end

        % PostOutputs : Posts output values from Application Layer to UI
        function data = PostOutputs(obj)
            
            % Perform a batch read operation on the data store and return
            output_keys = obj.DS.getKeys("out_");
            data = obj.DS.batchRead(output_keys);

        end

        % PostInputs : Posts Input values from Application Layer to UI
        % Note : This is used mostly when loading from a file
        function data = PostInputs(obj)

            % Perform a batch read operation on the data store and return
            input_keys = obj.DS.getKeys("in_");
            data = obj.DS.batchRead(input_keys);

        end

        % RunModel : Runs the Technoeconomic Model
        function RunModel(obj)

            % Compute Electricity Generated
            obj.ElectricityGenerated();

        end

        % ElectricityGenerated : Compute time series data for electricity vs time
        function ElectricityGenerated(obj)

            mult_factor = obj.DS.read("in_powermultiplier");
            periods = obj.DS.read("in_periodsinmonths");
            
            elec_out_data = [];
            time = 1:periods;
            
            % Compute for each period t
            for t = time
                output = obj.PROC.ComputeElectricityOut(mult_factor);
                elec_out_data = [elec_out_data, output];
            end
            
            % Package Data into 2D struct
            elec_time_series = struct();
            
            elec_time_series.("period") = time;
            elec_time_series.("output") = elec_out_data;
            
            % Write output to global data store
            obj.DS.write("out_electricitygenerated", elec_time_series);

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
        function SaveState(obj, filepath)
            obj.DS.dumpToFile(filepath);
        end

        % OpenState : Loads application state from a file
        function OpenState(obj, filepath)
            obj.DS.loadFromFile(filepath);
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
        PROC;
    end

end