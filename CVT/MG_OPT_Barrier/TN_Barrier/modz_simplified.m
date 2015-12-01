function [ipivot1] = modz_simplified (x, p, ipivot, low, up)
%---------------------------------------------------------------------
% update the constraint matrix if a new constraint is encountered
%---------------------------------------------------------------------
indl = find(ipivot == 0 & p < 0);
if (length(indl) > 0);
   toll = 10 * eps * (abs(low(indl)) + ones(size(indl)));
   hitl = find(x(indl)-low(indl) <= toll);
   if (length(hitl)>0);
      ipivot(indl(hitl)) = -1;
   end;
end;
%---------------------------------------------------------------------
indu = find(ipivot == 0 & p > 0);
if (length(indu) > 0);
   tolu = 10 * eps * (abs( up(indu)) + ones(size(indu)));
   hitu = find(up(indu)-x(indu)  <= tolu);
   if (length(hitu)>0);
      ipivot(indu(hitu)) = 1;
   end;
end;
%---------------------------------------------------------------------
ipivot1 = ipivot;
