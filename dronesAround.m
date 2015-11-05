function answer = dronesAround(region, boundary, t_region, t_outside)
    region_n = region(1);
    region_s = region(2);
    region_e = region(3);
    region_w = region(4);
    
    boundary_n = boundary(1);
    boundary_s = boundary(2);
    boundary_e = boundary(3);
    boundary_w = boundary(4);
    
    region_drones = thing(region_s - region_n + 1, region_w - region_e + 1, t_region);
    d1 = region_w - region_e + 1;
    d2 = region_w - boundary_e;
    d3 = boundary_w - region_e;
    d4 = boundary_w - boundary_e - 1;

    e1 = region_s - region_n + 1;
    e2 = region_s - boundary_n;
    e3 = boundary_s - region_n;
    e4 = boundary_s - boundary_n - 1;

    % north rectangle
    n1 = thing(d1,         region_n - boundary_n - 1,      t_outside); % between e and w
    n2 = thing(d2,         region_n - boundary_n - 1,      t_outside); % up to w
    n3 = thing(d3,         region_n - boundary_n - 1,      t_outside); % from e on
    n4 = thing(d4,         region_n - boundary_n - 1,      t_outside); % entire

    % south rectangle
    s1 = thing(d1,         boundary_s - region_s - 1,  t_outside);
    s2 = thing(d2,         boundary_s - region_s - 1,  t_outside);
    s3 = thing(d3,         boundary_s - region_s - 1,  t_outside);
    s4 = thing(d4,         boundary_s - region_s - 1,  t_outside);

    % left rectangle
    l1 = thing(region_e - boundary_e - 1,  e1,         t_outside); % between n and s
    l2 = thing(region_e - boundary_e - 1,  e2,         t_outside); % up to s
    l3 = thing(region_e - boundary_e - 1,  e3,         t_outside); % from n on
    l4 = thing(region_e - boundary_e - 1,  e4,         t_outside); % entire

    % right rectangle
    r1 = thing(boundary_w - region_w - 1,  e1,         t_outside);
    r2 = thing(boundary_w - region_w - 1,  e2,         t_outside);
    r3 = thing(boundary_w - region_w - 1,  e3,         t_outside);
    r4 = thing(boundary_w - region_w - 1,  e4,         t_outside);

    % top between e and w
    x1 =  n1 + l2 + r2 + s4; % bottom entire after fin_w
    x2 =  n1 + l4 + r2 + s3; % bottom from e on
    x3 =  n1 + l2 + r4 + s2; % bottom from fin_w up to w
    x4 =  n1 + l4 + r4 + s1; % bottom between e and w

    % top up to w
    x5 =  n2 + l1 + r2 + s4;
    x6 =  n2 + l3 + r2 + s3;
    x7 =  n2 + l1 + r4 + s2;
    x8 =  n2 + l3 + r4 + s1;

    % top from e on
    x9 =  n3 + l2 + r1 + s4;
    x10 = n3 + l4 + r1 + s3;
    x11 = n3 + l2 + r3 + s2;
    x12 = n3 + l4 + r3 + s1;

    % top entire
    x13 = n4 + l1 + r1 + s4;
    x14 = n4 + l3 + r1 + s3;
    x15 = n4 + l1 + r3 + s2;
    x16 = n4 + l3 + r3 + s1;
    
    x = [x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 x16];

    outside_drones = min(x);
    
    answer = outside_drones + region_drones;
    
    whole = thing(boundary_s - boundary_n - 1, boundary_w - boundary_e - 1, min(t_region, t_outside));
        
    answer = min(answer, whole);
end