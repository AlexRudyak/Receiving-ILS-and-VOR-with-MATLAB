%% Parameters
s_f = 300e6;                   % sample frequency
ts = 1/s_f;                    % sample time = 3.33*10^-9
t = 0:ts:0.033;                % time vector from 0 to 0.033 (30 Hz period) with ts jumps
s_i = cos(2*pi*30*t);          % create a 30 Hz cos signal
fm = fmmod(s_i,9960,s_f,30,0); % fm modulate 9960 Hz carrier with 30 Hz information
am = ammod(fm,108e6,s_f,0,2);  % am modulate 108 MHz carrier with 9960 fm modulated information

%% Text variables for easier represantaion
signals = ["AM Modulated 108e6", "FM Modulated 9.96KHz Carrier", "Information Signal 30Hz"];
ornt = "horizontal";
pos = "southoutside";
tiledlayout(3,1);
%% Information Tile
nexttile
plot(t,s_i,'r--','LineWidth',2)
axis([0 0.033 -1.2 1.2]);
legend(signals(3),'Orientation',ornt,'Location',pos);
xlabel('Time (s)');
ylabel('Amplitude (v)');
hold off
%% FM Modulation Tile
nexttile
plot(t,fm,'b-');
hold on
plot(t,s_i,'r--','LineWidth',2)
axis([0 0.01 -1.2 1.2]);
legend(signals(2:3),'Orientation',ornt,'Location',pos);
xlabel('Time (s)');
ylabel('Amplitude (v)');
hold off
%% AM Modulation on top of FM Modulation Tile
nexttile
plot(t,am,'g');
hold on
plot(t,fm,'b-');
hold on
plot(t,s_i,'r--','LineWidth',2)
axis([0 0.001 -3 3]);
legend(signals,'Orientation',ornt,'Location',pos);
xlabel('Time (s)');
ylabel('Amplitude (v)');
hold off