%% Road Condition
theta=0; % Road Slope [deg]

%% Vehicle Parameters
% 차량제원
M_veh=2000; % 공차중량[kg]
g=9.81; % 중력가속도[m/s^2]
Lf=1.45; % 앞차축-질량중심 거리[m]
Lr=1.51; % 뒷차축-질량중심 거리[m]
h=0.467; % 지면으로부터 질럄중심까지 높이[m]
r_tire=0.35; % 타이어 실용 반경[m]
G_final=8; % 전륜 종감속 기어비
R_final=4; % 후륜 종감속 기어비

% 주행저항 제원
rho=1.16; % 공기밀도[kg/m^3]
Cd=0.24; % 공기저항계수
Af=2.4; % 전면투영면적[m^2]
f_roll=0.015; % 타이어 롤링저항

%% battery Parameter
Q_bat=28; % Battery Capacity[kWh]
R_int=0.2811; % 배터리 내부 저항[Ohm]
SOC_min=0.4; % 최소 SOC
SOC_max=0.8; % 최대 SOC
SOC_init=0.8; % SOC 초기값
Vt_init=311; % Voltage 초기값
No_cell = 80; % 배터리 셀 수
VOC_SOC = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6 0.7, 0.8, 0.9, 1];
VOC_map = No_cell * [3.19, 3.40, 3.47, 3.59, 3.62, 3.65, 3.69, 3.74, 3.82, 3.89, 3.96];

%% Motor/Generator Parameters
tau_m = 0.015; % 모터 시상수[sec]
tau_f = 0.05; % 마찰 브레이크 시상수[sec]

% 회생 제동 제한
regen_limit_value = [0 0 1 1];
regen_limit_kph = [0 5 10 20];

%% Front 모터 최대토크 및 효율 맵
Tm_max_spd_f = [0 300 419 524 628 733 838 943 1047 1152 1257 1361 1461 1561]*30/pi;
Tm_max_trq_f = [203 203 193 156 129 111 98 85 79 72 65 60 0 0]; 
Pm_max_f = (Tm_max_spd_f*pi/30).*Tm_max_trq_f;

eff_spd_f = [0 105 209 314 419 524 628 733 838 943 1047 1152 1257 1361]*30/pi;
eff_trq_f = [0.0 13.6 27.1 40.7 54.2 67.8 81.4 94.9 108.5 122.0 135.6 149.2 162.7 176.3 189.8 203.4];
eff_map_f = [...
81.3 81.3 82.2 82.0 81.5 81.2 80.4 79.3 80.1 76.8 74.3 73.5 72.0 71.6 70.0 71.1 
81.3 81.3 82.2 82.0 81.5 81.2 80.4 79.3 80.1 76.8 74.3 73.5 72.0 71.6 70.0 71.1 
87.1 87.1 88.3 87.8 87.9 87.9 87.8 87.2 88.0 85.7 84.9 85.8 83.2 82.4 81.5 82.2 
89.3 89.3 90.6 90.3 90.5 90.8 90.6 90.3 91.0 89.3 88.7 88.2 87.4 86.8 86.0 85.7 
90.5 90.5 92.0 91.9 92.3 92.5 92.4 92.1 92.5 91.3 89.7 89.3 88.8 88.3 87.8 85.7 
91.4 91.4 93.0 90.6 91.6 91.9 91.9 91.6 91.2 90.6 90.0 89.2 88.2 88.3 87.8 85.7 
92.2 92.2 92.1 92.6 92.7 92.4 91.8 91.0 91.1 89.0 87.9 89.2 88.2 88.3 87.8 85.7 
94.0 94.0 95.7 95.1 94.2 93.0 91.7 89.9 88.4 89.0 87.9 89.2 88.2 88.3 87.8 85.7 
93.7 93.7 95.6 94.6 93.2 91.5 89.4 87.2 88.4 89.0 87.9 89.2 88.2 88.3 87.8 85.7 
94.5 94.5 95.3 93.8 91.9 89.2 86.4 87.2 88.4 89.0 87.9 89.2 88.2 88.3 87.8 85.7 
94.1 94.1 94.8 92.8 89.0 86.5 86.4 87.2 88.4 89.0 87.9 89.2 88.2 88.3 87.8 85.7 
94.0 94.0 94.2 91.5 87.7 86.5 86.4 87.2 88.4 89.0 87.9 89.2 88.2 88.3 87.8 85.7 
93.9 93.9 93.4 88.8 83.5 86.5 86.4 87.2 88.4 89.0 87.9 89.2 88.2 88.3 87.8 85.7 
93.8 93.8 92.4 87.3 83.5 86.5 86.4 87.2 88.4 89.0 87.9 89.2 88.2 88.3 87.8 85.7];
%% Rear 모터 최대토크 및 효율 맵

Tm_max_spd_r = [0 1230 1300 1500:500:5500 5800 6000];
Tm_max_trq_r = [125 125 117.53 101.86 76.39 61.12 50.93 43.65 38.20 33.95 30.56 27.78 0 0];
Pm_max_r = (Tm_max_spd_r*pi/30).*Tm_max_trq_r;

eff_spd_r = [0 300 500 700 900 1100 1300 1500 1700 1900 2100 2300 2500 2700 3000 3400 3800 4200 4600 5000 5400 5800 6000];
eff_trq_r = [0:5:200]*125/200;
eff_map_r = [...
36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 36.6 
73.0 73.0 73.0 75.0 75.9 75.7 75.7 75.9 75.2 74.9 74.8 73.4 72.1 71.8 70.3 69.3 67.9 67.1 64.8 62.9 66.9 64.1 64.4 61.3 61.3 59.7 58.5 56.4 56.4 56.4 56.4 56.3 56.3 56.3 56.3 56.3 56.3 56.3 56.3 56.3 56.3 
79.2 79.2 79.2 81.6 82.7 82.6 82.8 82.6 82.0 82.0 81.9 81.3 80.6 80.3 79.4 78.7 78.1 76.6 75.1 73.1 73.6 71.2 70.6 76.1 73.8 72.3 69.8 66.5 73.4 71.2 69.8 68.9 70.7 70.5 72.7 73.1 74.2 74.2 74.2 74.2 74.2 
83.0 83.0 83.0 84.5 85.0 86.1 85.9 86.2 86.0 85.2 84.4 84.7 84.1 83.8 84.1 82.8 81.3 81.6 80.0 79.8 78.6 78.6 75.9 78.4 77.6 76.1 75.0 75.0 72.6 77.7 75.6 77.8 76.6 77.4 78.1 78.1 78.1 77.9 77.9 77.9 77.9 
83.2 83.2 83.2 85.8 86.7 87.8 89.7 87.9 88.3 88.1 87.5 87.8 86.4 86.1 86.0 84.1 84.9 83.1 83.3 83.0 81.5 81.3 82.2 81.2 80.6 79.9 79.8 78.7 76.4 76.1 81.9 83.0 83.3 82.8 83.8 84.5 84.0 84.0 84.4 84.3 84.3 
84.3 84.3 84.3 86.4 87.5 88.7 89.5 88.9 89.4 89.6 89.2 89.8 89.2 89.3 88.4 88.4 87.3 86.4 85.6 85.7 85.0 82.8 83.3 86.9 85.9 85.0 83.6 81.7 82.7 80.1 83.6 84.1 84.4 84.5 84.6 84.9 84.8 84.7 84.7 84.7 84.7 
85.0 85.0 85.0 86.9 87.9 89.0 90.0 89.2 89.9 91.0 89.7 90.6 91.0 89.4 89.5 90.2 89.0 88.1 88.0 87.4 87.2 86.1 85.0 86.4 85.7 86.9 85.1 84.7 83.4 82.7 84.8 85.5 85.5 85.6 85.7 85.9 85.9 85.9 85.9 85.9 85.9 
85.3 85.3 85.3 88.2 89.1 90.5 90.2 90.8 91.1 91.1 91.2 91.4 91.4 91.1 90.7 90.9 90.5 90.5 89.9 89.6 88.3 88.1 87.0 86.6 87.2 87.9 86.9 85.3 85.5 85.7 84.6 84.6 84.6 84.6 84.6 84.6 84.6 84.6 84.6 84.6 84.6 
86.2 86.2 86.2 88.9 89.6 90.6 91.4 90.9 91.4 91.0 91.4 91.6 91.4 91.9 91.8 91.2 91.5 90.9 90.6 90.2 90.1 89.4 88.9 89.2 88.3 87.9 87.5 87.3 87.3 87.3 87.3 87.3 87.3 87.3 87.3 87.3 87.3 87.3 87.3 87.3 87.3 
86.7 86.7 86.7 88.6 89.8 90.7 91.3 91.7 91.9 92.1 92.7 92.4 92.4 93.2 92.8 92.6 92.1 91.8 91.6 91.0 90.8 90.2 89.8 89.8 88.8 88.8 88.8 88.8 88.8 88.8 88.8 88.8 88.8 88.8 88.8 88.8 88.8 88.8 88.8 88.8 88.8 
86.6 86.6 86.6 89.1 89.8 91.6 91.7 91.7 93.0 92.6 92.6 93.4 92.8 93.4 93.8 92.4 92.8 92.4 92.1 91.5 91.0 90.5 89.1 89.1 89.1 89.1 89.1 89.1 89.1 89.1 89.1 89.1 89.1 89.1 89.1 89.1 89.1 89.1 89.1 89.1 89.1 
88.6 88.6 88.6 90.3 91.8 92.5 93.0 93.0 94.0 94.2 94.1 94.7 94.0 93.9 92.9 92.9 92.6 92.2 90.8 89.7 90.7 90.7 90.7 90.7 90.7 90.7 90.7 90.7 90.7 90.7 90.7 90.7 90.7 90.7 90.7 90.7 90.7 90.7 90.7 90.7 90.7 
88.6 88.6 88.6 90.6 91.6 92.7 93.0 93.4 93.7 93.6 93.7 93.1 92.7 92.0 91.4 91.0 89.7 89.5 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 
87.9 87.9 87.9 90.9 92.7 92.2 93.3 93.5 93.4 93.1 93.0 92.9 92.6 91.6 91.0 90.0 89.3 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 
87.9 87.9 87.9 89.8 92.1 92.2 92.6 93.4 93.0 92.9 92.9 91.9 91.2 90.1 89.3 89.3 89.3 89.3 89.3 89.3 89.3 89.3 89.3 89.3 89.3 89.3 89.3 89.3 89.3 89.3 89.3 89.3 89.3 89.3 89.3 89.3 89.3 89.3 89.3 89.3 89.3 
88.7 88.7 88.7 91.4 92.2 92.4 92.5 92.5 91.9 91.5 90.8 89.5 89.2 89.2 89.2 89.2 89.2 89.2 89.2 89.2 89.2 89.2 89.2 89.2 89.2 89.2 89.2 89.2 89.2 89.2 89.2 89.2 89.2 89.2 89.2 89.2 89.2 89.2 89.2 89.2 89.2 
87.6 87.6 87.6 89.7 90.6 90.4 90.4 91.3 90.2 89.0 88.2 88.3 88.3 88.3 88.3 88.3 88.3 88.3 88.3 88.3 88.3 88.3 88.3 88.3 88.3 88.3 88.3 88.3 88.3 88.3 88.3 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 88.2 
85.2 85.2 85.2 88.2 89.1 89.9 90.2 89.7 89.0 87.4 87.4 87.4 87.4 87.4 87.4 87.4 87.4 87.4 87.4 87.4 87.4 87.4 87.4 87.4 87.4 87.4 87.4 87.4 87.4 87.4 87.4 87.4 87.4 87.4 87.4 87.4 87.4 87.4 87.4 87.4 87.4 
82.7 82.7 82.7 86.5 87.5 87.6 89.5 88.8 87.9 87.9 87.9 87.9 87.9 87.9 87.9 87.9 87.9 87.9 87.9 87.9 87.9 87.9 87.9 87.9 87.9 87.9 87.9 87.9 87.9 87.9 87.9 87.9 87.9 87.9 87.9 87.9 87.9 87.9 87.9 87.9 87.9 
83.5 83.5 83.5 86.8 88.2 87.9 87.9 85.7 85.7 85.7 85.7 85.7 85.7 85.7 85.7 85.7 85.7 85.7 85.7 85.7 85.7 85.7 85.7 85.7 85.7 85.7 85.7 85.7 85.7 85.7 85.7 85.7 85.7 85.7 85.7 85.7 85.7 85.7 85.7 85.7 85.7 
82.0 82.0 82.0 85.8 87.6 87.7 86.5 86.5 86.5 86.5 86.5 86.5 86.5 86.5 86.5 86.5 86.5 86.5 86.5 86.5 86.5 86.5 86.5 86.5 86.5 86.5 86.5 86.5 86.5 86.5 86.5 86.6 86.6 86.6 86.6 86.6 86.6 86.6 86.6 86.6 86.6 
81.3 81.3 81.3 83.2 86.4 86.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 87.7 
83.0 83.0 83.0 86.0 86.7 86.4 86.4 86.4 86.4 86.4 86.4 86.4 86.4 86.4 86.4 86.4 86.4 86.4 86.4 86.4 86.4 86.4 86.4 86.4 86.4 86.4 86.4 86.4 86.4 86.4 86.4 86.5 86.5 86.5 86.5 86.5 86.5 86.5 86.5 86.5 86.5];
%% Motor Efficiency Map

% [spd,trq]=meshgrid(eff_spd,eff_trq);
% levels=80:1:100;
% contour(spd',trq',eff_map,levels,'showtext','on')
% hold
% plot(Tm_max_spd,Tm_max_trq)
% title('Motor Efficiency')
% xlabel('Motor Speed[rpm]')
% ylabel('Motor Torque[Nm]')
