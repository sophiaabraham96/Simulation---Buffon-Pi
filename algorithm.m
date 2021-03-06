% Date Due: 
%       March 8th, 2017 
 
% Purpose 
%       This program will simulate the tossing of a needle many times to
%       estimate the value of pi. 
 
% Authors 
%       Tyler Adams 
%       Jonathan Nieves 
%       Sophia Abraham 
 
 
clc
clf
clear all
 
%inputs
I=input('the number of tosses = ');
L=input('the length of one side of the square = ');
d=input('the number of divisions to draw parallel lines = ');
while floor(d)~= ceil(d)
    disp('please enter whole number greater than or equal to 2')
    d=input('the number of divisions to draw parallel lines = ');
end
l=input('the length of the needle = ');
 
 %generate tosses
 
i=1;
%does functions for all tosses
for i=1:I 
    % x value for 1 end of needle
    landingx=(0+rand*(L)); 
    % y value for 1 end of the needle
    landingy=(0+rand*(L)); 
    % plots one end of the needle 
    plot(landingx,landingy,'o');  
    hold on
    % used to give positive and negative slopes
    e=floor(rand*L); 
    % generate random slope to find other end of needle
    m=(rand*L)*((0-1)^e); 
    % find delta x for other end of needle
    deltax=sqrt((l^2)/(1+m^2));
    % find delta y for other end of the needle
    deltay=m*deltax; 
    % set x for other end of needle
    dx=(deltax+landingx); 
    % set y for other end of the needle
    dy=(deltay+landingy); 
    while dx>L || dy>L || dx<0 || dy<0
        % generate give positive and negative slopes
        e=floor(rand*L); 
        % generate random slope to find other end of needle 
        m=(rand*L)*((0-1)^e); 
        % find delta x for other end of needle
        deltax=sqrt((l^2)/(1+m^2)); 
        % delta y for other end of the needle
        deltay=m*deltax; 
        % set x for other end of needle
        dx=(deltax+landingx); 
        % set y for other end of the needle
        dy=(deltay+landingy); 
    end
    % plot other end of the needle
    plot(dx,dy,'s'); 
    x=[landingx,dx]; 
    y=[landingy,dy];
    % plot a line between both end of the needle
    plot(x,y); 
    % fit the data to a linear function
    p=polyfit(x,y,1);  
    % generate x points between two found random points
    t=landingx:0.01:dx;  
    % evaluate function at generated x values 
    xf=polyval(p,t); 
    
    % generate lines for division
    hold on 
    % creating parallel lines from given input values  
    div = 0:L/d:L ;  
    % plotting generated parallel lines 
    plot([div; div],[zeros(1, length(div))*min(ylim); ones(1, length(div))*max(ylim)])
    
    % finding number of intersections with parallel lines 
    
    % finding length of vector t
    n=length(t);
    % finding length of vector for parallel lines 
    q=length(div);
    % setting counter for intersections 
    k=0; 
    % nested loop to analyze all elements of vector 
    b=0;
    for b=1:1:d+1;
        t(i)= t(b);
        b=b+1;
    end
    for j=1:1:(n-1); 
        for i=1:1:(n-1);
            % finding points of intersection
            k=0;
            if intersect(t(i),div) 
                k=k+1;
            else
                k=k;
            end
        end
    end
end
 
% Method did not work, proceeding code assuming success in method 
 
% Other Potential Methods: ******
% 1. Create rectangular regions on graph that align with parallel lines, 
% turn plotted line into a function and track intersections 
% 2. Use syms, polyfit and polyval command to fit the line plot into a
% function. Change parallel lines into functions (i.e. x=L/d). Track
% intersections while establishing limits (length of paper) 
% 3. develop a sub algorithm to track lines in graph of MATLAB 
% 4. Generate coordinate vectors for generated lines in experiment and find
% any common values between this vector and the vector consisting of the
% parallel divides. Use loops to count number of intersections 
 
%Finding estimate of pi 
dim=L/d;
num=2*l*I;
pi_est= (num)/(dim*k);
 
%Finding the True Error 
trueerr=pi-pi_est;
 
%Finding Relative True Error 
RTE=(trueerr)/(pi);
 
%Finding Absolute Relative True Error 
ARE=abs(RTE);
 
%Outputs
disp('The estimate of pi after this simulation is: ')
disp(pi_est)
disp('The true error of this experiment is: ')
disp(trueerr)
fprintf('The relative true error and absolute relative true error are %g and %g\n',RTE,ARE)
 
 
 disp(k)
 
 
 %Set domain and range **put at bottom or won’t stay sets domain and range**
 xlim([0,L]);
 ylim([0,L]);
