clc;clear all;close all
%--------------------------------------------HeartBeat Data Process----------------------------------------------% 

fs_heartbeat = 50;
fd_heartbeat = fopen('HeartBeatData.txt','r');
formatSpec = '%d\n';
A = fscanf(fd_heartbeat,formatSpec);
fclose(fd_heartbeat);


x_heartbeat = A(:,1).';

for n = 1 : length(x_heartbeat)
    tau_heartbeat(n) = (n-1)/fs_heartbeat;
end

t_heartbeat = 0:0.01:max(tau_heartbeat);
f_heartbeat = 0:0.05:100;
sgm_heartbeat = 5;

%----------------------------------------------Pad Data Process--------------------------------------------------% 


fs_pad = 100;
M = dlmread('PadData_Z.txt', '\t'); 

% [1 2 3 4 5 6 7 9 10 11 12 13 14 15 16 20 21 22 23 24]
%Choose the sensor number
sen_num = 19;
x_pad = M(sen_num, :);


for n = 1 : length(x_pad)
    tau_pad(n) = (n-1)/fs_pad;
end

t_pad = 0:0.01:max(tau_pad);
f_pad = 0:0.05:100;
sgm_pad = 5;

% Tricky Part : Must capture pad data first
if (length(t_pad) > length(t_heartbeat))
    x_pad = x_pad((length(t_pad)-length(t_heartbeat))+1:length(t_pad));    % Ignore former data
    t_pad = t_pad(1:length(t_heartbeat));
    tau_pad = tau_pad(1:length(t_heartbeat));
else
    t_heartbeat = t_heartbeat(1:length(t_pad));
end



y_heartbeat = Gabor1(x_heartbeat,tau_heartbeat,t_heartbeat,f_heartbeat,sgm_heartbeat);
y_pad = Gabor1(x_pad, tau_pad, t_pad, f_pad, sgm_pad);


%--------------------------------------------Show two pictures in the single figure--------------------------------------------%

subplot(4, 1, 1)
image(t_pad, f_pad(1:100), abs(y_pad(1:100,:))/max(max(abs(y_pad(1:100,:))))*256)
colormap(gray(256))
title('Scaled Gabor Transform for PAD signal')
xlabel('Time(Sec)')
ylabel('Frequency(Hz)')
set(gca,'Ydir','normal') 


subplot(4, 1, 3)
image(t_heartbeat,f_heartbeat(1:100),abs(y_heartbeat(1:100,:))/max(max(abs(y_heartbeat(1:100,:))))*256)
colormap(gray(256))
title('sgm=1, Scaled Gabor Transform for EKG signal')
xlabel('Time(Sec)')
ylabel('Frequency(Hz)')
set(gca,'Ydir','normal') 

%--------------------------------------------Show peaks in the single figure--------------------------------------------%


% num_frq = 100;
% subplot(2, 1, 1)
% [m,n] = size(abs(y_pad(num_frq,:))/max(max(abs(y_pad(num_frq,:))))*256);
% X = 1:n;
% Y = abs(y_pad(num_frq,:))/max(max(abs(y_pad(num_frq,:))))*256;
% plot(X,Y)

% num_frq = 20;
% subplot(3, 1, 1)
% [m,n] = size(abs(y_pad(num_frq,:))/max(max(abs(y_pad(num_frq,:))))*256);
% X = 1:n;
% Y = abs(y_pad(num_frq,:))/max(max(abs(y_pad(num_frq,:))))*256;
% [Y,X] = findpeaks(Y,'MinPeakDistance',30,'MinPeakProminence',1);
% plot(X,Y)

num_frq = 60;
subplot(4, 1, 2)
[m,n] = size(abs(y_pad(num_frq,:))/max(max(abs(y_pad(num_frq,:))))*256);
X = 1:n;
Y = abs(y_pad(num_frq,:))/max(max(abs(y_pad(num_frq,:))))*256;
[Y,X] = findpeaks(Y);
X = X.*0.01;
plot(X,Y)

beats = size(Y,2);
beats/150*60

num_frq = 60;
subplot(4, 1, 4)
[m,n] = size(abs(y_heartbeat(num_frq,:))/max(max(abs(y_heartbeat(num_frq,:))))*256);
X = 1:n;
X = X.*0.01;
Y = abs(y_heartbeat(num_frq,:))/max(max(abs(y_heartbeat(num_frq,:))))*256;
% [Y,X] = findpeaks(Y,'MinPeakDistance',30,'MinPeakProminence',1);
plot(X,Y)




% num_frq = 20;
% subplot(2, 1, 2)
% [m,n] = size(abs(y_pad(num_frq,:))/max(max(abs(y_pad(num_frq,:))))*256);
% X = 1:n;
% Y = abs(y_pad(num_frq,:))/max(max(abs(y_pad(num_frq,:))))*256;
% plot(X,Y)



%%




