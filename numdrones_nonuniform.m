parameters

m = xdim;
n = ydim;
tfac = 10;
t = 15*tfac;
t_outside = t;
t_cpk = 20*tfac;
t_fin = 5*tfac;
t_univ = 5*tfac;

cpk_n = 59;
cpk_s = 110;
cpk_e = 10;
cpk_w = 19;

fin_n = 20;
fin_drones = block(m, fin_n, t_fin);

univ_n = 1;
univ_s = 6;
univ_e = 110;
univ_w = 122;

%
%  cpk_e      cpk_w 
%    |          |    
% --------------------
% |                  |
% |                  |- cpk_n
% |                  |
% |                  |
% |                  |
% |                  |
% |                  |- cpk_s
% |                  |
% --------------------

min_drones = block(m, n - fin_n, min(t_univ, t_outside));
for i=univ_s:(cpk_n+1)
    region_n = univ_n;
    region_s = univ_s;
    region_e = univ_e;
    region_w = univ_w;
    
    boundary_n = 0;
    boundary_s = i;
    boundary_e = 0;
    boundary_w = m + 1;
    
    region = [region_n region_s region_e region_w];
    boundary = [boundary_n boundary_s boundary_e boundary_w];
    
    univ_drones = dronesAround(region, boundary, t_univ, t_outside);
    
    region_n = cpk_n;
    region_s = cpk_s;
    region_e = cpk_e;
    region_w = cpk_w;
    
    boundary_n = i-1;
    boundary_s = fin_w;
    boundary_e = 0;
    boundary_w = m + 1;
    
    region = [region_n region_s region_e region_w];
    boundary = [boundary_n boundary_s boundary_e boundary_w];
    
    cpk_drones = dronesAround(region, boundary, t_cpk, t_outside);
    
    min_drones = min(univ_drones + cpk_drones, min_drones);
end

min_drones = min(min_drones + fin_drones, block(m, n, min([t_univ, t_fin, t_outside])));

answer = min_drones