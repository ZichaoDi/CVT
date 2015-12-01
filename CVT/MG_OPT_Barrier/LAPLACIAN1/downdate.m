function vH = downdate (vh,res_prob)

global Downdate;
for k = 1:numel(Downdate)
  if (numel(vh) == size(Downdate{k},2))
	vH = Downdate{k}*vh;
	return;
  end
end