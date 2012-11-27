function [] = num_methods ( )
    first()
    input('')
    second()
    input('')
    third()
    input('')
    fourth()
end
   
function [ roots ] = first()
    roots = ones(2);
    format long;

    x = -1.5 : 0.1 : 1.5;
    f = 'exp(x^5)+sin(x)+sin(cos(x))-10*x-x^9';
    y = exp(x.^5)+sin(x)+sin(cos(x))-10.*x-x.^9;

    plot(x, y);
    grid on;
    A = [-0.5, 1.1];
    B = [1.0, 1.4];
    for i = 1 : length(A)
        roots(i) = fzero(f, A(i), B(i));
    end
end

function [ roots ] = second ( )
    roots = zeros(1);
    x = -1 : 0.1 : 1;
    f = 'sin(x).^2+x.^4-x.^2-cos(x).^2-13.*x-10';
    y = sin(x).^2+x.^4-x.^2-cos(x).^2-13.*x-10;
    plot (x, y);
    grid on;
    A = -0.5;
    B = 0.5;
    for i = 1 : length(A)             
        roots(i) = fzero(f, A(i), B(i));
    end
end

function [ root ] = third()
    coeffs = [1 -26 -84 555 499 -991 -838 32];
    root = sort(roots(coeffs));
    x = -7 : 0.1 :5;
    f = 1.*x.^7 - 26.*x.^6 - 84.*x.^5 + 555.*x.^4 + 499.*x.^3 - 991.*x.^2 - 838.*x + 32.;
    plot(x, f);
    grid on;
    axis( [ -7, 5, -50, 50 ] );
end

function [ roots ] = fourth ( )
    x = sym('x');
    f = 1.*x.^7 - 26.*x.^6 - 84.*x.^5 + 555.*x.^4 + 499.*x.^3 - 991.*x.^2 - 838.*x + 32.;
    roots = sort(solve(f));
    x2 = -7 : 0.1 : 5;
    f = 1.*x2.^7 - 26.*x2.^6 - 84.*x2.^5 + 555.*x2.^4 + 499.*x2.^3 - 991.*x2.^2 - 838.*x2 + 32.;
    plot(x2, f);
    grid on;
    axis( [ -7, 5, -50, 50 ] );
end

