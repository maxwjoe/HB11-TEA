% File : Example Model
% Description : Example of Model with Dummy Variables/Values Used

% --- Dummy Variable ---
Laser_Energy_Input = 0
Laser_Energy_Output = 0

Generator_Efficiency = 0.5
%IF DET NOT POSSIBLE THEN ACCOUNT FOR NORMAL POWER GENERATION COSTS



Cost_of_Electricity_AUD_per_kWh = 10

Operational_Hours = 0
Operational_Days = 0
Operational_Years = 0

Cost_of_Boron_AUD_per_kg = 0
Cost_of_Hydrogen_AUD_per_kg =0 

Number_of_Pellets_per_Reaction =0
Number_of_Reactions_per_Second = 0

Boron_Amount_per_Reaction=0
Hydrogen_Amount_per_Reaction = 0

Reaction_Energy = 0

Number_of_Staff = 0
Number_of_Working_Hours_per_Day = 0
Average_Hourly_Wage = 0


Number_of_Years_in_Service = 0
Number_of_Days_in_Service = Number_of_Years_in_Service*365

Operational_Cost =0

Maintenance_Cost = 0
Maintenance_Cycle = 0

End_of_Life_Plan = 0
% --- Dummy Code ---
Energy_Input_Cost = Cost_of_Electricity_AUD_per_kWh*Laser_Energy_Input

Cost_of_Pellets = Cost_of_Boron_AUD_per_kg*Number_of_Pellets_per_Reaction
Cost_of_Fuel_per_Day = Cost_of_Pellets + Boron_Amount_per_Reaction*Cost_of_Boron_AUD_per_kg + Hydrogen_Amount_per_Reaction*Cost_of_Hydrogen_AUD_per_kg

Reaction_Energy_Output = Reaction_Energy*Number_of_Reactions_per_Second
Generator_Energy_Output = Generator_Efficiency*Reaction_Energy_Output

Generator_Energy_Gross_Profit_per_Day = Generator_Energy_Output*Cost_of_Electricity_AUD_per_kWh*Operational_Hours
Generator_Energy_Gross_Profit_per_Year = Generator_Energy_Output*Cost_of_Electricity_AUD_per_kWh*Operational_Days
Generator_Energy_Gross_Profit_per_Lifetime = Generator_Energy_Output*Cost_of_Electricity_AUD_per_kWh*Operational_Years

Personnel_Cost = Number_of_Staff*Number_of_Working_Hours_per_Day*Average_Hourly_Wage

Net_Profit_per_Day = Generator_Energy_Gross_Profit_per_Day - Operational_Cost - Personnel_Cost - Cost_of_Fuel_per_Day - Energy_Input_Cost
Net_Profit_per_Lifetime = Generator_Energy_Gross_Profit_per_Lifetime - Operational_Cost - Personnel_Cost*Number_of_Days_in_Service - Cost_of_Fuel_per_Day*Number_of_Days_in_Service- Energy_Input_Cost*Number_of_Days_in_Service - Maintenance_Cost*Maintenance_Cycle - End_of_Life_Plan

