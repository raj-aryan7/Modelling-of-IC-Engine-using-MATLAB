function F = myfunc(x)
    xt = x(1);  
    yt = x(2);   
    
    % Equation 1
    eq1 = yt - 1 - (2/(1 + xt)^2) * xt;
    
    % Equation 2: Point lies on the curve
    eq2 = yt - (2*xt/(1 + xt));
    
    F = [eq1; eq2];  
end