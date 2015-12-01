function vh = update (vH,res_prob)

global Update;
for k = 1:numel(Update)
  if (numel(vH) == size(Update{k},2))
	vh = Update{k}*vH;
	return;
  end
end
