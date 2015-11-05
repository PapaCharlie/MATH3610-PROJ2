m = xdim;
n = ydim;
t = 15;
t_cpk = 20;
t_fin = 5;

cpk_n = floor(0.3 * ydim);
cpk_s = floor(0.7 * ydim);
cpk_e = floor(0.4 * xdim);
cpk_w = floor(0.6 * xdim);
cpk_drones = thing(cpk_s - cpk_n + 1, cpk_w - cpk_e + 1, t_cpk);

fin_w = floor(0.1 * xdim);
fin_drones = thing(fin_w, n, t_fin);

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

d1 = cpk_w - cpk_e + 1;
d2 = cpk_w;
d3 = m - cpk_e + 1;
d4 = m;

e1 = cpk_s - cpk_n + 1;
e2 = cpk_s;
e3 = n - cpk_n + 1;
e4 = n;

% north rectangle
n1 = thing(d1,         cpk_n,      t); % between e and w
n2 = thing(d2,         cpk_n,      t); % up to w
n3 = thing(d3,         cpk_n,      t); % from e on
n4 = thing(d4,         cpk_n,      t); % entire

% south rectangle
s1 = thing(d1,         n - cpk_s,  t);
s2 = thing(d2,         n - cpk_s,  t);
s3 = thing(d3,         n - cpk_s,  t);
s4 = thing(d4,         n - cpk_s,  t);

% left rectangle
l1 = thing(cpk_e - 1,  e1,         t); % between n and s
l2 = thing(cpk_e - 1,  e2,         t); % up to s
l3 = thing(cpk_e - 1,  e3,         t); % from n on
l4 = thing(cpk_e - 1,  e4,         t); % entire

% right rectangle
r1 = thing(m - cpk_w,  e1,         t);
r2 = thing(m - cpk_w,  e2,         t);
r3 = thing(m - cpk_w,  e3,         t);
r4 = thing(m - cpk_w,  e4,         t);
 
% top between e and w
x1 =  n1 + l2 + r2 + s4; % bottom entire
x2 =  n1 + l4 + r2 + s3; % bottom from e on
x3 =  n1 + l2 + r4 + s2; % bottom up to w
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
answer = min(min(x) + cpk_drones, thing(m,n,min(t,t_cpk)))