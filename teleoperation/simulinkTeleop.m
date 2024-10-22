%% Teleoperation project 

% Vibration suppression design for virtual compliance control in bilateral
% teleoperation
% Ghini, Cerilli, L'Erario


%% System Parameters

% Master inertia
J_m = 0.0005;
% Slave inertia
J_s = 0.0005;

% Cut-off frequencies 
g1 = 50.0;
g2 = 500.0;

control_set = true; % change to false if we want to simulate the "rigid coupling" controller

if control_set
    K_v = 20.0;
    B_v = (g1+g2)/(g1*g2)*K_v;
    J_v = K_v/(g1*g2)-J_s;
else
    K_v = 100.0;
    B_v = 0.15;
    J_v = 0.0;
end

% Human-env impedance

armL = 0.1;
humanStiff = 200;
humanDamp = 4;

K_h = humanStiff*armL;
B_h = humanDamp*armL;

% Environment inpedance

B_e = 0.01; 
K_e = 1000;

theta_s_contact = -0.0; % change the value of the angle for which the conctact holds.

% Transfer functions

set_1 = tf([1],[(J_s+J_v) B_v K_v])
set_2 = tf([1],[(J_s+J_v)/2 B_v/2 K_v/2])
set_3 = tf([1],[(J_s+J_v)/4 B_v/4 K_v/4])
set_4 = tf([1],[(J_s+J_v)/8 B_v/8 K_v/8])
rigid = tf([1],[0.15 100]);

bode(set_1,set_2, set_3, set_4, rigid);
legend('K_v = 20.0', 'K_v = 10.0', 'K_v = 5.0', 'K_v = 2.5', 'rigid couplng', 'Location','southwest')

%% Start simulation

open_system('teleoperation');
sim('teleoperation');