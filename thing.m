function [minreq, min_i, min_j] = thing(m, n, t)
    if (m <= 0 || n <= 0)
        minreq = 0;
        rt = 0;
        min_i = 0;
        min_j = 0;
    elseif (one_drone_time(m,n) <= t)
        min_i = m;
        min_j = n;
        minreq = 1;
    elseif (m == 1 || n == 1)
        k = floor(t/2) + 1;
        min_i = ceil(m / k);
        min_j = ceil(n / k);
        minreq = max(min_i, min_j);
    %elseif (m == 2 || n == 2)
        % minreq = m*n;
    else
        minreq = m*n;
        a = zeros(m,n);
        for i=1:m
            if (2*(i-1) > t)
                a(i,1) = m*n;
            else
                a(i,1) = ceil(m/i)*n;
            end
        end
        for j=1:n
            if (2*(j-1) > t)
                a(1,j) = m*n;
            else
                a(1,j) = m*ceil(n/j);
            end
        end
        flag = 0;
        for i=2:m
            for j=2:n
                if (i == m && j == n)
                    %break
                end
                x = mod(m,i);
                y = mod(n,j);
                r = one_drone_time(i,j);
                if (r > t)
                    a(i,j) = m*n;
                else
                    a(i,j) = floor(m/i)*floor(n/j) + min(thing(x,n,t)+thing(m-x,y,t),thing(x,n-y,t)+thing(m,y,t));
                end
                if (a(i,j) < minreq)
                    minreq = a(i,j);
                    min_i = i;
                    min_j = j;
                end
                if (a(i, j) == m*n / t)
                    flag = 1;
                    break
                end
            end
            if (flag)
                break
            end
        end
    end
end