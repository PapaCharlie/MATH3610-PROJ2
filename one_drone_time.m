function r = one_drone_time(m,n)
    if (m == 1 || n == 1)
        r = (max(m, n)-1) * 2;
    elseif (mod(m, 2) == 0 || mod(n, 2) == 0)
        r = m * n;
    else
        r = m * n + min(m, n) - 1;
    end
end