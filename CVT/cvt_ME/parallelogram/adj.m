
div = 64;

data = zeros(1,2);
%...........Initialization...............................

 [struct,N] = formation(div); 
 dataExact = mapping(struct);

save '64struct.txt' -ascii -double -tabs struct;
save '64Exact.txt' -ascii -double -tabs dataExact;
save '64N.txt' -ascii -double -tabs N;

 
A = adjacency1(dataExact);
disp('adjacency found'); 


ii = ones(N,1);
for i=1:N
ii(i) = i;
end
xx = ones(N,1);
layers = sparse(ii,ii,xx);

for ind=1:N
    if (mod(ind,50)==0) fprintf('%d-th out of %d built\n',ind,N); end  
    for k=1:(div/2)    
     loc=ismember(layers(ind,1:N),k+1);
     s = sum(loc);
     if (s==0) layers = buildLayer(k,A,layers,dataExact,ind); end              
    end
end

fid1 = fopen('64A.txt','w');
fid2 = fopen('64layers.txt','w');
for i=1:size(A,1)
 for j=1:size(A,1)
  fprintf(fid1,'%d ',A(i,j));
  fprintf(fid2,'%d ',layers(i,j));
 end
 fprintf(fid1,'\n'); 
 fprintf(fid2,'\n'); 
end
fclose(fid1);
fclose(fid2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

