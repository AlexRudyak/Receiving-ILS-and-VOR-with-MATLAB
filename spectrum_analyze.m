% lab17_ex_IQ_DFT.m
 clear all; close all;

%m=128; cm_plasma=plasma(m); cm_inferno=inferno(m); % color maps for gray printing
%cm = plasma;

% Read recorded IQ signal - choose one
% FileName = ’SDRSharp_DABRadio_229069kHz_IQ.wav’; T=1; demod=0; % DAB Radio signal
% FileName = ’SDRSharp_FMRadio_101600kHz_IQ.wav’; T=5; demod=1; % FM Radio signal
% FileName = ’SDRSharp_NanoSat_146000kHz_IQ.wav’; T=0; demod=2; % Nano Satellite
FileName = 'SDRSharp_20210209_101834Z_108000000Hz_IQ.wav'; T=5; demod=3; % VOR airplane
% FileName = ’SDRWeb_Unknown_3671.9kHz.wav’; T=0; demod=4; % speech from WebSDR

inf = audioinfo(FileName), pause % what is ‘‘inside’’
fs = inf.SampleRate; % sampling rate
if(T==0) [x,fs] = audioread(FileName); % read the whole signal
else [x,fs] = audioread(FileName,[1,T*fs]); % read only T seconds
end %
whos, pause % what is in the memory
Nx = length(x), % signal length

% Reconstruct the complex-value IQ data, if necessary add Q=0
[dummy,M] = size(x);
if(M==2) x = x(:,1) - j*x(:,2); else x = x(1:Nx,1) + j*zeros(Nx,1); end
nd = 1:2500;
figure(1); plot(nd,real(x(nd)),'bo-',nd,imag(x(nd)),'r*--'); xlabel('n'); grid;
title('I(n) = (o) BLUE/solid | Q(n)= (*) RED/dashed'); pause

% Parameters - lengths of FFT and STFT, central signal sample
Nc = floor( Nx/2 ); Nfft = min(2^17,2*Nc); Nstft = 512;
% Power Spectral Density (PSD) of the signal
n = Nc-Nfft/2+1 : Nc+Nfft/2; % indexes of signal samples
df = fs/Nfft; % df - step in frequency
f = df * (0 : 1 : Nfft-1); % frequency axis [ 0, fs ]
fshift = df * (-Nfft/2 : 1 : Nfft/2-1); % frequency axis [ -fs/2, fs/2 ]
w = kaiser(Nfft,10); % window function used
X = fft( x(n) .* w ); % DFT of windowed signal
P = 2*X.*conj(X) / (fs*sum(w.^2)); % Power Spectral Density (dB/Hz)
Pshift = fftshift( P ); % circularly shifted PSD

% Parameters for Short Time Fourier Transform (STFT) of the signal
N = Nstft; df = fs/N; ff = df*(0:1:N-1); ffshift = df*(-N/2:1:N/2-1);

figure(2)
subplot(211); plot(f,10*log10(abs(P))); xlabel('f(HZ)'); ylabel('(dB/Hz)')
axis tight; grid; title('PSD for frequencies [0-fs)');
subplot(212); spectrogram(x(n),kaiser(Nstft,10),Nstft-Nstft/4,ff,fs);

figure(3)
subplot(211); plot(fshift,10*log10(abs(Pshift))); xlabel('f (HZ)'); ylabel('(dB/Hz)')
axis tight; grid; title('PSD for frequencies [-fs/2, fs/2)');
subplot(212); spectrogram(x(n),kaiser(Nstft,10),Nstft-Nstft/4,ffshift,fs);
subplot(111);

fc = 2.9285e+5;

if(demod==3) % airplane azimuth decoding using VOR signal

M = 501; M2=(M-1)/2; % filter length
fam = 25000; dt=1/fam; % frequency width of AM modulation around fc
f1 = fc-fam/2; f2 = fc+fam/2; % Band-Pass filter h design
h = cfirpm(M-1,[-fs/2 (f1-df) (f1+df) (f2-df) (f2+df) fs/2]/(fs/2),@bandpass);
x = conv(x,h); x=x(M:end-M+1); % Band-pass filtration of VOR
x = sqrt( real(x).*real(x) + imag(x).*imag(x) ); % AM demodulation
x = decimate(x,round(fs/fam)); % [U,D] = rat(fs/fam); x = resample( x, U, D );
x = x - mean(x); % mean subtraction

if(0) % only for verification test
N = length(x); t=dt*(0:length(x)-1);
x = sin(2*pi*30*t) + cos(2*pi*(9960*t-480/(2*pi*30)*cos(2*pi*30*t)));
x = x';
end
xc = x;

% Low-pass filtration of 30 Hz azimuth signal
hLP30 = fir1(M-1,50/(fam/2),'low'); % design of filter coefficients
x = conv(x,hLP30); x = x(M2+1:end-M2); % filtering
x = x - mean(x);
x_azim = x(2:end-1)/max(x); % 2,-1 due to finst computation

% Extraction of 30 Hz signal with reference phase
hBP10k = fir1(M-1,[9000,11000]/(fam/2),'bandpass'); % BP filter design
x = conv(xc,hBP10k); x=x(M2+1:end-M2); % separation of FM component
x = unwrap( angle ( hilbert(x) )); % angle calculation
x = x(3:end)-x(1:end-2); % 3-point difference
x = (1/(2*pi))*x/(2*dt); % f instantaneous
x = conv(x,hLP30); x=x(M2+1:end-M2); % LP filtration / denoising
x = x - mean(x); % remove mean value
x_ref = x/max(x); % normalize amplitude to 1

% Phase shift estimation
phi_inst = angle( hilbert(x_azim).*conj(hilbert(x_ref)) );
phi_estim = mean( phi_inst ), pause

end
