function direction=getDirection(a,b,c)

val=(b(2)-a(2))*(c(1)-b(1))-(b(1)-a(1))*(c(2)-b(2));

   if val == 0
      direction=0; % 'collinear';
      return
   elseif val < 0
      direction=2; %'anti-clockwise';
      return
   else 
       direction=1;% 'clockwise';
       return
   end

end