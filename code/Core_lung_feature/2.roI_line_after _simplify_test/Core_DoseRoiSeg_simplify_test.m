%% 剂量线分割并读取肺分割轮廓，简化
clc;
clear all;
t1=clock;
profile on

%% 诊断CT超参数，读入mat文件，mat.bz2压缩过的不行
run_mode = 2 ;  % 运行模式1，生成诊断CT剂量线和第一个计划时间点的计划CT；模式2，根据已有的制作好的计划CT插值生成其余时间点的计划CT
mat_str = 'E:\roi_feat_dose\' ;
patient_name = '14.chenguoqiang';
data_time = {'180623','180730','180926','181205','190311'} ;   %   181009
% data_time = {'180623'} ;   %   181009
plan_time = {'180403'} ; % 计划时间
delta_x =  [-24.49175137,-21.117,9.279455411,-20.443,13.34630359] ;  % 单位mm，x方向偏移,变形后减去变形前，通过3Dslicer变形场可计算得到,程序xdose起点-254.426，与DCM文件符号相反
delta_y =  [-24.79537392,-21.552,-1.399480468,-21.862,3.810750008] ;  % 单位mm，y方向偏移，27.9647，与DCM文件一致
delta_z =  [30.01483345,-27.598,37.0693512,-18.165,6.166799739] ;  % 单位mm，y方向偏移，-6.1314，与DCM文件符号相反，顺序相反
dose_grid_space = 0.4 ;   % 剂量网格尺寸
dose_seg = 5 ;          % 剂量划分区间，dose bin
doseNum = 7;             % 用第几种剂量方案，周正元方案7，胡红军方案1
seg_linename = 'lung_seg' ; % 肺分割线名称
lung_mask = 1 ;          % 肺分割mask区域的值
%% plan超参数，读入mat文件，mat.bz2压缩过的不行
lung_start = 5 ;      % 肺部图像开始slicer
lung_end = 50 ;   % 肺部图像结束slicer
lung_start_roi = 18 ;      % 肺部图像开始slicer
lung_end_roi = 197 ;   % 肺部图像结束slicer
strName = 'lung';        % 肺名称
image_size = 512   ;   % 图片大小

%% 循环计算一个病人的几个时间点的mat文件
for p = 1: length(data_time)
    if run_mode == 1  % 运行模式1，生成诊断CT剂量线和第一个计划时间点的计划CT
        % 计算治疗时间点的line并存入mat文件
        [planC,save_file,image_grid_space_xy,image_grid_space_z] = mat_renew_simplify(mat_str,patient_name,data_time(p),delta_x(p),...
            delta_y(p),delta_z(p),dose_grid_space,dose_seg,doseNum,seg_linename,lung_mask,plan_time);
        save(save_file,'planC');   % 保存更改后的数据到mat文件中
        % 计算对应治疗时间点plan的line并存入mat文件
        if p = 1  % 生成第一个计划CT
            [planC,save_file] = mat_renew_plan_simplify(mat_str,patient_name,data_time(p),dose_seg,doseNum,seg_linename,lung_start,...
                lung_end,lung_mask,strName,dose_grid_space,image_grid_space_xy,image_grid_space_z,image_size,plan_time);
            save(save_file,'planC');   % 保存更改后的数据到mat文件中
        end
    elseif run_mode == 2  % 模式2，根据已有的制作好的计划CT插值生成其余时间点的计划CT
        if p > 1
            
        end
    end
end
close;

%% 计算总的运行时间
profile viewer
t2=clock;
etime(t2,t1)
