function [Units, Station] = unit_placing(Units, Station, Safety_dist, Width, Type)

    for j = 1: size(Units,2)-1
        if Units(1,j) + (Safety_dist+Width) < Station(1) && ...
          Units(1,j+1) - (Safety_dist+Width) > Station(1)
            Units = [Units(:,1:j),...
                     [Station(1);1;Type],...
                     Units(:,j+1:end)];
            Station(5) = 0;
            Station(6) = Station(6) + 1;
            break
        end
    end
    
    j = j + 1;
    if Units(1,j) + (Safety_dist+Width) < Station(1)
               
        Units = [Units, [Station(1);1;Type]];
        Station(5) = 0;
        Station(6) = Station(6) + 1;
    end

end

