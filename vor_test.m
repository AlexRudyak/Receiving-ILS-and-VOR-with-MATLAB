fs = 300e6;
ts = 1/fs;
run_time = 0.03;
t = 0:ts:run_time;

Aam = 0.33;
phi = 3;
xam = Aam*cos(2*pi*30*t - phi);

Afm_bb = 0.33;
xfm_bb = Afm_bb*cos(2*pi*30*t);

Afm = 0.33;
kfm = 0.33;
xfm = Afm*cos(2*pi*9960*t + kfm.*(Afm_bb/60*pi*sin(2*pi*30*t)));

kam1 = 0.33;
kam2 = 0.33;
zvor = (1+kam1.*xam+kam2.*xfm).*cos(2*pi*108e6*t);

plot(t,zvor);
hold on 
plot(t,xam,'--g','LineWidth',2);
hold on
plot(t,xfm_bb,'--r','LineWidth',2);
legend('X_V_o_r','X_V_a_r','X_F_M_b_b');
hold off