clc
close all

Stations = readmatrix('data/stations.xlsx');

dt = 0.01;         % Simulation time step, s
V = 1;             % Conveyor speed, m/s
L = 20;            % Conveyor length, m
S = 0.1;           % Minimum safety distance between units, m
W = 0.1;           % Length of unit side, m 
Z = 0.15;          % Work zone radius for ich stations on the conveyor, m
P = 1.8;           % Unit placement time (period) on moving conveyor, s
N = 4;             % Number of stations in the first group, pcs
D = V * P;         % Distance between unit centres, m

type = unique(Stations(:,7));
max_type = numel(type);
num_type = zeros(1,max_type);

for i = 1: max_type
    num_type(i) = numel(find(Stations(:,7)==i));
end
Normal_Units = 0;
Defect_Units = zeros(1, max_type);


Units = [];
for i = 0: N-1
    Units = [[-i*D; 1; 0], Units]; % 3xN, N - number of units
end
Num_Units = N;

Visual = visual_init(Stations);

for t = 0: 5000

    Units(1,:) = Units(1,:) + dt * V;
    
    if  Units(1,1) + (N-2)*D > 0
        Units = [[Units(1,1)-D; 1; 0], Units];
        Num_Units = Num_Units + 1;
    end

    num = 0;
    for i = 1: max_type
        for j = 1:num_type(i)
            num = num + 1;

            if Stations(num, 5) == 0
                [Units, Stations(num,:)] = unit_picking(Units, Stations(num,:), Z, i-1);
            else
                if Stations(num, 5) > dt
                    Stations(num, 5) = Stations(num, 5) - dt;
                else
                    [Units, Stations(num,:)] = ...
                        unit_placing(Units, Stations(num,:), S, W, i);
                end
            end
        end
    end

    if Units(1,end) > Stations(end, 1) + D
        if Units(3,end) == max_type
            Normal_Units = Normal_Units + 1;
        end

        for i = 0: max_type-1
            if Units(3,end) == i
                Defect_Units(i+1) = Defect_Units(i+1) + 1;
            end
        end
    
        Units(:,end) = [];
    end
    Visual = visual_update(Visual, Stations, Units, Normal_Units, Defect_Units);
    drawnow

end