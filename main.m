ECG_Signal = ecg;
fs = 500;

%--------ECG signal in time domain--------%
N = length(ECG_Signal);
t_end = N./fs;
t = linspace(0,t_end, N);
figure(1)
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

%--------Ideal LBF--------%
fc=0.5;
index = find(fvec<=fc & fvec>=0);
ECG_Signal_f([index]) = 0;
% remove frequencies < -fc (remove negative HSB)
index2 = find(fvec>=(-fc) & fvec<=0);
ECG_Signal_f(index2) = 0;
ECG_Signal_f_mg = abs(ECG_Signal_f);

subplot(3,1,2)
plot(fvec,ECG_Signal_f_mg)
title('ECG signal in frequency domain after LBF at 0.5 HZ')









