function [Trans] = XDR126()

% define speed of sound used to calculate wavelength - m/s
soundSpeed = 1540;

Trans.name = 'custom';          % Scanhd name
Trans.frequency = 1;            % center frequency in megahertz
mmToWavelength = 1e-3/(soundSpeed/(Trans.frequency*1e6));

Trans.type = 2;                 % 0=Lin(y=z=0),1=CrvdLn(y=0),2=2D,3=annular
Trans.units = 'wavelengths';    % 'mm' or 'wavelengths'
Trans.numelements = 64;         % number of transducer elements
Trans.elementWidth = 1.3*mmToWavelength;
Trans.spacingMm = 0;
Trans.spacing = 0;
Trans.radiusMm = 15;
Trans.radius = Trans.radiusMm*mmToWavelength;
Trans.lenscorrection = 0;
Trans.maxHighVoltage = 25;
Trans.impedance = 110;
Trans.connType = 1;

% difference between geometric focus in transducer coordinates (15 mm) and 
% focal distance from holder surface (8.18 mm - 2 mm)
Trans.geomFocusShift = 8.82;

% Define element sensitivity function (standard as per Verasonics
% documentation)
Theta = (-pi/2:pi/100:pi/2);
X = Trans.elementWidth*pi*sin(Theta);
Trans.ElementSens = abs(cos(Theta).*(sin(X)./X));

% Define element positions (in mm) and orientation (in radians) [x,y,z,az,el]
% Provided by Sonic Concepts relative to geometric focus.
ElementPos(1,:) = [0.612954     -0.811963   -14.96546       0   0];
ElementPos(2,:) = [1.108221     1.457402    -14.887842      0   0];
ElementPos(3,:) = [-0.838213    1.320942    -14.918194      0   0];
ElementPos(4,:) = [-1.71615     -0.37369    -14.896818      0   0];
ElementPos(5,:) = [0.196736     -2.614485   -14.769081      0   0];
ElementPos(6,:) = [2.580597     0.407703    -14.770724      0   0];
ElementPos(7,:) = [2.020597     3.018731    -14.553503      0   0];
ElementPos(8,:) = [-0.562153    3.200004    -14.643905      0   0];

ElementPos(9,:) = [-3.486611    0.659395    -14.574249      0   0];
ElementPos(10,:) = [-2.858911   -1.886526   -14.603686      0   0];
ElementPos(11,:) = [-0.82833    -4.129127   -14.396673      0   0];
ElementPos(12,:) = [1.070153    -4.355227   -14.313866      0   0];
ElementPos(13,:) = [2.463996    -3.157438   -14.455425      0   0];
ElementPos(14,:) = [3.179195    -1.370661   -14.594999      0   0];
ElementPos(15,:) = [5.108475    0.75888     -14.082883      0   0];
ElementPos(16,:) = [4.471692    2.755112    -14.050385      0   0];

ElementPos(17,:) = [1.56074     4.788118    -14.129332      0   0];
ElementPos(18,:) = [-0.411926   4.941986    -14.156521      0   0];
ElementPos(19,:) = [-2.963845   4.221246    -14.085336      0   0];
ElementPos(20,:) = [-3.989303   2.577586    -14.228194      0   0];
ElementPos(21,:) = [-4.752229   -0.896858   -14.199013      0   0];
ElementPos(22,:) = [-4.066546   -3.149829   -14.090486      0   0];
ElementPos(23,:) = [-3.089712   -4.691943   -13.908248      0   0];
ElementPos(24,:) = [2.720132    -5.344787   -13.748968      0   0];

ElementPos(25,:) = [4.222221    -3.541133   -13.951101      0   0];
ElementPos(26,:) = [4.882565    -1.780939   -14.07085       0   0];
ElementPos(27,:) = [6.368048    -0.76447    -13.559629      0   0];
ElementPos(28,:) = [6.907987    1.549269    -13.224201      0   0];
ElementPos(29,:) = [6.068806    3.20719     -13.337298      0   0];
ElementPos(30,:) = [3.807605    4.768612    -13.702645      0   0];
ElementPos(31,:) = [2.115095    6.606181    -13.299803      0   0];
ElementPos(32,:) = [-0.27981    6.782717    -13.375966      0   0];

ElementPos(33,:) = [-3.153622   6.058338    -13.35482       0   0];
ElementPos(34,:) = [-4.874972   5.338273    -13.142964      0   0];
ElementPos(35,:) = [-6.661773   3.230974    -13.045367      0   0];
ElementPos(36,:) = [-5.862964   1.738523    -13.696832      0   0];
ElementPos(37,:) = [-7.126283   -0.493975   -13.189848      0   0];
ElementPos(38,:) = [-5.760536   -2.835717   -13.556361      0   0];
ElementPos(39,:) = [-5.147041   -4.583948   -13.32274       0   0];
ElementPos(40,:) = [-0.272266   -6.706952   -13.414271      0   0];

ElementPos(41,:) = [1.344383    -7.447562   -12.950925      0   0];
ElementPos(42,:) = [3.21371     -7.331564   -12.685434      0   0];
ElementPos(43,:) = [5.406187    -6.379978   -12.452671      0   0];
ElementPos(44,:) = [6.575801    -4.696301   -12.637389      0   0];
ElementPos(45,:) = [6.303792    -2.917009   -13.294858      0   0];
ElementPos(46,:) = [7.965439    -2.282735   -12.503635      0   0];
ElementPos(47,:) = [8.631365    0.517736    -12.256896      0   0];
ElementPos(48,:) = [7.786841    2.97127     -12.471434      0   0];

ElementPos(49,:) = [6.929386    4.872662    -12.379046      0   0];
ElementPos(50,:) = [4.769217    6.806814    -12.486867      0   0];
ElementPos(51,:) = [2.78156     8.174322    -12.265536      0   0];
ElementPos(52,:) = [0.714547    8.619511    -12.255344      0   0];
ElementPos(53,:) = [-1.19088    8.504049    -12.298901      0   0];
ElementPos(54,:) = [-2.96236    8.120571    -12.258905      0   0];
ElementPos(55,:) = [-4.634674   7.262273    -12.279218      0   0];
ElementPos(56,:) = [-6.536873   5.603289    -12.283014      0   0];

ElementPos(57,:) = [-8.337557   2.078747    -12.294875      0   0];
ElementPos(58,:) = [-8.591121   -1.007234   -12.254718      0   0];
ElementPos(59,:) = [-7.735242   -2.727135   -12.559011      0   0];
ElementPos(60,:) = [-7.185077   -4.662344   -12.314106      0   0];
ElementPos(61,:) = [-5.62424    -6.192103   -12.450935      0   0];
ElementPos(62,:) = [-2.938223   -6.857107   -13.013337      0   0];
ElementPos(63,:) = [-1.999832   -8.292368   -12.338448      0   0];
ElementPos(64,:) = [-0.107346   -8.403483   -12.424571      0   0];

% Shift origin by radius of curvature
ElementPos(:,3) = ElementPos(:,3)+Trans.radiusMm;

% Align axes with marker (bulge) on transducer housing
theta = 30.65;
theta = theta/180*pi;
rotMatrix = [cos(theta) sin(theta); -sin(theta) cos(theta)];

ElementPos(:,1:2) = ElementPos(:,1:2)*rotMatrix;

% Assign connector I/O channels to elements in the transducer.
% Row index is the element number. Value for a given row index is the
% connector I/O channel the element is connected to.
Trans.ConnectorES(1,:) = 33;
Trans.ConnectorES(2,:) = 64;
Trans.ConnectorES(3,:) = 1;
Trans.ConnectorES(4,:) = 32;
Trans.ConnectorES(5,:) = 42;
Trans.ConnectorES(6,:) = 63;
Trans.ConnectorES(7,:) = 55;
Trans.ConnectorES(8,:) = 6;

Trans.ConnectorES(9,:) = 31;
Trans.ConnectorES(10,:) = 24;
Trans.ConnectorES(11,:) = 43;
Trans.ConnectorES(12,:) = 41;
Trans.ConnectorES(13,:) = 34;
Trans.ConnectorES(14,:) = 62;
Trans.ConnectorES(15,:) = 56;
Trans.ConnectorES(16,:) = 54;

Trans.ConnectorES(17,:) = 13;
Trans.ConnectorES(18,:) = 7;
Trans.ConnectorES(19,:) = 5;
Trans.ConnectorES(20,:) = 2;
Trans.ConnectorES(21,:) = 25;
Trans.ConnectorES(22,:) = 23;
Trans.ConnectorES(23,:) = 18;
Trans.ConnectorES(24,:) = 40;

Trans.ConnectorES(25,:) = 35;
Trans.ConnectorES(26,:) = 61;
Trans.ConnectorES(27,:) = 60;
Trans.ConnectorES(28,:) = 57;
Trans.ConnectorES(29,:) = 53;
Trans.ConnectorES(30,:) = 50;
Trans.ConnectorES(31,:) = 14;
Trans.ConnectorES(32,:) = 12;

Trans.ConnectorES(33,:) = 8;
Trans.ConnectorES(34,:) = 4;
Trans.ConnectorES(35,:) = 29;
Trans.ConnectorES(36,:) = 30;
Trans.ConnectorES(37,:) = 26;
Trans.ConnectorES(38,:) = 22;
Trans.ConnectorES(39,:) = 19;
Trans.ConnectorES(40,:) = 44;

Trans.ConnectorES(41,:) = 45;
Trans.ConnectorES(42,:) = 39;
Trans.ConnectorES(43,:) = 38;
Trans.ConnectorES(44,:) = 37;
Trans.ConnectorES(45,:) = 36;
Trans.ConnectorES(46,:) = 59;
Trans.ConnectorES(47,:) = 58;
Trans.ConnectorES(48,:) = 52;

Trans.ConnectorES(49,:) = 51;
Trans.ConnectorES(50,:) = 49;
Trans.ConnectorES(51,:) = 16;
Trans.ConnectorES(52,:) = 15;
Trans.ConnectorES(53,:) = 11;
Trans.ConnectorES(54,:) = 10;
Trans.ConnectorES(55,:) = 9;
Trans.ConnectorES(56,:) = 3;

Trans.ConnectorES(57,:) = 28;
Trans.ConnectorES(58,:) = 27;
Trans.ConnectorES(59,:) = 21;
Trans.ConnectorES(60,:) = 20;
Trans.ConnectorES(61,:) = 17;
Trans.ConnectorES(62,:) = 48;
Trans.ConnectorES(63,:) = 47;
Trans.ConnectorES(64,:) = 46;

% Calculate azimuth and elevation angles
x0 = ElementPos(:,1);
y0 = ElementPos(:,2);
z0 = ElementPos(:,3)-Trans.radiusMm;
azAngle = -(pi/2-atan2(z0,x0));
elAngle = pi/2-atan2(z0,-y0);

ElementPosWvlt = ElementPos*mmToWavelength;

ElementPosWvlt(:,4) = azAngle;
ElementPosWvlt(:,5) = elAngle;

Trans.ElementPos = ElementPosWvlt;

end

