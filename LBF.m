function [ECG_Signal_t] = LBF(ECG_Signal_f, fc, Plot_Number)
    N = length(ECG_Signal_f);
    fs = 500;
    t_end = N./fs;
    t = linspace(0,t_end, N);
    n = N/fs;
    left_band = round((fs/2-fc)*n);
    right_band = (N-left_band+1);
    ECG_Signal_f([1:left_band right_band:N]) = 0;


    % plot the Filtered signal in time domain
    ECG_Signal_t = real(ifft(ifftshift(ECG_Signal_f)));
    figure(3)
    subplot(3,1,Plot_Number)
    plot(t,ECG_Signal_t)
    title("ECG signal in time domain after LBF at " + fc + " HZ")

    % plot the Filtered signal in frequency
    Xmg=abs(ECG_Signal_f);
    fvec=linspace(-fs/2,fs/2,N);
    figure(4)
    subplot(3,1,Plot_Number)
    plot(fvec,Xmg)
    title("ECG signal in frequency domain after LBF at " + fc + " HZ")  