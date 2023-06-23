% File : Example Model
% Description : Example of Model with Dummy Variables/Values Used


% --- Dummy Variable ---
Laser_Energy_Input = 0
Laser_Energy_Output = 0


Generator_Efficiency = 0.5



% --- Dummy Code ---
Reaction_Energy_Output = Reaction_Energy*Number_of_Reactions_per_Second
Generator_Energy_Output = Generator_Efficiency*Reaction_Energy_Output



% --- Dummy Functions ---

% printHello : Prints hello 
function printHello()
    fprintf("\nHello, World!\n");
end
