% File : EconomicsModule.m
% Description : Class definition for the economics module

classdef EconomicsModule < handle
    
    % === Public Methods ===
    methods (Access = public)

        % Constructor 
        function obj = EconomicsModule(data_store_ref)
            obj.m_data_ref = data_store_ref;
        end

        % ComputeTotalRevenue : calculates total revenue (Dummy)
        function ComputeTotalRevenue(obj, elec_price)
            
            % Get electricity generated
            elec_out = obj.m_data_ref.read("TotalElectricityGenerated");
            total_revenue = elec_out * elec_price;

            % Write result to global store
            obj.m_data_ref.declare("TotalRevenue");
            obj.m_data_ref.set("TotalRevenue", total_revenue);
            
        end

        % DemonstrateArrayCompute : Demonstrates arrays (Dummy)
        function DemonstrateArrayCompute(obj, arr_length)
            
            % This declares an array in the global store
            obj.m_data_ref.declare("DemoArray");

            for i = 1:arr_length
                
                % This appends to an array in the global store
                obj.m_data_ref.appendArray("DemoArray", i*i);

            end

        end

    end


    % === Private Properties ===
    properties (Access = private)
        m_data_ref;
    end

end