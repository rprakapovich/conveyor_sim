function [visual] = visual_init(Stations)

positions = Stations(:,1);
num_types = unique(Stations(:,7));
max_type = numel(num_types);

last_pos = max(positions);
types = {'square','diamond','hexagram','pentagram','*','+'};
unit_colors = {'cyan','magenta','red','green','yellow','black'};
station_colors = [0.4940 0.1840 0.5560,
                  0.8500 0.3250 0.0980,
                  0.6350 0.0780 0.1840,
                  0.4660 0.6740 0.1880,
                  0 0.4470 0.7410,
                  0.3010 0.7450 0.9330];

visual.conveyor = fill([0,last_pos*1.2, last_pos*1.2, 0], ...
                       [-0.1, -0.1, 0.1, 0.1],...
                       [0.9290 0.6940 0.1250]);

hold all

for i = 1: numel(positions)
    visual.stations{i} = fill([0,0.2,-0.2,0]+positions(i),...
                              [-0.2, -0.5, -0.5, -0.2],...
                              station_colors(Stations(i,7),:));

    visual.process{i} = text(positions(i),-0.6,'0');
end

visual.raw_units = plot(-10,-10,'o', 'MarkerEdgeColor','k','MarkerFaceColor','blue','MarkerSize',8);
for i = 1: max_type
    visual.machined_units{i} = plot(-10,-10, types{i}, 'MarkerEdgeColor','k','MarkerFaceColor',unit_colors{i},'MarkerSize',8);
end

for i = max_type:-1:1
    visual.result_machined{i} = plot(1.4*last_pos, 0.4 + 0.1*(i-max_type), types{i},'MarkerEdgeColor','k','MarkerFaceColor',unit_colors{i},'MarkerSize',16);
    visual.text_result_machined{i} = text(1.5*last_pos, 0.4 + 0.1*(i-max_type),'0','Color',unit_colors{i},'FontSize',14);
end

visual.result_raw = plot(1.4*last_pos, 0.4 - 0.1*max_type, 'o','MarkerEdgeColor','k','MarkerFaceColor','blue','MarkerSize',16);
visual.text_result_raw = text(1.5*last_pos, 0.4 - 0.1*max_type,'0','Color','blue','FontSize',14);

axis([-0.2*last_pos, 1.6*last_pos, -1, 0.5]);
hold off
end

