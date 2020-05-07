function    ARL_design_Q6(mu_1, mu_0, sigma_r_min, sigma_r_max, h_min, h_max,T_D,T_F,h_sol)
%
%   function to calculate time to detect and mean time between false alarms
%   using the log-likelihood ratio and the CUSUM detector. 
%   The function
%   plots results for h in the range h_min to h_max
%   and for sigma_r in the range sigma_r_min to sigma_r_max.
%
%   assumptions: 
%   - mean value of residual changes after af fault
%   - the variance of residual is unchanged after the fault
%   - noise on the residual is white 
%
%   parameters:
%
%   mu_1    assumed mean value of residual after fault
%   mu_0    mean value of residual in normal condition
%   sigma_r_min  inf root mean square (square root of variance) for residual
%   sigma_2_max  sup of the same
%   h_min   infumum value of the threshold h
%   h_max   supremum of the threshold h
%   
%   Method: page 245 Eq. 6.133 and exmple 6.12 (p 241) in 
%   Diagnosis and Fault-tolerant Control, 2nd edition, Springer, 2006 by 
%   Blanke, Kinnaert, Lunze and Staroswiecki.
%
%   Implemented February 2010 by Mogens Blanke
%
% example:
% ARL_design(1, 0, 0.3, 0.9, 2, 20)

makeplot = 1;
Ns = 3; % number of points to step in sigma_r
sigma_r = linspace(sigma_r_min, sigma_r_max, Ns);
Nh = 125; % number of points to step in h
h = linspace(h_min, h_max, Nh);

    signo = (abs(mu_1 - mu_0)./sigma_r); 
    signosq = signo.^2;
    mu_s_0 = - 0.5*signosq;
    mu_s_1 = + 0.5*signosq;
    sigma_s = signo;

    timtodetect = arl_func(mu_s_1, sigma_s, h);
    tibfalsealm = arl_func(mu_s_0, sigma_s, h);
 
if(makeplot)
    figure
    legend_char_sigma = char(ones(Ns,1)*'\sigma_r =') ;
    legend_char_vec   = [legend_char_sigma, num2str(sigma_r','%2.1E')];
    %subplot(2,1,1),
    yyaxis right
    plot(h, ceil(timtodetect)), grid, %ylabel('samples')
    ylabel('Time to detect: Samples')
    %title('Time to detect');
    yline(T_D,'linestyle','--')
    xline(h_sol,'linestyle','--')
    legend(legend_char_vec,'Location','Best')
 
    %subplot(2,1,2)
    yyaxis left
    semilogy(h, floor(tibfalsealm)), grid, %ylabel('samples'), 
    ylabel('Time between false alarms: Samples')
    title('Average run length (ARL)')
    xlabel('h')
    yline(T_F,'linestyle','--')
    xline(h_sol,'linestyle','--')
    legend(legend_char_vec,'Location','EastOutside')
end    
    
end


function    [runlength] = arl_func(mu_s, sigma_s, h)
%
%   function to calculate average run length
%   reference: Blanke, Kinnaert, Lunze and Staroswiecki 2003
%   
%   implementet by Mogens Blanke 2003
%

if( mu_s ~= 0 )
musig = mu_s./sigma_s;
musig_s = musig./sigma_s;
musig_mat = ones(size(h))'* musig;

muhsig = h'* musig_s;
sigmundarg = muhsig + 1.166*musig_mat;

runlength = (exp(-2*sigmundarg)-1+2*sigmundarg)./(2*musig_mat.^2);
else
    runlength = (h/sigma_s+1.166).^2;
end
end

