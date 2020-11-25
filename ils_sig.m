%% Parameters
fs = 240000;     % Sampling frequency
ts = 1/fs;       % Sampling period
st = 1;          % Untill what time to run
t = 0:ts:st-ts;  % Time vector with ts (1/fs) steps
sn = (st-ts)/ts; % number of samples
%% 90 Hz
a_90 = 1;        % 90 Hz Amplitude
f_90 = 90;       % 90 Hz Frequency
phi_90 = 0;      % 90 Hz Phase
%% 150 Hz
a_150 = 1;       % 150 Hz Amplitude
f_150 = 150;     % 150 Hz Frequency
phi_150 = 0;     % 150 Hz Phase
%% Carrier 
a_c = 1;         % Carrier Amplitude
f_c = 109e6;     % Carrier Frequency
phi_c = 0;       % Carrier phase
%% define 90 Hz tone signal
t_90 = a_90*cos(2*pi*f_90*t + phi_90);     % Make a signal equation of Acos(2pift+phi)
figure('name','90 Hz and 150 Hz');         % Name the figure
plot(t,t_90)                               % Plot the signal
axis([0 0.05 -1.1 1.1])                    % Change axis for comfort
hold on                                    % Hold for the next plot
%% define 150 Hz tone signal
t_150 = a_150*cos(2*pi*f_150*t + phi_150); % Make a signal equation of Acos(2pift+phi)
plot(t,t_150)                              % Plot the signal
legend('90 Hz','150 Hz')                   % Naming the signals
hold off                                   % Stop holding the plots
%% Define the information signal
figure('name','Information')               % Name the figure
t_info = t_90 + t_150;                     % Make the information signal sum of 2 signals
plot(t,t_info)                             % plot the information
axis([0 0.1 -2.5 2.5])                     % change axis for comfort
legend('information signal')               % add legend
hold off                                   % stop holding for next figure
%% Define Carrier
t_c = a_c*cos(2*pi*f_c*t + phi_c);         % Define carrier signal
figure('name','Carrier')                   % name the figure
plot(t,t_c)                                % plot the carrier
axis([0 0.0002 -1.1 1.1])                  % change axis for comfort
legend('carrier')                          % add legend
%% Modulate the signals
a_mod = (t_c + 2) .* t_info;               % add DC compenent for modulation 
figure('name','Modulated')                 % name the figure
plot(t,a_mod)                              % plot the modulated signal
axis([0 0.05 -6 6])                        % change axis for comfort


