fs = 100e3;
ts = 1/fs;
t = 0:ts:0.002;

x = 0.5*cos(2*pi*1000*t);
c = 2*cos(2*pi*10e3*t);
fm = 2*cos(2*pi*10e3*t + 10*x);

tiledlayout(2,2)
nexttile
plot (t, 0.25*x,'k-','LineWidth',1);
set(gca,'fontname','Times New Roman');
title('X_m - Base Signal')
legend('X_m = A_mcos(2\pif_mt + \phi_m)','Location','northeast');
axis([0 0.002 -0.6 0.6])
xlabel('Time (s)');
ylabel('Amplitude (v)');
nexttile
plot (t, c, 'k');
set(gca,'fontname','Times New Roman');
title('X_c - Carrier Signal')
legend('X_c = A_ccos(2\pif_ct + \phi_c)','Location','northeast');
axis([0 0.002 -2.7 2.7])
xlabel('Time (s)');
ylabel('Amplitude (v)');
nexttile([1 2])
plot (t, fm, 'k');
title('X_{FM} - Frequency Modulated Signal')
set(gca,'fontname','Times New Roman');
hold on
plot (t, x,'k--','LineWidth',1);
hold off
legend('X_{FM} = A_ccos(2\pif_ct + X_mt)','X_m','Location','northeast')
axis([0 0.002 -2.7 2.7])
xlabel('Time (s)');
ylabel('Amplitude (v)');