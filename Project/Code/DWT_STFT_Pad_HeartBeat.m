clc;clear all;close all
load('ds.mat')
% load('d_12.mat')
% load('pad_a')
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
sen_num = 12;
x_pad = M(sen_num, :);
% save('pad_noman','x_pad')
x_pad = ds(1,:);
% x_pad = ds(1,:);
% x_pad = pad_a(4,:);


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

%%
%--------------------------------------------Show two pictures in the single figure--------------------------------------------%

% subplot(4, 1, 1)
% image(t_pad, f_pad(1:100), abs(y_pad(1:100,:))/max(max(abs(y_pad(1:100,:))))*256)
% colormap(gray(256))
% title('Scaled Gabor Transform for PAD signal')
% xlabel('Time(Sec)')
% ylabel('Frequency(Hz)')
% set(gca,'Ydir','normal') 
% 
% 
% subplot(4, 1, 3)
% image(t_heartbeat,f_heartbeat(1:100),abs(y_heartbeat(1:100,:))/max(max(abs(y_heartbeat(1:100,:))))*256)
% colormap(gray(256))
% title('sgm=1, Scaled Gabor Transform for EKG signal')
% xlabel('Time(Sec)')
% ylabel('Frequency(Hz)')
% set(gca,'Ydir','normal') 

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

% num_frq = 60;
% subplot(4, 1, 2)
% [m,n] = size(abs(y_pad(num_frq,:))/max(max(abs(y_pad(num_frq,:))))*256);
% X = 1:n;
% Y = abs(y_pad(num_frq,:))/max(max(abs(y_pad(num_frq,:))))*256;
% X = X.*0.01;
% plot(X,Y)
% title('Peaks of the pad data')
% xlabel('Time(Sec)')
% ylabel('Power(dB)')


% N1 = 10000;
% Y = abs(fft(Y,N1));
% F1 = [0 : N1 - 1]/N1;
% plot(F1(1:5000),Y(1:5000))
% ylim([0 500000])

% save('Pad_signal.mat','Y');
% [Y_p,X_p] = findpeaks(Y);
% beats = size(Y_p,2);
% beats/150*60

% num_frq = 60;
% subplot(4, 1, 4)
% [m,n] = size(abs(y_heartbeat(num_frq,:))/max(max(abs(y_heartbeat(num_frq,:))))*256);
% X = 1:n;
% Y = abs(y_heartbeat(num_frq,:))/max(max(abs(y_heartbeat(num_frq,:))))*256;
% % [Y,X] = findpeaks(Y,'MinPeakDistance',30,'MinPeakProminence',1);
% X = X.*0.01;
% plot(X,Y)
% title('Peaks of the EKG data')
% xlabel('Time(Sec)')
% ylabel('Power(dB)')




% N1 = 10000;
% Y = abs(fft(Y,N1));
% F1 = [0 : N1 - 1]/N1;
% plot(F1(1:5000),Y(1:5000))
% ylim([0 500000])

% save('Heart_signal.mat','Y');




% num_frq = 20;
% subplot(2, 1, 2)
% [m,n] = size(abs(y_pad(num_frq,:))/max(max(abs(y_pad(num_frq,:))))*256);
% X = 1:n;
% Y = abs(y_pad(num_frq,:))/max(max(abs(y_pad(num_frq,:))))*256;
% plot(X,Y)



%y control
%dwt x axis

%% find peak

% num_frq = 60;
% subplot(2, 1, 1);
% [m,n] = size(abs(y_pad(num_frq,:))/max(max(abs(y_pad(num_frq,:))))*256);
% X = 1:n;
% Y = abs(y_pad(num_frq,:))/max(max(abs(y_pad(num_frq,:))))*256;
% X = X.*0.01;
% [pk,loc] = findpeaks(Y);
% plot(X,Y,X(loc),pk,'r:v')
% title('Peaks of the pad data')
% xlabel('Time(Sec)')
% ylabel('Power(dB)')
% 
% num_frq = 60;
% subplot(2, 1, 2)
% [m,n] = size(abs(y_heartbeat(num_frq,:))/max(max(abs(y_heartbeat(num_frq,:))))*256);
% X = 1:n;
% Y = abs(y_heartbeat(num_frq,:))/max(max(abs(y_heartbeat(num_frq,:))))*256;
% X = X.*0.01;
% [pk,loc] = findpeaks(Y);
% % [pk,loc] = findpeaks(Y,'MinPeakProminence',10);
% plot(X,Y,X(loc),pk,'r:v')
% title('Peaks of the EKG data')
% xlabel('Time(Sec)')
% ylabel('Power(dB)')

%% comparison between two ways to compute heart beat

num_frq = 60;
% subplot(2, 1, 1)
[m,n] = size(abs(y_pad(num_frq,:))/max(max(abs(y_pad(num_frq,:))))*256);
X = 1:n;
Y = abs(y_pad(num_frq,:))/max(max(abs(y_pad(num_frq,:))))*256;
% findpeaks(Y)
[Y,X] = findpeaks(Y);
num = 8;
window = 4000/num;
heartbeathat = zeros(1,num);
for i = 0:num-1
    heartbeathat(:,i+1)=size(X(X>(4000+i*window) & X<(4000+window*(i+1))),2);
end
heartbeathat = heartbeathat.*60/(window/100);
X = 1:num;
plot(heartbeathat)
ylim([0 200])
% title('Prediction')
xlabel('Time')
ylabel('Heartbeat(per min)')
strValues = strtrim(cellstr(num2str(heartbeathat(:),'%d')));
text(X,heartbeathat,strValues,'VerticalAlignment','bottom');
hold on


num_frq = 60;
% subplot(2, 1, 2)
[m,n] = size(abs(y_heartbeat(num_frq,:))/max(max(abs(y_heartbeat(num_frq,:))))*256);
X = 1:n;
Y = abs(y_heartbeat(num_frq,:))/max(max(abs(y_heartbeat(num_frq,:))))*256;
X = X.*0.01;
% findpeaks(Y,'MinPeakProminence',10)
[Y,X] = findpeaks(Y,'MinPeakProminence',10);
num = 8;
window = 4000/num;
heartbeat = zeros(1,num);
for i = 0:num-1
    heartbeat(:,i+1)=size(X(X>(4000+i*window) & X<(4000+window*(i+1))),2);
end
heartbeat = heartbeat.*60/(window/100);
X = 1:num;
plot(heartbeat,'r')
ylim([0 200])
% title('Truth')
legend('prediction','truth')
xlabel('Time')
ylabel('Heartbeat(per min)')
strValues = strtrim(cellstr(num2str(heartbeat(:),'%d')));
text(X,heartbeat,strValues,'VerticalAlignment','bottom');

%% rate


% 
% num_frq = 60;
% % subplot(2, 1, 1)
% [m,n] = size(abs(y_pad(num_frq,:))/max(max(abs(y_pad(num_frq,:))))*256);
% X = 1:n;
% Y = abs(y_pad(num_frq,:))/max(max(abs(y_pad(num_frq,:))))*256;
% % findpeaks(Y)
% [Y,X] = findpeaks(Y);
% num = 8;
% window = 4000/num;
% heartbeathat = zeros(1,num);
% for i = 0:num-1
%     heartbeathat(:,i+1)=size(X(X>(4000+i*window) & X<(4000+window*(i+1))),2);
% end
% heartbeathat = heartbeathat.*60/(window/100);
% X = 1:num;
% % plot(heartbeathat)
% % ylim([0 200])
% % % title('Prediction')
% % xlabel('Time')
% % ylabel('Heartbeat(per min)')
% % strValues = strtrim(cellstr(num2str(heartbeathat(:),'%d')));
% % text(X,heartbeathat,strValues,'VerticalAlignment','bottom');
% % hold on
% 
% 
% num_frq = 60;
% % subplot(2, 1, 2)
% [m,n] = size(abs(y_heartbeat(num_frq,:))/max(max(abs(y_heartbeat(num_frq,:))))*256);
% X = 1:n;
% Y = abs(y_heartbeat(num_frq,:))/max(max(abs(y_heartbeat(num_frq,:))))*256;
% X = X.*0.01;
% % findpeaks(Y,'MinPeakProminence',10)
% [Y,X] = findpeaks(Y,'MinPeakProminence',10);
% num = 8;
% window = 4000/num;
% heartbeat = zeros(1,num);
% for i = 0:num-1
%     heartbeat(:,i+1)=size(X(X>(4000+i*window) & X<(4000+window*(i+1))),2);
% end
% heartbeat = heartbeat.*60/(window/100);
% X = 1:num;
% rate = abs(heartbeathat-heartbeat)./heartbeat;
% plot(rate,'b')
% hold on
% 
% 
% num_frq = 60;
% % subplot(2, 1, 1)
% [m,n] = size(abs(y_pad(num_frq,:))/max(max(abs(y_pad(num_frq,:))))*256);
% X = 1:n;
% Y = abs(y_pad(num_frq,:))/max(max(abs(y_pad(num_frq,:))))*256;
% % findpeaks(Y)
% [Y,X] = findpeaks(Y);
% num = 4;
% window = 4000/num;
% heartbeathat = zeros(1,num);
% for i = 0:num-1
%     heartbeathat(:,i+1)=size(X(X>(4000+i*window) & X<(4000+window*(i+1))),2);
% end
% heartbeathat = heartbeathat.*60/(window/100);
% X = 1:num;
% % plot(heartbeathat)
% % ylim([0 200])
% % % title('Prediction')
% % xlabel('Time')
% % ylabel('Heartbeat(per min)')
% % strValues = strtrim(cellstr(num2str(heartbeathat(:),'%d')));
% % text(X,heartbeathat,strValues,'VerticalAlignment','bottom');
% % hold on
% 
% 
% num_frq = 60;
% % subplot(2, 1, 2)
% [m,n] = size(abs(y_heartbeat(num_frq,:))/max(max(abs(y_heartbeat(num_frq,:))))*256);
% X = 1:n;
% Y = abs(y_heartbeat(num_frq,:))/max(max(abs(y_heartbeat(num_frq,:))))*256;
% X = X.*0.01;
% % findpeaks(Y,'MinPeakProminence',10)
% [Y,X] = findpeaks(Y,'MinPeakProminence',10);
% num = 4;
% window = 4000/num;
% heartbeat = zeros(1,num);
% for i = 0:num-1
%     heartbeat(:,i+1)=size(X(X>(4000+i*window) & X<(4000+window*(i+1))),2);
% end
% heartbeat = heartbeat.*60/(window/100);
% X = 1:num;
% rate = abs(heartbeathat-heartbeat)./heartbeat;
% plot(rate,'r')
% 
% 
% ylim([0 1])
% % title('Truth')
% legend('window size 5','window size 10')
% xlabel('Time')
% ylabel('Error rate')
% strValues = strtrim(cellstr(num2str(rate(:),'%d')));
% text(X,heartbeat,strValues,'VerticalAlignment','bottom');

%% rate drops when size shrink

% rate = zeros(1,8);
% count=1;
% 
% for num = [128 64 32 16 8 4 2 1]
% 
% num_frq = 60;
% % subplot(2, 1, 1)
% [m,n] = size(abs(y_pad(num_frq,:))/max(max(abs(y_pad(num_frq,:))))*256);
% X = 1:n;
% Y = abs(y_pad(num_frq,:))/max(max(abs(y_pad(num_frq,:))))*256;
% % findpeaks(Y)
% [Y,X] = findpeaks(Y);
% % num = 8;
% window = 4000/num;
% heartbeathat = zeros(1,num);
% for i = 0:num-1
%     heartbeathat(:,i+1)=size(X(X>(4000+i*window) & X<(4000+window*(i+1))),2);
% end
% heartbeathat = heartbeathat.*60/(window/100);
% X = 1:num;
% % plot(heartbeathat)
% % ylim([0 200])
% % % title('Prediction')
% % xlabel('Time')
% % ylabel('Heartbeat(per min)')
% % strValues = strtrim(cellstr(num2str(heartbeathat(:),'%d')));
% % text(X,heartbeathat,strValues,'VerticalAlignment','bottom');
% % hold on
% 
% 
% num_frq = 60;
% % subplot(2, 1, 2)
% [m,n] = size(abs(y_heartbeat(num_frq,:))/max(max(abs(y_heartbeat(num_frq,:))))*256);
% X = 1:n;
% Y = abs(y_heartbeat(num_frq,:))/max(max(abs(y_heartbeat(num_frq,:))))*256;
% X = X.*0.01;
% % findpeaks(Y,'MinPeakProminence',10)
% [Y,X] = findpeaks(Y,'MinPeakProminence',10);
% % num = 8;
% window = 4000/num;
% heartbeat = zeros(1,num);
% for i = 0:num-1
%     heartbeat(:,i+1)=size(X(X>(4000+i*window) & X<(4000+window*(i+1))),2);
% end
% heartbeat = heartbeat.*60/(window/100);
% X = 1:num;
% 
% 
% rate(count) = mean(abs(heartbeathat-heartbeat)./heartbeat);
% count = count+1;
% 
% 
% 
% end
% 
% X=ones(1,8)*40./[128 64 32 16 8 4 2 1];
% plot(X,rate)
% ylim([0 1])
% % title('Truth')
% % legend('window size 5','window size 10')
% xlabel('Window Size')
% ylabel('Error Rate')
% strValues = strtrim(cellstr(num2str(rate(:),'%d')));
% text(X,rate,strValues,'VerticalAlignment','bottom');

