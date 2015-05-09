function y=Gabor1(x,tau,t,f,sgm)   % Use Method 2 
dtau=tau(2)-tau(1);   % df=dt
df=f(2)-f(1);
N=round(1/dtau/df);
B=1.9143/sgm^.5;
Q=floor(B/dtau);
n=round(t/dtau);                       % t -> n
n1=n-round(min(tau)/dtau)+1;
ln=length(n);
m=round(f/df)';                       % f -> m
lm=length(m);                         % lm: number of points on f-axis 
m0=mod(m,N)+1;
x1=[zeros(Q,1);x.';zeros(Q,1)];
gs=exp(-pi*dtau^2*[-Q:Q]'.^2*sgm)*sgm^0.25*dtau;
y=zeros(lm,ln);
m1=j*2*pi/N*m;
Q2=2*Q;
for a=1:ln
    x1a=fft(x1(n1(a):Q2+n1(a)).*gs,N);
    y(1:lm,a)=[x1a(m0).*exp(m1*(Q-n(a)))];
end

