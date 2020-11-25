%% Parameters
fs = 240000;    % sampling frequency
ts = 1/fs;      % sampling period
st = 0.025;     % untill what to run
t = 0:ts:st-ts; % 1024 time steps
%% 90 Hz
a90 = 0.2;      % 90 Hz Amplitude
f90 = 90;       % 90 Hz Frequency
phi90 = 0;      % 90 Hz Phase
%% 150 Hz
a150 = 0.2;     % 150 Hz Amplitude
f150 = 150;     % 150 Hz Frequency
phi150 = 0;     % 150 Hz Phase
%% define 90 Hz tone signal
t90 = a90*cos(2*pi*f90*t + phi90);     % Make a signal equain of Acos(2pift+phi)
plot(t,t90)                            % Plot the signal
ylim([-0.3 0.3])                       % Change y axis for comfort
hold on                                % Hold for the next plot
%% define 150 Hz tone signal
t150 = a150*cos(2*pi*f150*t + phi150); % Make a signal equain of Acos(2pift+phi)
plot(t,t150)                           % Plot the signal
hold off                               % Stop holding the plots




