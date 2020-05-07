function [g_glr, H_glr, mu_1] = glr(z, M, h,  sigma, simTime)

mu_0 = 0;
g_glr=zeros(simTime*250);
H_glr=zeros(simTime*250);
for k=1:simTime*250
   if k<M
       g_glr(k)=(1/(2*M*sigma^2))*sum(z(1:k)-mu_0)^2;
   else 
       g_glr(k)=(1/(2*M*sigma^2))*sum(z(k-M+1:k)-mu_0)^2;
   end
   if g_glr(k)<h
       H_glr(k)=0;
   else
       H_glr(k)=1;
   end
end
