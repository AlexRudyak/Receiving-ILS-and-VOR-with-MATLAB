fs = 300e6;
ts = 1/fs;
run_time = 0.03;
t = 0:ts:run_time;

%% AM (rotation)
Aam = 0.33;
phi = pi;
xam = Aam*cos(2*pi*30*t - phi);

%% Baseband signal 30 Hz
Afm_bb = 0.33;
xfm_bb = Afm_bb*cos(2*pi*30*t);

%% FM 9960Hz with 30Hz
Afm = 0.33;
kfm = 0.33;
xfm = Afm*cos(2*pi*9960*t + kfm.*(Afm_bb/60*pi*sin(2*pi*30*t)));

%% Final VOR Signal equation 
kam1 = 0.33;
kam2 = 0.33;
zvor = (1+kam1.*xam+kam2.*xfm).*cos(2*pi*108e6*t);


% %% Receiver
% raw_rx = zvor.*cos(2*pi*108e6*t);
% rxlpf = angle(lowpass(raw_rx,10e3,300e6));
% %rxlpf_bb = angle(rxlpf.*cos(2*pi*9960*t));
%% Plots
% Trasnmit
figure(1);
plot(t,zvor);
hold on 
plot(t,xam,'--g','LineWidth',2);    
hold on
plot(t,xfm_bb,'--r','LineWidth',2);
legend('X_{vor}','X_{variable}','X_{reference}');
title('VOR trasmit');
hold off

% % Receive
% figure(2);
% %plot (t,raw_rx);
% hold on
% plot (t,rxlpf);
% hold on
% %plot (t, rxlpf_bb);
% axis([0 run_time -2 4])
% hold off

