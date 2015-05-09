input = importdata('heartbeatSensor_modified2.txt');
intvl = 20;
%9000 3min

% tao = 3000;

% sizeToRender = size(input(5000:8000),2);
% sizeToRenderArray = 1:intvl:(sizeToRender*intvl);
% figure,plot(sizeToRenderArray,input(5000:8000))
% hold
% xlabel('Time (millisec)');ylabel('Amplitude'); 
% title('Original Pulse')
% 

% Heartbeat should be repeated
% [x,c] = cxcorr(input(5000:8000),input(8000:11000)); %x lag
% sizeToRender = size(c,2);
% sizeToRenderArray = 1:intvl:(sizeToRender*intvl);
% figure,plot(sizeToRenderArray,c)
% xlabel('Time (millisec)');ylabel('Amplitude'); 
% title('Autocorrelation Pulse')

% e = fft(input(5000:8000)); 
% f = fft(input(8000:11000));
% g = e.*conj(f);
% h = ifft(g);
% sizeToRender = size(h,2);
% sizeToRenderArray = 1:intvl:(sizeToRender*intvl);
% figure,plot(sizeToRenderArray,c)
% xlabel('Time (millisec)');ylabel('Amplitude'); 
% title('Autocorrelation Pulse')

% 
% butter
% cheby1
% cheby2
% ellip
% equiripple
% ifir
% kaiserwin
% multistage

% d = fdesign.lowpass('Fp,Fst,Ap,Ast',0.01,0.025,1,60);
% Hd = design(d,'equiripple');
% y = filter(Hd,input(5000:11000));
% sizeToRender = size(y,2);
% sizeToRenderArray = 1:intvl:(sizeToRender*intvl);
% figure,plot(sizeToRenderArray,y)
% xlabel('Time (millisec)');ylabel('Amplitude'); 
% title('low filtered Pulse')



% e = fft(input(5000:8000)); 
% f = fft(input(8000:11000));
% g = e.*conj(f);
% h = ifft(g);
% 
% d = fdesign.lowpass('Fp,Fst,Ap,Ast',0.15,0.25,1,60);
% Hd = design(d,'equiripple');
% y = filter(Hd,h);
% 
% sizeToRender = size(y,2);
% sizeToRenderArray = 1:intvl:(sizeToRender*intvl);
% figure,plot(sizeToRenderArray,y)
% xlabel('Time (millisec)');ylabel('Amplitude'); 
% title('low filtered autocorrelation Pulse')


%PCA
fs = 100;
%input(5000:8000)
N = 6000;
n = 0:N-1;
t = n/fs;
y = fft(input(5001:11000),N);
mag = abs(y);
f = n*fs/N;
figure,plot(f,mag)

