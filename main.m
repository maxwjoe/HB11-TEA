% File : Main
% Description : Application Entry Point

% === Import Paths ===
addpath("./DataStoreModule");
addpath("./EconomicsModule");
addpath("./PhysicsModule");

% === Instantiate the modules ===
DS = DataStoreModule();
PHYS = PhysicsModule(DS);
ECON = EconomicsModule(DS);

% === Call Methods ===

% Computes electricity generated (physics)
PHYS.ComputeTotalElectricityGenerated();

% Computes total revenue using the physics result and input cost (Economics)
ECON.ComputeTotalRevenue(12);

% Creates a demo array of specified length from within the econ module
ECON.DemonstrateArrayCompute(2);

% === Read from global data store to show functionality === 

DS.read("TotalRevenue")
DS.read("DemoArray")



