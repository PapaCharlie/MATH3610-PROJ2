m = 20;
n = 150;
t = 15;
t_cpk = 20;
t_fin = 5;

cpk_n = floor(0.3 * ydim);
cpk_s = floor(0.7 * ydim);
cpk_e = floor(0.4 * xdim);
cpk_w = floor(0.6 * xdim);

fin_w = floor(0.1 * xdim);
fin_drones = thing(fin_w, n, t_fin);

g_n = floor(0.1 * ydim);
g_s = floor(0.2 * ydim);

%                   -------
%                   |     |
%                   |     |
%  cpk_e      cpk_w -------
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


min_drones = thing(m - fin_w, n, min([t_univ, t_fin, t_outside]));
for i=univ_s:cpk_n
    region_n = univ_n;
    region_s = univ_s;
    region_e = univ_e;
    region_w = univ_w;
    
    boundary_n = 0;
    boundary_s = i;
    boundary_e = fin_w;
    boundary_w = m + 1;
    
    region = [region_n region_s region_e region_w];
    boundary = [boundary_n boundary_s boundary_e boundary_w];
    
    univ_drones = dronesAround(region, boundary, t_univ, t_outside);
    
    region_n = cpk_n;
    region_s = cpk_s;
    region_e = cpk_e;
    region_w = cpk_w;
    
    boundary_n = i;
    boundary_s = n + 1;
    boundary_e = fin_w;
    boundary_w = m + 1;
    
    region = [region_n region_s region_e region_w];
    boundary = [boundary_n boundary_s boundary_e boundary_w];
    
    cpk_drones = dronesAround(region, boundary, t_cpk, t_outside);
    
    min_drones = min(univ_drones + cpk_drones, min_drones);
end

answer