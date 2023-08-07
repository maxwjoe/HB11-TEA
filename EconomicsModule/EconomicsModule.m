% File : EconomicsModule.m
% Description : Defines the economics module

classdef EconomicsModule < handle


    % === Public Methods ===
    methods (Access = public)
    end

    % === Static Public Methods ===
    methods (Static, Access = public)

        % TotalCostPerTarget : Total cost per target
        function cost = TotalCostPerTarget()
        end

        % TotalFuelManufacturingCostsUpfront : Upfront fuel man costs
        function cost = TotalFuelManufacturingCostsUpfront()
        end

        % TotalFuelManufacturingCostsOngoing : Ongoing fuel man costs
        function cost = TotalFuelManufacturingCostsOngoing()
        end

        % TotalCostOfFuelDeliveryAndStorage : Costs for fuel delivery/store
        function cost = TotalCostOfFuelDeliveryAndStorage()
        end

        % LifetimeMaintenanceCost : Cost of maintenance (lifetime)
        function cost = LifetimeMaintenanceCost()
        end

        % TotalConstructionCost : Total cost of construction
        function cost = TotalConstructionCost()
        end

        % YearlyPersonnelCost : Cost of personnel for a year
        function cost = YearlyPersonnelCost()
        end

        % TotalCostOfVacuumSystem : Total cost for vacuum system
        function cost = TotalCostOfVacuumSystem()
        end

        % Capital Cost : Captial costs
        function cost = CapitalCost()
        end

        % YearlyCost : Yearly Cost
        function cost = YearlyCost()
        end

        % YearlyGrossRevenue : Yearly gross revenue
        function revenue = YearlyGrossRevenue()
        end

        % YearlyProfit : Yearly profit
        function profit = YearlyProfit()
        end

        % LifetimeCostNoInflation : Lifetime cost (no inflation)
        function cost = LifetimeCostNoInflation()
        end

        % LifetimeProfitNoInflation : Lifetime profit (no inflation)
        function profit = LifetimeProfitNoInflation()
        end

        % AnnualCostOfUpfrontCapital : Annual cost of upfront capital
        function c_ac = AnnualCostOfUpfrontCapital()
        end

        % AnnualCostOfOperationsAndMaintenance : Annual cost of op and main
        function c_om = AnnualCostOfOperationsAndMaintenance()
        end

        % AnnualCostOfSchedulePartReplacements : Annual cost of replace
        function c_scr = AnnualCostOfSchedulePartReplacements()
        end

        % AnnualCostOfFuel : Annual cost of fuel
        function c_f = AnnualCostOfFuel()
        end

        % CostOfDecomissioning : Cost to decomission plant
        function c_dd = CostOfDecomissioning()
        end

        % LCOE : The levelized cost of electricity
        function lcoe = LCOE()
        end

        % TotalProjectCost : Time series data for project cost
        function tpc_ts = TotalProjectCost()
        end

        % ProjectedLifetimeCostWithInflation : Lifetime cost
        function cost = ProjectedLifetimeCostWithInflation()
        end

        % ProjectedLifetimeGrossRevenueWithInflation : Gross revenue
        function revenue = ProjectedLifetimeGrossRevenueWithInflation()
        end

        % ProjectedLifetimeNetRevenueWithInflation : Net revenue
        function revenue = ProjectedLifetimeNetRevenueWithInflation()
        end
  
    end

    % === Static Private Methods ===
    methods (Static, Access = private)
    end

    % === Private Properties ===
    properties (Access = public)
    end


end