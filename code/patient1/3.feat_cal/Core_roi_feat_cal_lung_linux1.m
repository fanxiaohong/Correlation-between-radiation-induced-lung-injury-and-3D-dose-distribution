clc;
clear all;
profile on
t1=clock;

%% ���������mat�ļ���mat.bz2ѹ����Ĳ��???
file_way = '/home/yy/fanxiaohong/roi_feat_dose/';
mat_str = [file_way,'plan/'] ;
patient_name = '1.zhouzhengyuan';
paramFileName = [file_way,'json_set/roi_settings2.json'];       % ��������ļ�λ�???
save_file = [file_way,'result/feature_lung_1zhou0611-0910.txt'] ;
% roi_name = {'lung_seg','dose0_5','dose5_10','dose10_15','dose15_20','dose20_25','dose25_30','dose30_35','dose35_40',...
%     'dose40_45','dose45_50','dose50_55','dose55_60','dose60_65'};
filt_name = {'Original','Wavelets_Coif1__HHH','Sobel','Gabor_radius3_sigma0_5_AR1_30_deg_wavelength1'};
% data_time = {'190420','190611','190619','190824','190830','190910'} ;
roi_name = {'dose25_35','dose35_45','dose45_55','dose55_65'};
% filt_name = {'Original'};
data_time = {'190611','190619','190824','190830','190910'} ;
name_time = '190505' ;      % �ļ���ȡ������
          
% ����������ò��???
paramS = getRadiomicsParamTemplate(paramFileName);  % ��������ļ�λ�???
len = size(roi_name);
roi_num = len(2);

%% ������������ֵ������excel
[feat_matrix_all] = write_data_lung(data_time,mat_str,patient_name,roi_name,name_time,paramS);
% clm_data = ['D',num2str(3)];     % ���������д��excel�ļ�
% xlswrite(save_file,feat_matrix_all,patient_name,clm_data);
dlmwrite(save_file,feat_matrix_all,'precision','%6.8f');

%% �����ͷ�����???
[feat_name,col_name] = feat_title_lung(roi_name,data_time,filt_name);

%% ����ܺ�??
profile viewer
t2=clock;
etime(t2,t1)