clc;
clear all;
close all;

%% ������������mat�ļ���mat.bz2ѹ�����Ĳ���
str = 'E:\roi_feat_dose\' ;
patient_name = '4.jiangxiaoping' ;   %  ��������
data_time = '180621';    % ��Ӧ���˵�һ������ʱ�䣬Ϊ�˶�ȡ���ļ����µ�plan��mat�ļ�
plan_time = '180509';    % ��Ӧ���˵ļƻ�ʱ��
roi_name = 'GTV';
roi_start = 24   ; %  roi��plan��Ӧ����ʼslicer
num_image = 54 ;

%% roiͼƬ���ɺ���
roi_image_creat(str,patient_name,data_time,plan_time,roi_name,roi_start);

%% ��roiͼƬд���Ӧ��dcm�ļ���ʹ�京��������Ϣ��Ϊ�˺�����׼ʹ��
roi_dcm_creat(str,patient_name,roi_name,num_image);
