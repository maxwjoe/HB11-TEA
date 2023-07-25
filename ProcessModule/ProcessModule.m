% File : ProcessModule.m
% Description : Defines the physical process module

classdef ProcessModule < handle

    % === Public Methods ===
    methods (Access = public)

        % Constructor 
        function obj = ProccessModule(obj)
        end

        % ComputeElectricityOut : Gets total elec output for a period
        function elec_out = ComputeElectricityOut(obj, mult_factor)
            elec_out = mult_factor * rand();
        end

        % Fuel Manufacturing Functions (equations) -----------------------

        % Cost per pellet (not incl. cone, capacitive coil or hohlraum)
        function pelletCost = costPerPellet(obj, pelletMass, percentHydrogen, hydrogenCost, percentHBN, HBNCost, fuelManufacturingCost)
            pelletCost = pelletMass * ((percentHydrogen * hydrogenCost) / (1000 * 100) + (percentHBN * HBNCost)/(1000 * 100)) + fuelManufacturingCost;
        end

        % Cost per hohlraum (has a value of 0 if hohlraum variable = false)
        function hohlraumCost = costPerHohlraum(obj, hohlraum, hohlraumMaterialCost, hohlraumManufacturingCost)
            hohlraumCost = hohlraum * (hohlraumMaterialCost + hohlraumManufacturingCost);
        end
        
        % Cost per cone and capacitive coil that is attached to each pellet
        function coneCoilCost = costPerConeCoil(obj, coneCoil, coneCoilMaterialCost, coneCoilManufacturingCost)
            coneCoilCost = coneCoil * (coneCoilMaterialCost + coneCoilManufacturingCost);
        end
        
        % Cost per target including pellet, hohlraum (if included), cone,
        % capacitive coil and assembly costs
        function targetCost = costPerTarget(obj, pelletCost, hohlraumCost, coneCoilCost, targetAssemblyCost)
            targetCost = pelletCost + hohlraumCost + coneCoilCost + targetAssemblyCost;
        end
        
        % The total number of fuel targets required based on the operation rate
        % and duty cycle (uptime) of the reactor
        function requiredTargetQty = targetsPerYear(obj, RepetitionRate, DutyCycle)
            requiredTargetQty = RepetitionRate * DutyCycle * 365 * 24 * 3600;
        end

        % The annual production required to meet the required fuel target
        % quantity, this includes a safety net to account for production
        % flaws
        function targetProductionQty = annualTargetProduction(obj, requiredTargetQty, manufacturingSafetyFactor)
            targetProductionQty = requiredTargetQty / (1 - (manufacturingSafetyFactor / 100));
        end

        % The total upfront costs associated with the fuel target manufacturing
        % process including research costs and manufacturing equipment
        % costs (not incl. any manufacturing)
        function initialManufacturingCost = upfrontManufacturingCost(obj, targetRNDCost, manufacturingEquipmentCost)
            initialManufacturingCost = targetRNDCost + manufacturingEquipmentCost;
        end

        % The cost per year associated with fuel target manufacturing that
        % includes the overhead costs of electricity, workers, materials and manufacturing of targets 
        function annualManufacturingCost = annualManufacturingCost(obj, targetProductionQty, targetCost, manufacturingOverhead)
            annualManufacturingCost = targetProductionQty * targetCost + manufacturingOverhead;
        end


    end

    % === Private Methods ===
    methods (Access = private)
    end

    % === Private Properties ===
    properties (Access = private)
    end

end