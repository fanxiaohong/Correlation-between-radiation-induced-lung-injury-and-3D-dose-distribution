clc;
clear all;
t1=clock;
profile on

%% ���CT������������mat�ļ���mat.bz2ѹ�����Ĳ���
mat_str = 'E:\roi_feat_dose\' ;
patient_name = '7.xiangzhilin';
data_time = {'181009'} ;   %   181009
plan_time = {'180725'} ; % �ƻ�ʱ��

num_image = [94];         % ���κ����ͼƬ����
num_image_lungSeg = [165] ;  % �ηָ�ͼƬ����,321,165
delta_x =  [7.10551431] ;  % ��λmm��x����ƫ��,���κ��ȥ����ǰ��ͨ��3Dslicer���γ��ɼ���õ�,����xdose���-254.426����DCM�ļ������෴
delta_y =  [3.071410572] ;  % ��λmm��y����ƫ�ƣ�27.9647����DCM�ļ�һ��
delta_z =  [130.3739628] ;  % ��λmm��y����ƫ�ƣ�-6.1314����DCM�ļ������෴��˳���෴
dose_grid_space = 0.4 ;   % ��������ߴ�
dose_seg = 5 ;          % �����������䣬dose bin
roi_num_start = 19 ;     % ���е�roi����
doseNum = 1;             % �õڼ��ּ�������������Ԫ����7�����������1
seg_linename = 'lung_seg' ; % �ηָ�������
lung_mask = 1 ;          % �ηָ�mask�����ֵ
%% plan������������mat�ļ���mat.bz2ѹ�����Ĳ���
lung_start = 3 ;      % �β�ͼ��ʼslicer
lung_end = 45 ;   % �β�ͼ�����slicer
plan_dcm_num = 47 ;    % �ƻ�������dcm�ļ���
strName = 'lung';        % ������
image_grid_space_xyplan = 0.976563 ;
image_grid_space_zplan = 5 ;
image_size = 512   ;   % ͼƬ��С
image_grid_space_xy = [0.972656012] ;   %��ʱ���ͼ��xy������
image_grid_space_z = [1.249993902] ;      %��ʱ���ͼ��z������
roi_empty = 10 ;  % ����roi�ÿ�

%% ѭ������һ�����˵ļ���ʱ����mat�ļ�
for p = 1 : length(data_time)
    % ��������ʱ����line������mat�ļ�
    [planC,save_file] = mat_renew(mat_str,patient_name,data_time(p),num_image(p),num_image_lungSeg(p),delta_x(p),...
        delta_y(p),delta_z(p),dose_grid_space,dose_seg,roi_num_start,doseNum,seg_linename,lung_mask);
    save(save_file,'planC');   % ������ĺ�����ݵ�mat�ļ���
    % �����Ӧ����ʱ���plan��line������mat�ļ�
%     [planC,save_file] = mat_renew_plan(mat_str,patient_name,data_time(p),dose_seg,roi_num_start,doseNum,seg_linename,lung_start,...
%         lung_end,plan_dcm_num,num_image_lungSeg(p),lung_mask,strName,dose_grid_space,image_grid_space_xyplan,image_grid_space_xy(p),...
%         image_grid_space_z(p),image_grid_space_zplan,image_size,plan_time,roi_empty);
%     save(save_file,'planC');   % ������ĺ�����ݵ�mat�ļ���
end

%% �����ܵ�����ʱ��
profile viewer
t2=clock;
etime(t2,t1)