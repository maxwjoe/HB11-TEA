% File : EconomicsModule.m
% Description : Class definition for the economics module

classdef EconomicsModule < handle
    
    % === Public Methods ===
    methods (Access = public)

        % Constructor 
        function obj = EconomicsModule(data_store_ref)
            obj.m_data_ref = data_store_ref;

            % declare data store variables
            obj.m_data_ref.declare("TotalFuelCost");
        end

        % ComputeTotalFuelCost : Computes total fuel cost (DUMMY)
        function ComputeTotalFuelCost(obj, fuel_price)
            total_burn = obj.m_data_ref.read("TotalFuelBurn");

            total_cost = fuel_price * total_burn;
            obj.m_data_ref.set("TotalFuelCost", total_cost);
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