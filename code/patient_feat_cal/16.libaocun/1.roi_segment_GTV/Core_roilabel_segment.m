clc;
clear all;
close all;

%% ������������mat�ļ���mat.bz2ѹ�����Ĳ���
str = 'E:\roi_feat_dose\' ;
patient_name = '13.luoguiqiu' ;   %  ��������
data_time = '180920';    % ��Ӧ���˵�һ������ʱ�䣬Ϊ�˶�ȡ���ļ����µ�plan��mat�ļ�
plan_time = '180726';    % ��Ӧ���˵ļƻ�ʱ��
roi_name = 'GTV';
roi_start = 4   ; %  roi��plan��Ӧ����ʼslicer
num_image = 57 ;

%% roiͼƬ���ɺ���
roi_image_creat(str,patient_name,data_time,plan_time,roi_name,roi_start);

%% ��roiͼƬд���Ӧ��dcm�ļ���ʹ�京��������Ϣ��Ϊ�˺�����׼ʹ��
roi_dcm_creat(str,patient_name,roi_name,num_image);
