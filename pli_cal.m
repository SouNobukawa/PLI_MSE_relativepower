
function [pli] = pli_cal(ts1,ts2)

z_ts1=zscore(ts1);
z_ts2=zscore(ts2);

Fl = [2 4 8 13 30];    % High Pass Frequency in Hz
Fh = [4 8 13 30 60];   % Low Pass Frequency in Hz

Fs=200;

for band=1:1:5
    
    passband = [Fl(band)/(Fs/2) Fh(band)/(Fs/2)];
    
    fir_ch1 = fir1 ( floor ( size(z_ts1,1) / 3 ) - 1, passband );
    filtered1 = filtfilt(fir_ch1, 1, double (z_ts1));
    ylp1=hilbert ( filtered1);
    angle1=angle(zscore(ylp1));
    
    fir_ch2 = fir1 ( floor ( size(z_ts2,1) / 3 ) - 1, passband );
    filtered2 = filtfilt(fir_ch2, 1, double (z_ts2));
    ylp2=hilbert ( filtered2);
    angle2=angle(zscore(ylp2));
    
    temp_psi=zeros(10,1);
    for l=1:1:12
        d_angle = angle1 (1+1000*(l-1):(l)*1000) - angle2 (1+1000*(l-1):(l)*1000);
        temp_psi(l) = abs ( mean ( sign ( ( abs ( d_angle ) - pi ) .* d_angle ) ) );
    end
    
    pli(band)=mean(temp_psi);
    
end


end