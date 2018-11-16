% Matlab code for phase lag index and multiscale entropy analysis
% writen by Sou Nobukawa

s_list=importdata('subjects.txt');

ch_size=16;
factor_size=20;

for i=1:1:size(s_list,1)
   
    EEG_ts=load(strcat('../data/AD/',char(s_list(i)),'/',char(s_list(i)),'.txt'));
   
    pli_matrix=NaN(ch_size,ch_size,5);
    for ch1=1:1:ch_size
       for ch2=ch1+1:1:ch_size
          pli=pli_cal(EEG_ts(:,ch1),EEG_ts(:,ch2));
          pli_matrix(ch1,ch2,:)=pli;
          pli_matrix(ch2,ch1,:)=pli_matrix(ch1,ch2,:);
       end
       %       pli_matrix(ch1,ch2,:)=NaN(1,5);
       SampEn(ch1,:)=msentropy(EEG_ts(:,ch1),2,0.2,factor_size);
   end
   
   save(strcat('pli_',char(s_list(i)),'.mat'),'pli_matrix');
   save(strcat('mse_',char(s_list(i)),'.mat'),'SampEn');   
    
end