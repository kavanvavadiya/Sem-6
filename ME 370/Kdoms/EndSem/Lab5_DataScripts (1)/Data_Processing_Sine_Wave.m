%% Data Processing using MATLAB
% First clear all the variables in the workspace

clear all
close all
clc
%% Generating a Sine Wave: A$\sin$($\Omega \;$t)

A = 10;            %Amplitude
f = 10;                %Frequency(Hz)
Omega = 2*pi*f;        %Frequency(rad/s)

Fs = 30*f;   %Sampling Frequency
dt = 1/Fs;                           %Time Step
Time = 0:dt:pi/3;                      %Time Vector

F = A*sin(Omega*Time);%+A/2*sin(2.5*Omega*Time);               %Function

figure;
plot(Time,F,'-','Marker','.','MarkerSize',20,'LineWidth',2)
axis([0 Time(end) -1.5*A 1.5*A])
xlabel('Time')
ylabel('F')
grid on
title('Sampled signal')

%% FFT without windowing
L=length(F);
X1 = fft(F)/(L/2);
X1 = X1(1:L/2);
mx1 = abs(X1);                      % Take the magnitude of fft of x

f = linspace(0,Fs/2,L/2);

figure;                                            % Plotting
plot(f,(mx1),'LineWidth',2);               % Convert Hz to radians
xlabel('Frequency (Hz)')
ylabel('|Amplitude|')
title('FFT without Windowing')
xlim([0 Fs/2])

%% Windowing

L=length(F);
window = "Hann"; % Type the name of the windowing function here

if window=="No"
    w = ones(L,1);
elseif window=="Hann"
    w = hann(L);
elseif window=="Hamming"
    w = hamming(L);
elseif window=="Welch"
    j = (0:L-1)';
    w = 1 - (2*j/L - 1).^2;
elseif window=="Tukey"
    w = tukeywin(L,0.5);
end

figure
plot(w,'LineWidth',2)
title(window)

%% FFT

x1=F.*w';
figure;
plot(Time,x1)
xlabel('Time')
title('Signal after Windowing')

X1 = fft(x1)/(L/2);
X1 = X1(1:L/2);
mx1 = abs(X1);                      % Take the magnitude of fft of x

f = linspace(0,Fs/2,L/2);

figure;                                            % Plotting
plot(f,(mx1),'LineWidth',2);               % Convert Hz to radians
xlabel('Frequency (Hz)')
ylabel('|Amplitude|')
title('FFT After Windowing')
xlim([0 Fs/2])

%% Introducing Artificial Noise and Filtering

Fnoise = F + randn(size(F));      %adding artificial noise

figure;
plot(Time,Fnoise,'LineWidth',2)
Ffiltered = smooth(Fnoise);         %Filtering:moving average (low pass)
hold on
plot(Time,Ffiltered,'r','LineWidth',2)
xlabel('Time (s)')
legend('Unfiltered','Filtered')

x1=Fnoise.*w';
figure;
plot(Time,x1)
xlabel('Time')
title('Signal with noise after windowing')

X1 = fft(x1)/(L/2);
X1 = X1(1:L/2);
mx1 = abs(X1);                      % Take the magnitude of fft of x

f = linspace(0,Fs/2,L/2);

figure;                                        % Plotting
plot(f,(mx1),'LineWidth',2);           % Convert Hz to radians
xlabel('Frequency (Hz)')
ylabel('|Amplitude|')
xlim([0 Fs/2])
title('FFT of Filtered Signal with Noise')