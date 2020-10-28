function [T] = trans(x,y)
%Translate: returns the translation matrix given the final x,y coordinates

T=[1 0 x;
    0 1 y;
    0 0 1];

end

