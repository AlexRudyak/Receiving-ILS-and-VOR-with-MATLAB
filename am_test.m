fs = 100e3;
ts = 1/fs;
t = 0:ts:0.2;

x = 0.5*cos(2*pi*200*t);
c = 2*cos(2*pi*10e3*t);
am = (2 + x).*cos(2*pi*10000*t);

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
plot (t, am, 'k');
title('X_{AM} - Amplitude Modulated Signal')
set(gca,'fontname','Times New Roman');
hold on
plot (t, 2+x,'k--','LineWidth',1);
hold on
plot (t, -2-x,'k--','LineWidth',1);
legend('X_{AM} = [A_c + X_m(t)]cos(2\pif_ct + \phi_c)','X_m','Location','northeast')
axis([0 0.002 -2.7 2.7])
xlabel('Time (s)');
ylabel('Amplitude (v)');