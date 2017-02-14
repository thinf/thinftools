function dout = thbincolread(filename,recType,recLen,varargin)

% dout = thbincolread(filename,recType,recLen,[machineformat])
% reads binary files that contain different datatypes organized in columns
%
% example:
% recType = {'integer*4' 'real*8' 'real*4' 'real*4' 'real*4'};
% recLen = [4 8 4 4 4];
% use machineformat = 'b' to specify big-endian foramt as e.g. used on
% stallo

disp('****************** thbincoloread ******************')
disp('load file:')
disp(filename)
disp (char(13))

machineformat = varargin{1};

dout = cell(1,numel(recType));
%f = fopen('/global/work/thinf/tracmass_results/nof_asta_01_long_t00000360_ini.bin',...
if ~isempty(machineformat)
    f = fopen(filename,'r',machineformat);
else
    f = fopen(filename,'r');
end

disp('-> start dataread...')
tic
for i = 1:numel(recType)
    disp(['...read col ' num2str(i) ' of ' num2str(numel(recType))])
    
    fseek(f, sum(recLen(1:i-1)), 'bof');
    dout{i} = fread(f, Inf, ['*' recType{i}], sum(recLen)-recLen(i));
end
disp('...DONE!"')
toc

fclose(f);
end