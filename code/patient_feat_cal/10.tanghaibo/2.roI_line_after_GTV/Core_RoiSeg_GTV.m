clc;
clear all;
t1=clock;
profile on

%% ���CT������������mat�ļ���mat.bz2ѹ�����Ĳ���
mat_str = 'E:\roi_feat_dose\' ;
patient_name = '10.tanghaibo';
data_time = {'180817','180910','181002'} ;
plan_time = {'180801'} ; % �ƻ�ʱ��
num_image = [24,25,24];         % ���κ�GTVͼƬ������
num_image_plan = [19];    % �ƻ���roi��dcm�ļ�����
roi_x =  [243.164891,239.459,237.769] ;  % ��λmm��x����ƫ��,���κ��ȥ����ǰ��ͨ��3Dslicer���γ��ɼ���õ�,����xdose���-254.426����DCM�ļ������෴
roi_y =  [112.774862,232.557,273.349] ;  % ��λmm��y����ƫ�ƣ�27.9647����DCM�ļ�һ��
roi_z =  [-650.4443449,-95.625,-136.351] ;  % ��λmm��y����ƫ�ƣ�-6.1314����DCM�ļ������෴��˳���෴
roi_x_plan = 250;    % �ƻ�roidcm������Ϣ
roi_y_plan = 250 ;
roi_z_plan = -146.2 ;
roi_name = 'GTV'  ;      % roi������
lung_mask = 1 ;          % �ηָ�mask�����ֵ
% plan������������mat�ļ���mat.bz2ѹ�����Ĳ���
image_grid_space_xyplan = 0.976563 ;
image_grid_space_zplan = 5 ;

%% ��ʼ�������GTV
for p = 1:length(data_time)
    % ��������ʱ���Ĳ���GTV������mat�ļ�
    str_tranform_roi = [mat_str,'data\',patient_name,'\register\register_plan_to_',char(data_time(p)),'\',roi_name,...
        '_transform\'];   % GTV�������γ���������λ��
    filename = [mat_str,'plan\',patient_name,'\',char(data_time(p)),'\planC',char(data_time(p)),'_roi'];    % plan�ƻ���׼��
    [planC,save_file] = mat_renew_roi(roi_name,roi_x(p),roi_y(p),roi_z(p),lung_mask,...
        image_grid_space_xyplan,image_grid_space_zplan,num_image(p),str_tranform_roi,filename);
    save(save_file,'planC');   % ������ĺ�����ݵ�mat�ļ���
    % �����Ӧ����ʱ���plan����GTV������mat�ļ�
    str_tranform_roi_plan = [mat_str,'data\',patient_name,'\original\roi_segment\GTV_plan_dcm\'];   % GTV�������γ���������λ��
    filename_plan = [mat_str,'plan\',patient_name,'\',char(data_time(p)),'\planC',char(plan_time),'_roi'];    % plan�ƻ���׼��
    [planC,save_file] = mat_renew_roi(roi_name,roi_x_plan,roi_y_plan,roi_z_plan,lung_mask,...
        image_grid_space_xyplan,image_grid_space_zplan,num_image_plan,str_tranform_roi_plan,filename_plan);
    save(save_file,'planC');   % ������ĺ�����ݵ�mat�ļ���
end
close all;

%% �����ܵ�����ʱ��
profile viewer
t2=clock;
etime(t2,t1)