%% Parameters
f_s = 240000;                              % Sampling frequency
t_s = 1/f_s;                               % Sampling period
run_time = 1;                              % Untill what time to run
t = 0:t_s:run_time-t_s;                    % Time vector with ts (1/fs) steps
% samp_num = (run_time-t_s)/t_s;           % number of samples
% nfft = 4096;                             % number of points in FFT (2^x)
% freq_bins = f_s/nfft;                    % by dividing the sampling freq with number of points we get the number of 
%                                          % frequecy bins in the fft plot - scalar number
%% 90 Hz
a_90 = 0.2;                                % 90 Hz Amplitude
f_90 = 90;                                 % 90 Hz Frequency
phi_90 = 0;                                % 90 Hz Phase
t_90 = a_90*cos(2*pi*f_90*t + phi_90);     % Make a signal equation of Acos(2pift+phi)
%% 150 Hz
a_150 = 0.2;                               % 150 Hz Amplitude
f_150 = 150;                               % 150 Hz Frequency
phi_150 = 0;                               % 150 Hz Phase
t_150 = a_150*cos(2*pi*f_150*t + phi_150); % Make a signal equation of Acos(2pift+phi)
%% Carrier 
a_c = 1;                                   % Carrier Amplitude
f_c = 109e6;                               % Carrier Frequency
phi_c = 0;                                 % Carrier phase
t_c = a_c*cos(2*pi*f_c*t + phi_c);         % Define carrier signal
%% Modulated Signal
%a_mod = (t_info + 3) .* cos(2*pi*f_c*t + phi_c); % add DC compenent for modulation
m = 0.2;
phi_diff = 0;
a_sbo = 1;
a_mod_csb = a_c*cos(2*pi*f_c*t).*(1+m*(cos(2*pi*f_90*t)+cos(2*pi*f_150*t)));
a_mod_sbo = a_sbo*cos(2*pi*f_c*t).*(cos(2*pi*f_90*t + phi_diff) + cos(2*pi*f_150*t + phi_diff));
%% General Parameters
tiledlayout(2,2)
%% Plot 90 Hz and 150 Hz tones signal - for visualisation
nexttile
plot(t,t_90)                               % Plot the signal
hold on                                    % Hold for the next plot
plot(t,t_150)                              % Plot the signal
legend('90 Hz','150 Hz')                   % Naming the signals
axis([0 0.03 -0.5 0.5])                    % Change axis for comfort
hold off                                   % Stop holding the plots
%% Plot the information signal
nexttile
t_info = t_90 + t_150;                     % Make the information signal sum of 2 signals
plot(t,t_info)                             % plot the information
axis([0 0.1 -2.5 2.5])                     % change axis for comfort
legend('information signal')               % add legend
hold off                                   % stop holding for next figure
%% Plot Carrier
nexttile               % next tile 
plot(t,t_c)                                % plot the carrier
axis([0 0.0002 -1.1 1.1])                  % change axis for comfort
legend('carrier')                          % add legsend
%% Plot the Modulated csb and sbo signals
nexttile                                   % advance in figure count
plot(t,a_mod_csb)                          % plot the modulated signal
hold on
plot (t,a_mod_sbo,'-')                     % plot the second signal
axis([0 0.08 -2 2])                        % change axis for comfort
legend('Modulated Signal CSB','Modulated Signal SBO')



