function [featS] = feat_cal(filename,paramS,roi_name);
% 计算全部纹理特征值

%% 载入mat文件，planC
m = matfile(filename);
global planC 
planC = m.planC;

%% plan有的内容
indexS = planC{end};        % plan有的内容
strC = {planC{indexS.structures}.structureName};    % 根据plan中structure的位置得到他的位置编号数字

%% 循环计算几个roi
len = size(roi_name);
roi_num = len(2);
for n = 1:roi_num
    structNum = getMatchingIndex(paramS.structuresC{n},strC,'exact');    % 根据参数设置文件得到ROI的数字
    scanNum = getStructureAssociatedScan(structNum,planC);
    eval(['featS.',char(roi_name(n)),'=' 'calcGlobalRadiomicsFeatures(scanNum, structNum, paramS, planC);']);   % 计算所有的纹理特征
end