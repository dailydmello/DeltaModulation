%This program takes an audio file as input and delta modulates the signal
%at the optimal delta
clear all;
[sig,Fs] = audioread('modula.wav'); %read audio file
A=max(sig); %find max amplituded of signal
delta= 0:0.001:A(1); %run thorugh delta values from 0 to the max amplitude(just to set an upper limit)
modula_sig=0; %modulated signal
points=[];
optimal_del=0; %optimal delta value

for j = 1:numel(delta) %modulate signal at different deltas
    for i=1:length(sig)
        if modula_sig(i)<=sig(i)
            modula_sig(i+1)=modula_sig(i)+delta(j);
        else
            modula_sig(i+1)=modula_sig(i)-delta(j);
        end
       
        er(1,i) = (sig(i,1)-modula_sig(i)).^2; 
        points(i,1) = i;
    end
    
    err(j,1)= sum(er)/length(sig); %calculate mean square error at specific delta
end

[min_error,index]=min(err);
optimal_del = delta(index);
fprintf('The minimum error is %d\n',min_error*100);
fprintf('The optimal delta is %d\n',optimal_del);


for i=1:length(sig)  %modulate signal at optimal delta
    if modula_sig(i)<=sig(i)
        d=1;
        modula_sig(i+1)=modula_sig(i)+optimal_del;
    else
        d=0;
        modula_sig(i+1)=modula_sig(i)-optimal_del;
    end
end

subplot(2,2,4)     %plot Error vs Delta Size
plot(delta,err*100)
xlabel('Delta Size');
ylabel('Error %');
title('Error vs Delta Size')

subplot(2,2,3)       % plot original signal
plot(sig)
title('Original Signal')

subplot(2,2,[1 2])       % plot modulated signal
plot(sig)
hold on
stairs(modula_sig)
hold off
title('Delta Modulated Signal at Optimal Step Size')
legend('Modulated Signal','Original Signal')

sound(modula_sig,Fs);


