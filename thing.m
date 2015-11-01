function [minreq, min_i, min_j, rt] = thing(m, n, t)
    minreq = m * n;
    min_i = 0;
    min_j = 0;
    rt = -1;

    for i=2:m
        if mod(m, i) ~= 0
            continue
        end
        for j=2:n
            if mod(n, j) ~= 0
                continue
            end
            if (m/i * n/j < minreq)
                r = one_drone_time(i, j);
                if (r < t)
                    minreq = m/i * n/j;
                    min_i = i;
                    min_j = j;
                    rt = r;
                end
            end
        end
    end

    minreq
    min_i
    min_j
    rt
end