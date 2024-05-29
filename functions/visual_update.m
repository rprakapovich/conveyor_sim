function [visual] = visual_update(visual, Stations, Units, Normal_Units, Defect_Units)


    num_types = unique(Stations(:,7));

    raw_units = find(Units(3,:)==0);
    set(visual.raw_units,'XData',Units(1,raw_units),...
                         'YData',zeros(1,numel(raw_units)))

    for i = 1: numel(num_types)
        machined = find(Units(3,:)==i);
        processed = intersect(find(Stations(:,5)>0),find(Stations(:,7)==i));
        set(visual.machined_units{i},'XData',[Units(1,machined),Stations(processed,1)'],...
                             'YData',[zeros(1,numel(machined)),-0.4*ones(1,numel(processed))]) 

    end
    for i = 1: size(Stations,1)
        set(visual.process{i}, 'String', num2str(Stations(i,5),'%.2f'))
    end


    set(visual.text_result_raw, 'String', num2str(Defect_Units(1)));
    for i = 2:numel(num_types)
        set(visual.text_result_machined{i-1}, 'String', num2str(Defect_Units(i)));
    end
    set(visual.text_result_machined{numel(num_types)}, 'String', num2str(Normal_Units))
end

