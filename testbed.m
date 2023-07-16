% File : testbed.m
% Description : Write quick tests

App = ApplicationModule();

dataIn = struct();
dataIn.("Test") = 4;
dataIn.("Dog") = 5;


App.LoadInputs(dataIn);
App.PostOutputs(["Test"])