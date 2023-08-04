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

        % --- Cooling System ---

        %{ 
            TotalCoolantCost : [TODO]
            Inputs : 
            Outputs : 
        %}
        function cost = TotalCoolantCost(coolant_volume, coolant_density, coolant_cost)
            cost = coolant_volume * coolant_density * coolant_cost;
        end

        % --- Maintenance Cost ---

        %{ 
            LifetimeMaintenanceCost : [TODO]
            Inputs : 
            Outputs : 
        %}
        function cost = LifetimeMaintenanceCost(number_of_years_in_service, turbine_replacement_interval, turbine_generator_replacement_cost, diode_replacement_cost, laser_energy_input, diode_replacement_interval, repetition_rate, lifetime_wall_replacement_cost, total_coolant_cost, coolant_replacement_interval, yearly_regular_maintenance_cost)
            
            % Turbine Costs
            turbine = 0;

            if turbine_replacement_interval ~= 0
                turbine = floor(number_of_years_in_service / turbine_replacement_interval) * turbine_generator_replacement_cost;
            end
            
            % Diode Costs
            diode = 0;

            if diode_replacement_interval ~= 0
                diode = diode_replacement_cost * (laser_energy_input / 3600) * repetition_rate * floor(number_of_years_in_service / diode_replacement_interval) ;
            end
            
            % Wall Costs
            wall = lifetime_wall_replacement_cost;

            % Coolant Costs
            coolant = 0;

            if coolant_replacement_interval ~= 0
                coolant = total_coolant_cost * floor(number_of_years_in_service * coolant_replacement_interval);
            end

            % Regular Costs
            reg_costs = yearly_regular_maintenance_cost * number_of_years_in_service;

            % Total
            cost = turbine + diode + wall + coolant + reg_costs;  

        end

        
        %{ 
            YearlyRegularMaintenanceCosts : [TODO]
            Inputs : 
            Outputs : 
        %}
        function cost = YearlyRegularMaintenanceCosts(cost_of_maintenance_per_kwh, yearly_net_power_output)
            
            cost = cost_of_maintenance_per_kwh * 1000 * yearly_net_power_output;

        end

        % --- Construction Costs ---

        %{ 
            DirectConstructionCost : [TODO]
            Inputs : 
            Outputs : 
        %}
        function cost = DirectConstructionCost(land_cost, reactor_building_cost, turbine_building_cost, cooling_tower_system_cost, power_supply_and_energy_storage_cost, ventilation_stack_cost, miscellaneous_buildings_cost, laser_construction_cost)
            
            cost = land_cost + reactor_building_cost + turbine_building_cost + cooling_tower_system_cost + power_supply_and_energy_storage_cost + ventilation_stack_cost + miscellaneous_buildings_cost + laser_construction_cost;
        
        end

        %{ 
            TotalConstructionCost : [TODO]
            Inputs : 
            Outputs : 
        %}
        function cost = TotalConstructionCost(indirect_construction_costs, direct_construction_costs)
            
            cost = indirect_construction_costs + direct_construction_costs;

        end

        
        %{ 
            DecomissioningCost : [TODO]
            Inputs : 
            Outputs : 
        %}
        function cost = DecomissioningCost(decomissioning_cost_coefficient, direct_construction_cost)

            cost = decomissioning_cost_coefficient * direct_construction_cost;

        end
        
        % --- Personnel ---
        
        %{ 
            HourlyPersonnelCost : [TODO]
            Inputs : 
            Outputs : 
        %}
        function cost = HourlyPersonnelCost(number_of_staff, average_hourly_wage)

            cost = number_of_staff * average_hourly_wage;

        end

        %{ 
            YearlyPersonnelCost : [TODO]
            Inputs : 
            Outputs : 
        %}
        function cost = YearlyPersonnelCost(hourly_personnel_cost)

            cost = hourly_personnel_cost * 7.6*7*52.18;

        end

        % --- Vacuum System ---

        %{ 
            TotalCostOfVacuumSystem : [TODO]
            Inputs : 
            Outputs : 
        %}
        function cost = TotalCostOfVacuumSystem(mass_of_vacuum_vessel, shielding_material_costs_for_vacuum_vessel, mass_flow_rate)
        
            cost = 90.69 * mass_of_vacuum_vessel + shielding_material_costs_for_vacuum_vessel + 13.04 * mass_flow_rate;
        
        end


    end

    % === Static Private Methods ===
    methods (Static, Access = private)
    end

    % === Private Properties ===
    properties (Access = public)
    end


end