%Given a fixed delta size, this porgram finds the error associated with
%different sample rates
clear all
del=0.2; %delta size of 0.2
A=1; % input signal has amplitude of 1
t=0:2*pi/1000:2*pi; % input signal has 1000 samples 
x=A*sin(t);
% max_length=length(x)*k; 
modula_sig=0; %modulated signal
points =[];
err =[];
p=0;


for p= 1:1000 %modulate the signal at different sampling frequency
    
k=floor((length(x)-1)/p);%factor that samples input signal at different sampling rates

        for i=1:p
            if modula_sig(i)<=x(k*i)
                modula_sig(i+1)=modula_sig(i)+del;
            else
                modula_sig(i+1)=modula_sig(i)-del;
            end
        end
     err(1,i) = ((x(k*i)-modula_sig(i)).^2)/p; %compare modulated signal to original
     points(i,1)= p;
end
plot(points,err)
xlabel('# of samples');
ylabel('Error');
title('Error vs # of samples')


    
