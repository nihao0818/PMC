function y=lowp(x,f1,f3,rp,rs,Fs)
%????
%?????????????????????????????????
%??f1,f3?????? Fs/2
%x:?????????
% f 1???????
% f 3???????
%rp??????DB???
%rs??????DB???
%FS???x?????
% rp=0.1;rs=30;%?????DB???????DB?
% Fs=2000;%???
%
wp=2*pi*f1/Fs;
ws=2*pi*f3/Fs;
% ??????????
[n,wn]=cheb1ord(wp/pi,ws/pi,rp,rs);
[bz1,az1]=cheby1(n,rp,wp/pi);
%??????????
[h,w]=freqz(bz1,az1,256,Fs);
h=20*log10(abs(h));
figure;plot(w,h);title('???????????');grid on;
%
y=filter(bz1,az1,x);%???x????????y
end

