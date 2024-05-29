function [Units, Station] = unit_picking(Units, Station, Zone, Type)

    for j=1:size(Units,2)
        if Units(1,j) + Zone > Station(1) &&...
           Units(1,j) < Station(1) && ...
           Units(3,j) == Type

            Station(5) = sum(Station(2:4));
            Units(:,j) = [];
            break
        end
    end
end

