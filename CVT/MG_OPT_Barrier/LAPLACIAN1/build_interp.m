global Update Downdate

for k = 1:(numel(N)-1)
  nh = N(k);
  nH = N(k+1);

  xh = linspace(0, 1, nh+2)';
  xH = linspace(0, 1, nH+2)';
  yH = zeros(size(xH))';
  U = zeros(nh,nH);

  for j = 2:(nH+1)
	yH(j) = 1;
	yh = interp1(xH, yH, xh);
	U(:,j-1) = yh(2:(end-1));
	yH = 0*yH;
  end

  Update{k}   = sparse(U);
  Downdate{k} = Update{k}';
  scale = sum(Downdate{k},2);
  scale = scale(2);
  Downdate{k} = Downdate{k}/scale;
end
