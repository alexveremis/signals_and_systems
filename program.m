%03115063
%VEREMIS
%ALEXANDROS


%part A

a=audiorecorder();
record(a,2);
b=getaudiodata(a);
 h = plot(b); % change x-axis from frequency to time.
aH = ancestor(h,'axes');
x = get(h,'XData');
new_x = x ./8000;
new_y = get(h,'Ydata');
delete(h);
plot(aH,new_x,new_y);
energy=zeros(1,39);% creation of a zero vector;
for i=1:39
voi8=b((i-1)*400+1:(i-1)*400+800); %creation of an assistant variable that breaks b-signal in 39 pieces-windows
energy(i) =sum(abs(voi8).^2); %energy of every window-pieces
end
stem(energy);
app=b(5601:6400); % app stands for almost periodic part
plot (app); 
play(a,[5601 6400]);
audiowrite('rec.wav',app,8000); %here we audiowrite the trimmed part to the rec.wav
a51= abs(fft(app)); % a51=fft of app
a52= 20*log10(abs(fft(app))); %a52 = log fft of app

h = plot(a51); % in order to achieve the change of x-axis
aH = ancestor(h,'axes');
x = get(h,'XData');
new_x = x .*10;
new_y = get(h,'Ydata');
delete(h);
plot(aH,new_x,new_y);

h = plot(a52); % in order to achieve the change of x-axis
aH = ancestor(h,'axes');
x = get(h,'XData');
new_x = x .*10;
new_y = get(h,'Ydata');
delete(h);
plot(aH,new_x,new_y);


% part B
num1 = [1 0 0 0 0 0 0 0 0 0 0.5];
den1= [1 0 0 0 0 0 0 0 0 0 0 ];
t = [0:20];
[s,t] =stepz(num1,den1);
stem(s);
t = [0:20];
[h,t] = impz(num1,den1);
stem(h);

%I change the a of the vector num1 manually each time .
zplane(num1,den1);
zplane(num1,den1);
zplane(num1,den1);
roots(num1);%find the roots of num which are the zeros.
roots(den1);%find the roots of denum which are the poles.
num1=zeros(1,2001);
num1(1)=1;
num1(2001)=0.5;
den1=zeros(1,2001);
den1(1)=1;
newapp=filter(num1,den1,app);
plot (newapp);
audiowrite ('newrec.wav',newapp,8000);

 a51= abs(fft(newapp)); %we do this for dft of newapp
a52= 20*log10(abs(fft(newapp)));
 
h = plot(a51); % in order to achieve the change of x-axis
aH = ancestor(h,'axes');
x = get(h,'XData');
new_x = x .*10;
new_y = get(h,'Ydata');
delete(h);
plot(aH,new_x,new_y);
 
h = plot(a52); % in order to achieve the change of x-axis
aH = ancestor(h,'axes');
x = get(h,'XData');
new_x = x .*10;
new_y = get(h,'Ydata');
delete(h);
plot(aH,new_x,new_y);

%part C

function y =resonator(x, resonator_frequency, r, sampling_frequency)
  num2=[1,0,0];
  omega=2*pi*resonator_frequency/sampling_frequency;
  a1=-2*r*cos(omega);
  a2=r*r;
  den2=[1,a1,a2];
  y=filter(num2,den2,x);
end

num2=[1,0,0];
a1=-2*0.95*0;
a2=0.95*0.95;
den2=[1,a1,a2];
aa=impz(num2,den2);
stem(aa);%diagram of the impulse response 
bb=abs(fft(aa));
plot(bb);%diagram of frequency response

%r=0.5


num2=[1,0,0];
a1=-2*0.5*0;
a2=0.5*0.5;
den2=[1,a1,a2];
aa=impz(num2,den2);
stem(aa);
bb=abs(fft(aa));
plot(bb);

%r=1.2
num2=[1,0,0];
a1=-2*1.2*0;
a2=1.2*1.2;
den2=[1,a1,a2];
aa=impz(num2,den2);
stem(aa);
bb=abs(fft(aa));
plot(bb);

%c3

a2=0.95*0.95;
num=[1 0 0 0 0 0 0]  ;
den = [1 0 3*a2  0 3*a2.^2 0 a2.^3];
aa=impz(num,den);
bb=abs(fft(aa));
plot(bb);

%c4
imptrain=zeros(1,200);
for i=1:20
imptrain(i*10)=1;
end % creation of impulse train
y=filter(num,den,imptrain); % the h[n] of the system (*) the impulse train
bb=abs(fft(y)); %dft of y[n] (exit of the system)
plot(bb); 
%in order to here the recordings
 audiowrite ('neo.wav',imptrain,8000);
imptrain2=imptrain;
 for i=1:20
imptrain2(i*10 +1)=-1;
end
audiowrite('neo2.wav',imptrain2,8000);

%part d

num2=[1 0 0];
a1=-2*0.95*0.86;
a2=0.95 *0.95;
den2= [ 1 a1 a2];
aa= impz(num2,den2);
bb=abs(fft(aa));
plot(bb);
bb=bb/20;
plot(bb);

%the end
