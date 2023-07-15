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

    end

    % === Private Methods ===
    methods (Access = private)
    end

    % === Private Properties ===
    properties (Access = private)
        DS;
    end

end