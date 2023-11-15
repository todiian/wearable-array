% Script to test XDR-126 64-channel HIFU array with the Verasonics Vantage
% 256 research platform. The scripts transmits one single focused beam at
% the position defined by 'TX.FocalPtMm'. The temporal parameters of the
% ultrasound pulse are defined in the 'FUS' structure.
% 
% Author: tommaso.diianni@ucsf.edu
% Date: 11/09/2023

clear;
close all;

%% Define transducer

soundSpeed = 1540;

Trans = XDR126();

%% Define HIFU parameters and structures

% Define Resource structure
Resource.Parameters.numTransmit = Trans.numelements;  % number of transmit channels.
Resource.Parameters.numRcvChannels = 0;  % number of receive channels.
Resource.Parameters.speedOfSound = soundSpeed;
Resource.Parameters.Connector = 1;          % HIFU transducer should be on Connector 1
Resource.Parameters.speedCorrectionFactor = 1.0;
Resource.Parameters.verbose = 1;
Resource.Parameters.initializeOnly = 0;
Resource.Parameters.simulateMode = 0;

Resource.HIFU.externalHifuPwr = 1;
Resource.HIFU.extPwrComPortID = 'COM3';
Resource.HIFU.psType = 'QPX600DP'; % set to 'QPX600DP' to match supply being used

% FUS burst parameters
FUS.PD = 80;            % Pulse duration (ms)
FUS.IPI = 480;          % Inter-pulse interval (ms)
FUS.BD = 5e3;           % Burst duration (ms)
FUS.IBI = 10e3;         % Inter-burst interval (ms)
FUS.nPulsesInBurst = FUS.BD/FUS.IPI;    % n pulses in single burst

% define single pulse
TW(1).type = 'parametric';
C = round(FUS.PD*1e3*Trans.frequency*2);
TW(1).Parameters = [1,.67,C,1];

% define transmit parameters
TX = struct('waveform', 1, ...
    'Apod', zeros(1,Trans.numelements), ...
    'Delay', zeros(1,Trans.numelements));

apod = ones(1,Trans.numelements);
TX.Apod = apod;

% Focal position in the transducer coordinate space
TX.FocalPtMm = [3 0 15];
TX.Delay = computeTXDelays(TX);

% Plot transmit delays
figure(1);
plot(TX.Delay);
hold on;

%% Extenal power supply and TPC
TPCprof = 5;
TPC(TPCprof).maxHighVoltage = Trans.maxHighVoltage;

%% Specify SeqControl structure arrays

TTNP = 1;   % time to next pulse
SeqControl(TTNP).command = 'timeToNextAcq';
SeqControl(TTNP).argument = (FUS.IPI-FUS.PD)*1e3;   % microseconds

TTNB = 2;   % time to next burst
SeqControl(TTNB).command = 'timeToNextAcq';
SeqControl(TTNB).argument = (FUS.IBI-FUS.BD)*1e3;   % microseconds

RTNMatlab = 3;
SeqControl(RTNMatlab).command = 'returnToMatlab';

JUMP = 4;
SeqControl(JUMP).command = 'jump';
SeqControl(JUMP).argument = 3;
SeqControl(JUMP).condition = 'ExitAfterJump';

nsc = 5;

%% Event Sequence
n = 1;

% Set TPC profile 5
Event(n).info = 'select TPC profile 1';
Event(n).tx = 0;
Event(n).rcv = 0;
Event(n).recon = 0;
Event(n).process = 0;
Event(n).seqControl = nsc; % set TPC profile command.
n = n+1;
SeqControl(nsc).command = 'setTPCProfile';
SeqControl(nsc).argument = TPCprof;
SeqControl(nsc).condition = 'immediate';
nsc = nsc + 1;

% noop to allow time for TPC profile transition
Event(n).info = 'noop delay';
Event(n).tx = 0;
Event(n).rcv = 0;
Event(n).recon = 0;
Event(n).process = 0;
Event(n).seqControl = nsc; 
n = n+1;
SeqControl(nsc).command = 'noop';
SeqControl(nsc).argument = 5e3;     % value*200nsec
nsc = nsc + 1;

for k=1:FUS.nPulsesInBurst
    % Send FUS pulse
    Event(n).info = 'FUS Pulse';
    Event(n).tx = 1;
    Event(n).rcv = 0;
    Event(n).recon = 0;
    Event(n).process = 0;
    Event(n).seqControl = [TTNP,nsc];
    n = n+1;
    SeqControl(nsc).command = 'triggerOut';
    nsc = nsc + 1;
end

% wait until next 
Event(n).info = 'Time to next burst';
Event(n).tx = 0;
Event(n).rcv = 0;
Event(n).recon = 0;
Event(n).process = 0;
Event(n).seqControl = [TTNB];
n = n+1;

% Jump to first event
Event(n).info = 'Jump';
Event(n).tx = 0;
Event(n).rcv = 0;
Event(n).recon = 0;
Event(n).process = 0;
Event(n).seqControl = JUMP;

%% Save structures to a .mat file.
filepath = '.';
filename = sprintf('%s/%s.mat',filepath,'SetupXDR126');
save(filename);       % Save sequence parameters. The .mat file 
                        % is used for execution by VSX
fprintf('filename = ''%s''; VSX\n',filename);

return
