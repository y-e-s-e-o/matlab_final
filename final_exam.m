choice = menu('final exam', '1.ODE', '2.Simulink', '3.GUI-Simulink');

switch choice
    case 1
        prob1()
    case 2
        open_system('prob2.slx');
    case 3
        prob3()
end
        