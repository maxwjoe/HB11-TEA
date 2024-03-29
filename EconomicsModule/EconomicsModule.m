% File : EconomicsModule.m
% Description : Defines the economics module

classdef EconomicsModule < handle


    % === Public Methods ===
    methods (Access = public)
    end

    % === Static Public Methods ===
    methods (Static, Access = public)

        % --- UI Visible ---

        % TotalCostPerTarget : Total cost per target
        function cost = TotalCostPerTarget(total_cost_per_pellet, total_cost_per_target_with_x_factor, total_cost_per_capacitive_coil_and_hydrogen_cone, final_assembly_cost_per_target)
        
            cost = total_cost_per_pellet + total_cost_per_target_with_x_factor + total_cost_per_capacitive_coil_and_hydrogen_cone + final_assembly_cost_per_target;
        
        end

        % TotalFuelManufacturingCostsUpfront : Upfront fuel man costs
        function cost = TotalFuelManufacturingCostsUpfront(total_cost_of_fuel_development, total_cost_of_manufacturing_facilities)

            cost = total_cost_of_fuel_development + total_cost_of_manufacturing_facilities;

        end

        % TotalFuelManufacturingCostsOngoing : Ongoing fuel man costs
        function cost = TotalFuelManufacturingCostsOngoing(manufacturing_overhead_costs, fuel_target_production_per_year, total_cost_per_target)

            cost = manufacturing_overhead_costs + fuel_target_production_per_year * ( total_cost_per_target );

        end

        % TotalCostOfFuelDeliveryAndStorage : Costs for fuel delivery/store
        function cost = TotalCostOfFuelDeliveryAndStorage(total_cost_of_fuel_storage, cost_of_fuel_delivery_robot)

            cost = total_cost_of_fuel_storage + cost_of_fuel_delivery_robot;

        end

        % LifetimeMaintenanceCost : Cost of maintenance (lifetime)
        function cost = LifetimeMaintenanceCost(number_of_years_in_service, turbine_replacement_interval, turbine_generator_replacement_cost, diode_replacement_cost, laser_energy_input, diode_replacement_interval, repetition_rate, lifetime_wall_replacement_cost, total_coolant_cost, coolant_replacement_interval, yearly_regular_maintenance_cost)
            
            cost = floor(number_of_years_in_service/turbine_replacement_interval)*turbine_generator_replacement_cost + diode_replacement_cost * (laser_energy_input / 3600) * repetition_rate * floor(number_of_years_in_service / diode_replacement_interval) + lifetime_wall_replacement_cost + total_coolant_cost * (number_of_years_in_service / coolant_replacement_interval) + yearly_regular_maintenance_cost * number_of_years_in_service; 

        end

        % TotalConstructionCost : Total cost of construction
        function cost = TotalConstructionCost(indirect_construction_cost, direct_construction_cost)
            
            cost = indirect_construction_cost + direct_construction_cost;

        end

        % YearlyPersonnelCost : Cost of personnel for a year
        function cost = YearlyPersonnelCost(hourly_personnel_cost)

            cost = hourly_personnel_cost*7.6*7*52.18;

        end

        % TotalCostOfVacuumSystem : Total cost for vacuum system
        function cost = TotalCostOfVacuumSystem(mass_of_vacuum_vessel, shielding_material_costs_for_vacuum_vessel, mass_flow_rate)

            cost = 90.69 * mass_of_vacuum_vessel + shielding_material_costs_for_vacuum_vessel + 13.04 * mass_flow_rate * 112.32;

        end

        % Capital Cost : Captial costs
        function cost = CapitalCost(total_cost_of_vacuum_system, total_fuel_manufacturing_costs_upfront, total_construction_cost, total_cost_of_fuel_delivery_and_storage, turbine_plant_equipment, total_coolant_cost, instrumentation_and_control_system_cost, reactor_shielding_initial_cost, laser_equipment_cost)

            cost = total_cost_of_vacuum_system + total_fuel_manufacturing_costs_upfront + total_construction_cost * 10^6 + total_cost_of_fuel_delivery_and_storage + turbine_plant_equipment + total_coolant_cost + (instrumentation_and_control_system_cost + reactor_shielding_initial_cost + laser_equipment_cost) * 10^6;

        end

        % YearlyCost : Yearly Cost
        function cost = YearlyCost(yearly_personnel_cost, total_fuel_manufacturing_costs_ongoing, lifetime_maintenance_cost, number_of_years_in_service)

            cost = yearly_personnel_cost + total_fuel_manufacturing_costs_ongoing + lifetime_maintenance_cost/number_of_years_in_service;

        end

        % YearlyGrossRevenue : Yearly gross revenue
        function revenue = YearlyGrossRevenue(yearly_net_energy_output, electricity_rate)
            
            revenue = yearly_net_energy_output * electricity_rate;

        end

        % YearlyProfit : Yearly profit
        function profit = YearlyProfit(yearly_gross_revenue, yearly_cost)

            profit = yearly_gross_revenue - yearly_cost;

        end

        % LifetimeCostNoInflation : Lifetime cost (no inflation)
        function cost = LifetimeCostNoInflation(yearly_cost, number_of_years_in_service, capital_cost)

            cost = yearly_cost * number_of_years_in_service + capital_cost;

        end

        % LifetimeProfitNoInflation : Lifetime profit (no inflation)
        function profit = LifetimeProfitNoInflation(yearly_profit, number_of_years_in_service)

            profit = yearly_profit * number_of_years_in_service;

        end

        % AnnualCostOfUpfrontCapital : Annual cost of upfront capital
        function c_ac = AnnualCostOfUpfrontCapital(capital_cost, number_of_years_in_service)

            c_ac = capital_cost / number_of_years_in_service;

        end

        % AnnualCostOfOperationsAndMaintenance : Annual cost of op and main
        function c_om = AnnualCostOfOperationsAndMaintenance(yearly_personnel_cost, yearly_regular_maintenance_cost)
            
            c_om = yearly_personnel_cost + yearly_regular_maintenance_cost;

        end

        % AnnualCostOfSchedulePartReplacements : Annual cost of replace
        function c_scr = AnnualCostOfSchedulePartReplacements(lifetime_maintenance_cost, number_of_years_in_service, yearly_regular_maintenance_cost)

            c_scr = lifetime_maintenance_cost/number_of_years_in_service - yearly_regular_maintenance_cost;

        end

        % AnnualCostOfFuel : Annual cost of fuel
        function c_f = AnnualCostOfFuel(total_fuel_manufacturing_costs_ongoing)
            
            c_f = total_fuel_manufacturing_costs_ongoing;
        
        end

        % CostOfDecomissioning : Cost to decomission plant
        function c_dd = CostOfDecomissioning(decomissioning_cost, yearly_net_energy_output, number_of_years_in_service)

            c_dd = (decomissioning_cost * 10^6) / (yearly_net_energy_output * number_of_years_in_service);

        end

        % LCOE : The levelized cost of electricity
        function lcoe = LCOE(c_ac, c_om, c_scr, c_f, c_dd, inflation_coefficient, number_of_years_in_service, yearly_net_energy_output)

            lcoe = ((c_ac+(c_om+c_scr+c_f)*(1+inflation_coefficient)^number_of_years_in_service)/(yearly_net_energy_output)+c_dd);

        end

        % TotalProjectCost : Time series data for project cost
        function tpc_ts = TotalProjectCost(capital_cost, yearly_cost, c_om, inflation_coefficient, income_ts)

            tpc_0 = capital_cost + yearly_cost / 12;
            tpc_p = tpc_0;
            
            tpc_ts = tpc_0;
            num_periods = length(income_ts);

            for i = 1:num_periods-1

                tpc_i = (tpc_p + c_om/12 - income_ts(i))*(1 + inflation_coefficient/12);
                tpc_ts = [tpc_ts, tpc_i];
                tpc_p = tpc_i;

            end

        end

        % ProjectedLifetimeCostWithInflation : Lifetime cost
        function cost = ProjectedLifetimeCostWithInflation(income_ts)
            cost = sum(income_ts);
        end

        % ProjectedLifetimeGrossRevenueWithInflation : Gross revenue
        function revenue = ProjectedLifetimeGrossRevenueWithInflation(projected_lifetime_cost_with_inflation, projected_lifetime_net_revenue_with_inflation)
            revenue = projected_lifetime_cost_with_inflation + projected_lifetime_net_revenue_with_inflation;
        end

        % ProjectedLifetimeNetRevenueWithInflation : Net revenue
        function revenue = ProjectedLifetimeNetRevenueWithInflation(total_project_cost_ts)
            revenue = -total_project_cost_ts(end);
        end

        % INCOME : 

        % --- Not in UI ---

        % LaserEquipmentCost : cost of laser equipment
        function cost = LaserEquipmentCost(net_energy_output)

            cost = (1400*net_energy_output*1000)/(10^6);

        end

        % TotalReactorEnergyConsumptionCost : Cost of running reactor
        function cost = TotalReactorEnergyConsumptionCost(total_reactor_energy_consumption, electricity_rate)

            cost = total_reactor_energy_consumption * electricity_rate;

        end

        % TotalCostPerPellet : Total cost per fuel pellet
        function cost = TotalCostPerPellet(fuel_pellet_mass, fuel_pellet_percentage_boron_nitride, cost_of_boron_nitride, cost_of_manufacturing_per_pellet)
            
            cost = fuel_pellet_mass*(fuel_pellet_percentage_boron_nitride*cost_of_boron_nitride)/(1000)+cost_of_manufacturing_per_pellet; 

        end

        % TotalCostPerTargetWithXFactor : Total target cost with x factor
        function cost = TotalCostPerTargetWithXFactor(x_factor, total_cost_of_x_factor)

            cost = x_factor * total_cost_of_x_factor;
            
        end

        % TotalCostPerCapacitiveCoilAndHydrogenCone : Total cost
        function cost = TotalCostPerCapacitiveCoilAndHydrogenCone(capacitive_coil_and_hydrogen_cone, total_material_cost_per_capacitive_coil_and_hydrogen_cone, cost_of_manufacturing_per_capacitive_coil_and_hydrogen_cone)

            cost = capacitive_coil_and_hydrogen_cone*(total_material_cost_per_capacitive_coil_and_hydrogen_cone+cost_of_manufacturing_per_capacitive_coil_and_hydrogen_cone);

        end

        % TotalMaterialCostPerCapacitiveCoilAndHydrogenCone : Cost
        function cost = TotalMaterialCostPerCapacitiveCoilAndHydrogenCone(hydrogen_precursor_mass, cost_of_hydrogen)

            cost = 0.04+(hydrogen_precursor_mass*cost_of_hydrogen)/(1000);

        end

        % YearlyRegularMaintenanceCost : Cost of yearly maintenance
        function cost = YearlyRegularMaintenanceCost(cost_of_maintenance_per_kwh, yearly_net_energy_output)
            
            cost = cost_of_maintenance_per_kwh*1000*yearly_net_energy_output;

        end

        % DirectConstructionCost : Direct cost of construction
        function cost = DirectConstructionCost(land_cost, reactor_building_cost, turbine_building_cost, cooling_tower_system_cost, power_supply_and_energy_storage_cost, venilation_stack_cost, miscellaneous_buildings_cost, laser_construction_cost)

            cost = land_cost + reactor_building_cost + turbine_building_cost + cooling_tower_system_cost + power_supply_and_energy_storage_cost + venilation_stack_cost + miscellaneous_buildings_cost + laser_construction_cost;

        end

        % DecommissioningCost : Cost to decomission plant
        function cost = DecommissioningCost(decommissioning_cost_coefficient, direct_construction_cost)

            cost = decommissioning_cost_coefficient * direct_construction_cost;

        end

        % TotalCoolantCost : Total cost of coolant
        function cost = TotalCoolantCost(coolant_volume, coolant_density, coolant_cost)

            cost = coolant_volume * coolant_density * coolant_cost;

        end

        % HourlyPersonnelCost : Hourly cost of employees
        function cost = HourlyPersonnelCost(number_of_staff, average_hourly_wage)

            cost = number_of_staff * average_hourly_wage;

        end

        % --- Helper Methods ---


         % IncomeTS : Income time series
        function ts = IncomeTS(electricity_rate, yearly_net_energy_output, inflation_coefficient, periods)
            
            income_i = electricity_rate * yearly_net_energy_output / 12;
            ts = income_i;
    
            for i = 1:periods
    
                income_i = income_i * (1 + inflation_coefficient/12);
                ts = [ts, income_i];
    
            end
    
        end


    end

   



    % === Private Properties ===
    properties (Access = public)
    end


end