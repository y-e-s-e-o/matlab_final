tspan = [0 10];
X0 = [0;0];

[t X] = ode45('msd_system', tspan, X0);

plot(t, X(:,1));
xlabel('t'); ylabel('x');