%% Processing of Experimental Data 
clear all
close all
clc

%% Import Data
A=importdata('sample.dat');     % read accelerometer output data file
print(A);
D=A.data;

%% Data Visualisation
Time=D(:,1);                    % Time is the first column
a0=D(:,2);                      % For this analysis we take the sceond column of data values only
dt=(Time(2)-Time(1));
Fs=1/dt;                        % Sampling frequency
a0 = a0 - mean(a0);

figure;                      % Plot of acceleration vs time
plot(Time,a0)
ylabel('Acceleration (m/s^2)')
xlabel('Time, t (sec)')

%% Filtering
x0_filtered=smooth(a0);
figure;
plot(Time,x0_filtered)
hold on
plot(Time,a0)
xlabel('Time, t (sec)')
legend('Unfiltered','Filtered')

%% Windowing
signal=x0_filtered;                 % Signal of interest (for which FFT has to be taken)
L=length(signal);
w = hann(L);                        % Hanning window
x1=signal.*w;

%% FFT
X1 = fft(x1)/(L/2);
X1 = X1(1:L/2);
mx1 = abs(X1);                      % Take the magnitude of fft of x

f = linspace(0,Fs/2,L/2);

figure                          % Plotting
plot(f,(mx1),'LineWidth',2);               % Convert Hz to radians
xlabel('Frequency (Hz)')
ylabel('|Amplitude|')
xlim([0 300/(2*pi)])
