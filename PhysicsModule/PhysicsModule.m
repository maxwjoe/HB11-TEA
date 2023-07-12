% File : PhysicsModule.m
% Description : Class definition for the physics module

classdef PhysicsModule < handle

   % === Public Methods ===
    methods (Access = public)
    
        % Constructor 
        function obj = PhysicsModule(data_store_ref)
            obj.m_data_ref = data_store_ref;
        end
    
        % ComputeTotalElectricityGenerated : returns the total electricity
        % generated (Dummy)
        function total = ComputeTotalElectricityGenerated(obj)
            
            % Do some calculation
            var1 = 3;
            var2 = 5;
    
            total = var1 * var2;
            
            % Write result to global data store
            obj.m_data_ref.declare("TotalElectricityGenerated");
            obj.m_data_ref.set("TotalElectricityGenerated", total);
    
        end

    end
    
    % === Private Properties ===

    properties (Access = private)
        m_data_ref;
    end

end