P_F=0.01;
P_M=0.01;
P_D=1-P_M;
f_2=-0.025;
mu_1=f_2*(-5.3);
mu_0=0;
sigma=0.0706; %which value????
syms hs lambs Ms
h=0.5*chi2inv(0.99,1)