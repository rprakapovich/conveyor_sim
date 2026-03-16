clc
close all

Stations = readmatrix('data/stations.xlsx');

dt = 0.01;         % Simulation time step, s
V = 1;             % Conveyor speed, m/s
L = 20;            % Conveyor length, m
S = 0.1;           % Minimum safety distance between units, m
W = 0.1;           % Length of unit side, m 
Z = 0.15;          % Work zone radius for ich workstations on the conveyor, m
P = 1.8;           % Unit placement time (period) on moving conveyor, s
D = V * P;         % Distance between unit centres, m

RENDER_EVERY = 10;	% Plot screen refresh rate 
MAX_UNITS = 30;	% Maximum number of the units 

% Determine the number of workstation group types and the number of 
% workstations in each one
[type, indx] = unique(Stations(:,7));
max_type = numel(type);
num_type = zeros(1,max_type);

for i = 1: max_type
    num_type(i) = numel(find(Stations(:,7)==i));
end

% Declaring variables for fully processed and defective units
Finished_Units = 0;
Defect_Units = zeros(1, max_type);

% Initialization of the total number of units
Units = [(-MAX_UNITS:-1)*D; ones(1, MAX_UNITS); zeros(1, MAX_UNITS)];

Visual = visual_init(Stations);

% Calculating the time required to process all units and running the simulation 
for t = 0: ((MAX_UNITS * D + L) / V + sum(sum(Stations(indx,2:4))))/ dt

    Units(1,:) = Units(1,:) + dt * V;
    
    % Simulation of the working process at the workstations
    num = 0;
    for i = 1: max_type
        for j = 1:num_type(i)
            num = num + 1;

            if Stations(num, 5) == 0
                % The jth workstation from the ith workstation group picks
                % a unit from the conveyor belt
                [Units, Stations(num,:)] = ...
                    unit_picking(Units, Stations(num,:), Z, i-1);
            else
                % Workstation runtime counter
                if Stations(num, 5) > dt
                    Stations(num, 5) = Stations(num, 5) - dt;
                else
                    % The process of placing a processed unit in the first
                    % available safe location on the conveyor
                    [Units, Stations(num,:)] = ...
                        unit_placing(Units, Stations(num,:), S, W, i);
                end
            end
        end
    end

    % The process of working out the number of finished and defective units
    if numel(Units) > 0 && Units(1,end) > Stations(end, 1) + 3*D

        if Units(3,end) == max_type
            Finished_Units = Finished_Units + 1;
        end

        for i = 0: max_type-1
            if Units(3,end) == i
                Defect_Units(i+1) = Defect_Units(i+1) + 1;
            end
        end
        Units(:,end) = [];
    end

    % Render only every RENDER_EVERY steps
    if mod(t, RENDER_EVERY) == 0
        visual_update(Visual, Stations, Units, Finished_Units, Defect_Units);
        drawnow % limitrate - uncomment if you will use standalone version of MATLAB   
    end
    
end