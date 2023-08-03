% File : EconomicsModule.m
% Description : Defines the economics module

classdef EconomicsModule < handle


    % === Public Methods ===
    methods (Access = public)
    end

    % === Static Public Methods ===
    methods (Static, Access = public)

        % --- Power Generation ---

        %{ 
            TotalEnergyConsumptionCost : [TODO]
            Inputs : 
            Outputs : 
        %}
        function cost = TotalEnergyConsumptionCost(reactor_in, elec_rate)

            cost = reactor_in * elec_rate;

        end

        % --- Fuel Manufacturing Costs ---

        %{ 
            TotalCostPerTarget : [TODO]
            Inputs : 
            Outputs : 
        %}
        function tgt_cost = TotalCostPerTarget(pellet_cost, hohlraum_cost, cap_coil_cone_cost, assem_cost)
            
            tgt_cost = pellet_cost + hohlraum_cost + cap_coil_cone_cost + assem_cost;
        
        end

        %{ 
            TotalCostPerPellet : [TODO]
            Inputs : 
            Outputs : 
        %}
        function pellet_cost = TotalCostPerPellet(pellet_mass, perc_hydrogen, cost_hydrogen, perc_boron_nitride, cost_boron_nitride, pellet_manu_cost)
        
            pellet_cost = pellet_mass * ((perc_hydrogen * cost_hydrogen)/(1000*100) + (perc_boron_nitride * cost_boron_nitride)/(1000*100)) + pellet_manu_cost;
        
        end

        %{ 
            TotalCostPerHohlraum : [TODO]
            Inputs : 
            Outputs : 
        %}
        function hohlraum_cost = TotalCostPerHohlraum(has_holraum, mat_cost, manu_cost)
            
            hohlraum_cost = has_holraum * (mat_cost + manu_cost);

        end

        %{ 
            TotalCostPerCapacitiveCoilAndFocusingCone : [TODO]
            Inputs : 
            Outputs : 
        %}
        function cost = TotalCostPerCapacitiveCoilAndFocusingCone(has_cap_coil_cone, mat_cost, manu_cost)
            
            cost = has_cap_coil_cone * (mat_cost + manu_cost);
        
        end

        %{ 
            TotalFuelManufacturingCostsUpfront : [TODO]
            Inputs : 
            Outputs : 
        %}
        function total_cost = TotalFuelManufacturingCostsUpfront(fuel_dev_cost, manu_facility_cost)

            total_cost = fuel_dev_cost + manu_facility_cost;

        end

        %{ 
            TotalFuelManufacturingCostsOngoing : [TODO]
            Inputs : 
            Outputs : 
        %}
        function total_cost = TotalFuelManufacturingCostsOngoing(manu_overhead, production_target_yrly, tgt_cost)
               
            total_cost = manu_overhead + (production_target_yrly * tgt_cost);

        end

        % --- Fuel Storage / Delivery ---

        %{ 
            TotalCostOfFuelDeliveryAndStorage : [TODO]
            Inputs : 
            Outputs : 
        %}
        function total_cost = TotalCostOfFuelDeliveryAndStorage(total_cost_of_fuel_storage, total_cost_of_fuel_delivery_robot)

            total_cost = total_cost_of_fuel_storage + total_cost_of_fuel_delivery_robot;

        end

        



    end

    % === Static Private Methods ===
    methods (Static, Access = private)
    end

    % === Private Properties ===
    properties (Access = public)
    end


end