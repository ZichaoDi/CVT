disp('MG/Opt startup file...');
more on;
format compact;
warning off;

%path(path,'C:\Documents and Settings\buckaroo\Desktop\mgopt_04_06\MGOPT')
%path(path,'C:\Documents and Settings\buckaroo\Desktop\mgopt_04_06\TN')
%path(path,'C:\Documents and Settings\buckaroo\Desktop\mgopt_04_06\NSOLA')

if (ispc)
  slash = '\';
else
  slash = '/';
end

PWD = pwd;
path(path,[pwd, slash, 'MGOPT_Barrier']);
path(path,[pwd, slash, 'TN_Barrier']);
path(path,[pwd, slash, 'NSOLA']);
path(path,[pwd, slash, 'MGOPT_CON']);


