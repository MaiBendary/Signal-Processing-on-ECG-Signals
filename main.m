ECG_Signal = ecg;
ECG1 = ECG_Signal;
fs = 500;

%% Step1
%--------ECG signal in time domain--------%
N = length(ECG_Signal);
t_end = N./fs;
t = linspace(0,t_end, N);
figure(1)
subplot(3,1,1)
plot(t,ECG_Signal)
title('ECG signal in time domain')


%--------ECG signal in frequency domain--------%
ECG_Signal_f=fftshift(fft(ECG_Signal));
ECG_Signal_f_mg=abs(ECG_Signal_f);

fvec=linspace(-fs/2,fs/2,N);

figure(2)
subplot(3,1,1)
plot(fvec,ECG_Signal_f_mg)
title('ECG signal in frequency domain')

%--------Ideal HBF--------%

n = N/fs;
left_band = round((fs/2-0.5)*n);
right_band = (N-left_band+1);
ECG_Signal_f([left_band:right_band]) = 0;


% plot the Filtered signal in time domain
ECG_Signal_t = real(ifft(ifftshift(ECG_Signal_f)));
figure(1)
subplot(3,1,2)
plot(t,ECG_Signal_t)
title('ECG signal in time domain after HPF filter at 0.5 HZ')

% plot the Filtered signal in frequency
Xmg=abs(ECG_Signal_f);
fvec=linspace(-fs/2,fs/2,N);
figure(2)
subplot(3,1,2)
plot(fvec,Xmg)
title('ECG signal in frequency domain after HPF filter at 0.5 HZ')


%% Step2
%----------------------------Step 2----------------------------%
%-----Notch Filter at 50 HZ-----%

fc=50; 
index = find(round(fvec) == fc);
ECG_Signal_f([index]) = 0;
ECG_Signal_f_mg = abs(ECG_Signal_f);
figure(2)
subplot(3,1,3)
plot(fvec,ECG_Signal_f_mg)
title('ECG signal in frequency domain after Notch filter at 50 HZ')
ECG_Signal_t = real(ifft(ifftshift(ECG_Signal_f)));
ECG2 = ECG_Signal_t;
figure(1)
subplot(3,1,3)
plot(t,ECG_Signal_t)
title('ECG signal in time domain after Notch filter at 50 HZ')

%% Step3
%-------------------------------Step 3--------------------------%
%--------Increasing SNR--------%
ECG3_20 = LBF(ECG_Signal_f, 20, 1);
ECG3_40 = LBF(ECG_Signal_f, 40, 2);
ECG3_60 = LBF(ECG_Signal_f, 60, 3);


%% Step4
%-------------------------------Step 4--------------------------%
%--------Autocorrelation--------%
ECG3_40_acf = xcorr2(ECG3_40);
ECG3_40_heart_rate = Heart_rate(ECG3_40_acf)

ECG2_acf = xcorr2(ECG2);
ECG2_heart_rate = Heart_rate(ECG2_acf)

ECG1_acf = xcorr2(ECG1);
ECG1_heart_rate = Heart_rate(ECG1_acf)

tau = [-N+1:N-1];

figure(5)
subplot(3,1,1)
plot(tau, ECG1_acf)
title('Autocorrelation of unprocessed ECG signal')

figure(5)
subplot(3,1,2)
plot(tau, ECG2_acf)
title('Autocorrelation of notched ECG signal')

figure(5)
subplot(3,1,3)
plot(tau, ECG3_40_acf)
title('Autocorrelation of 50 HZ LPF ECG signal')


%% Step5
%-------------------------------Step 5--------------------------%
ECG3_40 = pan_tompkin(ECG3_40,fs,1);
ECG2 = pan_tompkin(ECG2,fs,1);
ECG1 = pan_tompkin(ECG1,fs,1);

