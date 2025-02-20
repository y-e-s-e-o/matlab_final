function dXdt = msd_system(t,X)

dXdt = [X(2); sin(5*t)-2*X(1)-X(2)];

end
