% File : DataStoreTests.m
% Description : Test definitions for the data store

% === Setup ===
addpath("DataStoreModule/");

% === Execution ===

disp("=== Start DataStoreModule Tests ===");


T_DS_BASIC_READ_WRITE();

disp("=== End DataStoreModule Tests ===");

% === Definitions ===

function res = T_DS_BASIC_READ_WRITE()
    
    test_val = 56;

    DS = DataStoreModule();
    DS.declare("MyVar");
    DS.set("MyVar", test_val);
    cmp_val = DS.read("MyVar");

    assert(test_val == cmp_val);

end

