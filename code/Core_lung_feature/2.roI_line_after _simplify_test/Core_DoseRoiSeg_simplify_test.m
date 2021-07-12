%% �����߷ָ��ȡ�ηָ���������
clc;
clear all;
t1=clock;
profile on

%% ���CT������������mat�ļ���mat.bz2ѹ�����Ĳ���
run_mode = 2 ;  % ����ģʽ1���������CT�����ߺ͵�һ���ƻ�ʱ���ļƻ�CT��ģʽ2���������е������õļƻ�CT��ֵ��������ʱ���ļƻ�CT
mat_str = 'E:\roi_feat_dose\' ;
patient_name = '14.chenguoqiang';
data_time = {'180623','180730','180926','181205','190311'} ;   %   181009
% data_time = {'180623'} ;   %   181009
plan_time = {'180403'} ; % �ƻ�ʱ��
delta_x =  [-24.49175137,-21.117,9.279455411,-20.443,13.34630359] ;  % ��λmm��x����ƫ��,���κ��ȥ����ǰ��ͨ��3Dslicer���γ��ɼ���õ�,����xdose���-254.426����DCM�ļ������෴
delta_y =  [-24.79537392,-21.552,-1.399480468,-21.862,3.810750008] ;  % ��λmm��y����ƫ�ƣ�27.9647����DCM�ļ�һ��
delta_z =  [30.01483345,-27.598,37.0693512,-18.165,6.166799739] ;  % ��λmm��y����ƫ�ƣ�-6.1314����DCM�ļ������෴��˳���෴
dose_grid_space = 0.4 ;   % ��������ߴ�
dose_seg = 5 ;          % �����������䣬dose bin
doseNum = 7;             % �õڼ��ּ�������������Ԫ����7�����������1
seg_linename = 'lung_seg' ; % �ηָ�������
lung_mask = 1 ;          % �ηָ�mask�����ֵ
%% plan������������mat�ļ���mat.bz2ѹ�����Ĳ���
lung_start = 5 ;      % �β�ͼ��ʼslicer
lung_end = 50 ;   % �β�ͼ�����slicer
lung_start_roi = 18 ;      % �β�ͼ��ʼslicer
lung_end_roi = 197 ;   % �β�ͼ�����slicer
strName = 'lung';        % ������
image_size = 512   ;   % ͼƬ��С

%% ѭ������һ�����˵ļ���ʱ����mat�ļ�
for p = 1: length(data_time)
    if run_mode == 1  % ����ģʽ1���������CT�����ߺ͵�һ���ƻ�ʱ���ļƻ�CT
        % ��������ʱ����line������mat�ļ�
        [planC,save_file,image_grid_space_xy,image_grid_space_z] = mat_renew_simplify(mat_str,patient_name,data_time(p),delta_x(p),...
            delta_y(p),delta_z(p),dose_grid_space,dose_seg,doseNum,seg_linename,lung_mask,plan_time);
        save(save_file,'planC');   % ������ĺ�����ݵ�mat�ļ���
        % �����Ӧ����ʱ���plan��line������mat�ļ�
        if p = 1  % ���ɵ�һ���ƻ�CT
            [planC,save_file] = mat_renew_plan_simplify(mat_str,patient_name,data_time(p),dose_seg,doseNum,seg_linename,lung_start,...
                lung_end,lung_mask,strName,dose_grid_space,image_grid_space_xy,image_grid_space_z,image_size,plan_time);
            save(save_file,'planC');   % ������ĺ�����ݵ�mat�ļ���
        end
    elseif run_mode == 2  % ģʽ2���������е������õļƻ�CT��ֵ��������ʱ���ļƻ�CT
        if p > 1
            
        end
    end
end
close;

%% �����ܵ�����ʱ��
profile viewer
t2=clock;
etime(t2,t1)