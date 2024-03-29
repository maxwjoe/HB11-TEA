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
            obj.ECON = EconomicsModule();

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
            output_keys = obj.DS.getKeys("OUT_");
            data = obj.DS.batchRead(output_keys);

        end

        % PostInputs : Posts Input values from Application Layer to UI
        % Note : This is used mostly when loading from a file
        function data = PostInputs(obj)

            % Perform a batch read operation on the data store and return
            input_keys = obj.DS.getKeys("IN_");
            data = obj.DS.batchRead(input_keys);

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

        % RunModel : Runs the Technoeconomic Model
        function RunModel(obj)
        
        outputs = struct();

        % === Input Parameters ===

        % --- UI --- (TODO: APPEND IN)
        
        IN_total_laser_energy_per_pulse = obj.DS.read("IN_total_laser_energy_per_pulse_");
        IN_repetition_rate = obj.DS.read("IN_repetition_rate_");
        IN_laser_efficiency = obj.DS.read("IN_laser_efficiency_");
        IN_target_gain = obj.DS.read("IN_target_gain_");
        IN_increased_gain_by_x_factor = obj.DS.read("IN_increased_gain_by_x_factor_");
        IN_duty_cycle = obj.DS.read("IN_duty_cycle_");
        IN_electricity_generator_efficiency = obj.DS.read("IN_electricity_generator_efficiency_");
        IN_electricity_rate = obj.DS.read("IN_electricity_rate_");
        IN_x_factor = obj.DS.read("IN_x_factor_");
        IN_total_cost_of_x_factor = obj.DS.read("IN_total_cost_of_x_factor_");
        IN_capacitive_coil_and_hydrogen_cone = obj.DS.read("IN_capacitive_coil_and_hydrogen_cone_");
        IN_number_of_years_in_service = obj.DS.read("IN_number_of_years_in_service_");
        IN_number_of_staff = obj.DS.read("IN_number_of_staff_");
        IN_mass_flow_rate = obj.DS.read("IN_mass_flow_rate_");
        
        
        % --- SET ---
        
        reactor_shielding_initial_cost = 20;
        instrumentation_and_control_system_cost = 5.2;
        turbine_plant_equipment = 186700000;
        production_failure_rate = 0.1;
        fuel_pellet_mass = 1;
        hydrogen_precursor_mass = 0.040;
        cost_of_hydrogen = 5;
        fuel_pellet_percentage_boron_nitride = 1;
        cost_of_boron_nitride = 120;
        cost_of_manufacturing_per_pellet = 0.08;
        cost_of_manufacturing_per_capacitive_coil_and_hydrogen_cone = 0.15;
        total_cost_of_fuel_development = 100000000;
        total_cost_of_manufacturing_facilities = 50000000;
        total_manufacturing_overhead_costs = 3000000;
        final_assembly_cost_per_target = 0.06;
        storage_cost = 1000;
        storage_footprint_per_target = 0.009;
        required_redundancy = 90;
        stack_height = 50;
        cost_of_fuel_delivery_robot = 250000;
        total_cost_of_fuel_storage = 923788.80;
        diode_replacement_cost = 1000000;
        turbine_generators_replacement_cost = 75000000;
        lifetime_wall_replacement_cost = 20000000;
        cost_of_maintenance_per_kwh = 0.00588;
        turbine_replacement_interval = 25.01;
        coolant_replacement_interval = 4;
        diode_replacement_interval = 7;
        land_cost = 10.1;
        reactor_building_cost = 321.85;
        turbine_building_cost = 110;
        cooling_tower_system_cost = 24.4;
        power_supply_and_energy_storage_cost = 162.2;
        ventilation_stack_cost = 2;
        laser_construction_cost = 38;
        miscellaneous_buildings_cost = 263.4;
        inflation_coefficient = 0.045;
        indirect_construction_cost = 214.3485;
        decomissioning_cost_coefficient = 0.12;
        mixed_mean_coolant_temperature_rise = 300;
        specific_heat_of_coolant = 2414.17;
        coolant_cost = 131;
        coolant_volume = 100000;
        coolant_density = 1.91;
        cooling_system_pressure = 100000;
        coolant_pipe_outlet_radius = 0.39;
        average_hourly_wage = 55;
        shielding_material_costs_for_vacuum_vessel = 0;
        radius_of_vacuum_vessel = 10;
        height_of_vacuum_vessel = 15;
        wall_thickness_of_vacuum_vessel = 0.01;
        density_of_vacuum_vessel_material = 8000;
        vacuum_system_power_usage = 0.13;
        
        % === Model ===
        
        % [Primary Laser, Reactor, Power Generation]
        
        laser_energy_output = obj.PROC.LaserEnergyOutput(IN_total_laser_energy_per_pulse, IN_repetition_rate);
        laser_energy_input = obj.PROC.LaserEnergyInput(laser_energy_output, IN_laser_efficiency);
        thermal_reaction_energy_output = obj.PROC.ThermalReactionEnergyOutput(IN_x_factor, IN_increased_gain_by_x_factor, IN_target_gain, laser_energy_output);
        gross_energy_output = obj.PROC.GrossEnergyOutput(thermal_reaction_energy_output, IN_electricity_generator_efficiency);
        realised_reactor_gain = obj.PROC.RealisedReactorGain(gross_energy_output, laser_energy_input);
        cooling_system_energy_consumption = obj.PROC.CoolingSystemEnergyConsumption(thermal_reaction_energy_output);
        total_reactor_energy_consumption = obj.PROC.TotalReactorEnergyConsumption(laser_energy_input, cooling_system_energy_consumption, vacuum_system_power_usage);
        net_energy_output = obj.PROC.NetEnergyOutput(gross_energy_output, total_reactor_energy_consumption);
        hours_in_operation_per_year = obj.PROC.HoursInOperationPerYear(IN_duty_cycle);
        yearly_net_energy_output = obj.PROC.YearlyNetEnergyOutput(net_energy_output, hours_in_operation_per_year);
        laser_equipment_cost = obj.ECON.LaserEquipmentCost(net_energy_output);
        

        outputs.OUT_thermal_reaction_energy_output_ = thermal_reaction_energy_output;
        outputs.OUT_realised_reactor_gain_ = realised_reactor_gain;
        outputs.OUT_gross_power_output_ = gross_energy_output;
        outputs.OUT_total_reactor_energy_consumption_ = total_reactor_energy_consumption;
        outputs.OUT_net_power_output_ = net_energy_output;
        outputs.OUT_hours_in_operation_per_year_ = hours_in_operation_per_year;
        outputs.OUT_yearly_net_power_output_ = yearly_net_energy_output;


        
        % [Fuel Manufacturing Costs, Fuel Storage/Delivery, Maintenance Costs, Cooling System]
        
        cooling_system_energy_consumption = obj.PROC.CoolingSystemEnergyConsumption(thermal_reaction_energy_output);
        total_coolant_cost = obj.ECON.TotalCoolantCost(coolant_volume, coolant_density, coolant_cost);
        coolant_flow_rate = obj.PROC.CoolantFlowRate(thermal_reaction_energy_output, mixed_mean_coolant_temperature_rise, specific_heat_of_coolant);
        
        required_targets_per_year = obj.PROC.RequiredTargetsPerYear(IN_repetition_rate, IN_duty_cycle);
        fuel_target_production_per_year = obj.PROC.FuelTargetProductionPerYear(required_targets_per_year, production_failure_rate);
        total_cost_per_pellet = obj.ECON.TotalCostPerPellet(fuel_pellet_mass, fuel_pellet_percentage_boron_nitride, cost_of_boron_nitride, cost_of_manufacturing_per_pellet);
        total_cost_per_target_with_x_factor = obj.ECON.TotalCostPerTargetWithXFactor(IN_x_factor, IN_total_cost_of_x_factor);
        total_material_cost_per_capacitive_coil_and_hydrogen_cone = obj.ECON.TotalMaterialCostPerCapacitiveCoilAndHydrogenCone(hydrogen_precursor_mass, cost_of_hydrogen);
        total_cost_per_capacitive_coil_and_hydrogen_cone = obj.ECON.TotalCostPerCapacitiveCoilAndHydrogenCone(IN_capacitive_coil_and_hydrogen_cone, total_material_cost_per_capacitive_coil_and_hydrogen_cone, cost_of_manufacturing_per_capacitive_coil_and_hydrogen_cone);
        total_cost_per_target = obj.ECON.TotalCostPerTarget(total_cost_per_pellet, total_cost_per_target_with_x_factor, total_cost_per_capacitive_coil_and_hydrogen_cone, final_assembly_cost_per_target);
        total_fuel_manufacturing_costs_upfront = obj.ECON.TotalFuelManufacturingCostsUpfront(total_cost_of_fuel_development, total_cost_of_manufacturing_facilities);
        total_fuel_manufacturing_costs_ongoing = obj.ECON.TotalFuelManufacturingCostsOngoing(total_manufacturing_overhead_costs, fuel_target_production_per_year, total_cost_per_target);
        total_cost_of_fuel_delivery_and_storage = obj.ECON.TotalCostOfFuelDeliveryAndStorage(total_cost_of_fuel_storage, cost_of_fuel_delivery_robot);
        number_of_targets_required_in_storage = obj.PROC.NumberOfTargetsRequiredInStorage(IN_repetition_rate, IN_duty_cycle, required_redundancy);
        yearly_regular_maintenance_cost = obj.ECON.YearlyRegularMaintenanceCost(cost_of_maintenance_per_kwh, yearly_net_energy_output);
        lifetime_maintenance_cost = obj.ECON.LifetimeMaintenanceCost(IN_number_of_years_in_service, turbine_replacement_interval, turbine_generators_replacement_cost, diode_replacement_cost, laser_energy_input, diode_replacement_interval, IN_repetition_rate, lifetime_wall_replacement_cost, total_coolant_cost, coolant_replacement_interval, yearly_regular_maintenance_cost);
        
        
        outputs.OUT_total_cost_per_target_ = total_cost_per_target;
        outputs.OUT_total_fuel_manufacturing_costs_upfront_ = total_fuel_manufacturing_costs_upfront;
        outputs.OUT_total_fuel_manufacturing_costs_ongoing_ = total_fuel_manufacturing_costs_ongoing;
        outputs.OUT_total_cost_of_fuel_delivery_and_storage_ = total_cost_of_fuel_delivery_and_storage;
        outputs.OUT_lifetime_maintenance_cost_ = lifetime_maintenance_cost;
        

        % [Construction, Personnel, Vacuum]
        
        direct_construction_cost = obj.ECON.DirectConstructionCost(land_cost, reactor_building_cost, turbine_building_cost, cooling_tower_system_cost, power_supply_and_energy_storage_cost, ventilation_stack_cost, miscellaneous_buildings_cost, laser_construction_cost);
        total_construction_cost = obj.ECON.TotalConstructionCost(indirect_construction_cost, direct_construction_cost);
        decomissioning_cost = obj.ECON.DecommissioningCost(decomissioning_cost_coefficient, direct_construction_cost);
        
        hourly_personnel_cost = obj.ECON.HourlyPersonnelCost(IN_number_of_staff, average_hourly_wage);
        yearly_personnel_cost = obj.ECON.YearlyPersonnelCost(hourly_personnel_cost);
        
        mass_of_vacuum_vessel = obj.PROC.MassOfVacuumVessel(height_of_vacuum_vessel, radius_of_vacuum_vessel, wall_thickness_of_vacuum_vessel, density_of_vacuum_vessel_material);
        total_cost_of_vacuum_system = obj.ECON.TotalCostOfVacuumSystem(mass_of_vacuum_vessel, shielding_material_costs_for_vacuum_vessel, IN_mass_flow_rate);
        
        outputs.OUT_total_construction_cost_ = total_construction_cost;
        outputs.OUT_yearly_personnel_cost_ = yearly_personnel_cost;
        outputs.OUT_total_cost_of_vacuum_system_ = total_cost_of_vacuum_system;


        % [Overall]
        capital_cost = obj.ECON.CapitalCost(total_cost_of_vacuum_system, total_fuel_manufacturing_costs_upfront, total_construction_cost, total_cost_of_fuel_delivery_and_storage, turbine_plant_equipment, total_coolant_cost, instrumentation_and_control_system_cost, reactor_shielding_initial_cost, laser_equipment_cost);
        yearly_cost = obj.ECON.YearlyCost(yearly_personnel_cost, total_fuel_manufacturing_costs_ongoing, lifetime_maintenance_cost, IN_number_of_years_in_service);
        yearly_gross_revenue = obj.ECON.YearlyGrossRevenue(yearly_net_energy_output, IN_electricity_rate);
        yearly_profit = obj.ECON.YearlyProfit(yearly_gross_revenue, yearly_cost);
        lifetime_cost_no_inflation = obj.ECON.LifetimeCostNoInflation(yearly_cost, IN_number_of_years_in_service, capital_cost);
        lifetime_profit_no_inflation = obj.ECON.LifetimeProfitNoInflation(yearly_profit, IN_number_of_years_in_service);

        outputs.OUT_capital_cost_ = capital_cost;
        outputs.OUT_yearly_cost_ = yearly_cost;
        outputs.OUT_yearly_gross_revenue_ = yearly_gross_revenue;
        outputs.OUT_yearly_profit_ = yearly_profit;
        outputs.OUT_lifetime_cost_without_inflation_ = lifetime_cost_no_inflation;
        outputs.OUT_lifetime_profit_without_inflation_ = lifetime_profit_no_inflation;
        
        % [LCOE]
        annual_cost_of_upfront_capital = obj.ECON.AnnualCostOfUpfrontCapital(capital_cost, IN_number_of_years_in_service);
        annual_cost_of_operations_and_maintenance = obj.ECON.AnnualCostOfOperationsAndMaintenance(yearly_personnel_cost, yearly_regular_maintenance_cost);
        annual_cost_of_schedule_part_replacements = obj.ECON.AnnualCostOfSchedulePartReplacements(lifetime_maintenance_cost, IN_number_of_years_in_service, yearly_regular_maintenance_cost);
        annual_cost_of_fuel = obj.ECON.AnnualCostOfFuel(total_fuel_manufacturing_costs_ongoing);
        cost_of_decomissioning = obj.ECON.CostOfDecomissioning(decomissioning_cost, yearly_net_energy_output, IN_number_of_years_in_service);
        lcoe = obj.ECON.LCOE(annual_cost_of_upfront_capital, annual_cost_of_operations_and_maintenance, annual_cost_of_schedule_part_replacements, annual_cost_of_fuel, cost_of_decomissioning, inflation_coefficient, IN_number_of_years_in_service, yearly_net_energy_output);


        outputs.OUT_annual_cost_of_upfront_capital_ = annual_cost_of_upfront_capital;
        outputs.OUT_annual_cost_of_operations_and_maintenance_ = annual_cost_of_operations_and_maintenance;
        outputs.OUT_annual_cost_of_scheduled_part_replacements_ = annual_cost_of_schedule_part_replacements;
        outputs.OUT_annual_cost_of_fuel_ = annual_cost_of_fuel;
        outputs.OUT_cost_of_decomissioning_ = cost_of_decomissioning;
        outputs.OUT_lcoe_ = lcoe;
        
        % [Financial Projections]
        income_ts = obj.ECON.IncomeTS(IN_electricity_rate, yearly_net_energy_output, inflation_coefficient, 300);
        total_project_cost_ts = obj.ECON.TotalProjectCost(capital_cost, yearly_cost, annual_cost_of_operations_and_maintenance, inflation_coefficient, income_ts);
        projected_lifetime_cost_with_inflation = obj.ECON.ProjectedLifetimeCostWithInflation(income_ts);
        projected_lifetime_net_revenue_with_inflation = obj.ECON.ProjectedLifetimeNetRevenueWithInflation(total_project_cost_ts);
        projected_lifetime_gross_revenue_with_inflation = obj.ECON.ProjectedLifetimeGrossRevenueWithInflation(projected_lifetime_cost_with_inflation, projected_lifetime_net_revenue_with_inflation);
        
        
        outputs.OUT_projected_lifetime_cost_ = projected_lifetime_cost_with_inflation;
        outputs.OUT_projected_lifetime_gross_revenue_ = projected_lifetime_gross_revenue_with_inflation;
        outputs.OUT_projected_lifetime_net_revenue_ = projected_lifetime_net_revenue_with_inflation;

        outputs.OUT_total_project_cost_ts_ = total_project_cost_ts;
        
        % --- Write to datastore ---
        obj.DS.batchWrite(outputs);

        end

    end

    % === Private Methods ===
    methods (Access = private)

        

    end

    % === Private Properties ===
    properties (Access = private)
        DS;
        PROC;
        ECON;
    end

end