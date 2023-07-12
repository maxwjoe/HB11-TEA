% File : PhysicsModule.m
% Description : Class definition for the physics module

classdef PhysicsModule < handle

   % === Public Methods ===
    methods (Access = public)
    
        % Constructor 
        function obj = PhysicsModule(data_store_ref)
            obj.m_data_ref = data_store_ref;

            % Declare data store variables
            obj.m_data_ref.declare("TotalFuelBurn");
        end
    
        % ComputeTotalFuelBurn : Example Function that computes burn (DUMMY)
        function ComputeTotalFuelBurn(obj, rate, time)

            % Perform calculation
            total_burn = rate * time;

            % Set the variable
            obj.m_data_ref.set("TotalFuelBurn", total_burn);
        end

    end
    
    % === Private Properties ===

    properties (Access = private)
        m_data_ref;
    end

end