% 统计病人符合要求的特征，paper图2指标筛选
clc;
close all;
clear all;

%% 公共超参数，需要自己设定的数据
result_str = 'E:/roi_feat_dose/result/';
data_str = [result_str,'feature_all_person_radiation_time4.xls'];
save_file = [result_str,'/feat_filt_radiation.xls'] ;
roi_num = 10 ; % roi的数量
X = [2.5,7.5,12.5,17.5,22.5,30,40,50,60] ;    % 横坐标剂量值
sheet_name = {'4','8','12','15'};
patient_datatime = [11,6,4,2] ;   % 各个病人诊断CT的时间点个数
save_mode = 0 ;  % 保存模式，1保存excel，其他不保存

%% 读取数据
for p = 1: length(sheet_name)   % 读取数据
    [num_data,txt_featname]= xlsread(data_str,char(sheet_name(p)));
    num_data = num_data(3:end,:);
    txt_featname = txt_featname(3:end,1);  % 读取有用的feat_name
    eval(['num_data_avg',num2str(p),' = [] ;']) ;  
    for i = 1: length(num_data)   
        num_data_tmp = reshape(num_data(i,:),roi_num,patient_datatime(p))';   % 把每一行按roi数目reshape
        num_data_tmp = sum(num_data_tmp)/patient_datatime(p);    % 按列求和,并求平均
        eval(['num_data_avg',num2str(p),'= [num_data_avg',num2str(p),';num_data_tmp];']) ; % 组装求平均后的特征值
    end
    eval(['num_data_avg',num2str(p),'(find(isnan(num_data_avg',num2str(p),')==1)) = 0 ;']);   % 第一步筛选，将矩阵中的nan替换为0
end

%% 第一步筛选，筛选出dose45-55、55-65有大差异的特征
for p = 1: length(sheet_name)   % 循环命名初始空数组
    eval(['num_data_avg',num2str(p),'_filt2 = [];']);
end
txt_featname_filt2 = []; % 命名初始空数组
for i3 = 1:length(txt_featname)
    for i = 2:4   % 将1.5和4.2分别与\8\12\15对比统计
        eval(['logistic1',num2str(i),' = 0 ;']);  % 第一次筛选赋初始逻辑
        logistic1 = 0; % 统计用
        logistic12 = 0 ; % 统计用
        for j = 9 : 10  % 9个剂量区间纳入考核
            eval(['aa = (num_data_avg1(i3,j)-num_data_avg',num2str(i),'(i3,j))/num_data_avg1(i3,j)*100;']);
            aa12 = (num_data_avg2(i3,j)-num_data_avg1(i3,j))/num_data_avg1(i3,j)*100;
            aa = (abs(aa)>35) ;
            aa12 = (abs(aa12)<50) ;
            logistic1 = logistic1 + aa;
            logistic12 = logistic12 + aa12 ; 
        end
        eval(['logistic1',num2str(i),' = logistic1;']);  % 第一次筛选赋初始逻辑
    end
    if (logistic13 >= 2) & (logistic14 >= 2)& (logistic12 >= 2)
             (abs(num_data_avg1(i3,8)-num_data_avg4(i3,8))>5)& (abs(num_data_avg2(i3,8)-num_data_avg4(i3,8))<100); %如果符合条件则保存对应的特征数据和特征名
        for p = 1: length(sheet_name)   % 循环命名初始空数组
            eval(['num_data_avg',num2str(p),'_filt2 = [num_data_avg',num2str(p),'_filt2;num_data_avg',num2str(p),'(i3,:)];']);
        end
        txt_featname_filt2 = [txt_featname_filt2;txt_featname(i3)] ;
    end
end
        
%% 第二步筛选，筛选出dose0-5、5-10、10-15、15-20区间都满足10次比后续改变量在50%以上
for p = 1: length(sheet_name)   % 循环命名初始空数组
    eval(['num_data_avg',num2str(p),'_filt3 = [];']);
end
txt_featname_filt3 = []; % 命名初始空数组
for i3 = 1:length(txt_featname_filt2)
    for i = 1:4   % 将1.5和4.2分别与\8\12\15对比统计
        eval(['logistic',num2str(i),' = 0 ;']);  % 第一次筛选赋初始逻辑
        logistic1 = 0; % 统计用
        for j = 2 : 5  % 6个剂量区间纳入考核
            eval(['aa = (num_data_avg1_filt2(i3,j)-num_data_avg',num2str(i),'_filt2(i3,j))/num_data_avg1_filt2(i3,j)*100;']);
            aa = (abs(aa)<100) ;
            logistic1 = logistic1 + aa;
        end
        eval(['logistic',num2str(i),' = logistic1;']);  % 第一次筛选赋初始逻辑
    end
    if (logistic2 >= 4) & (logistic3 >=4)& (logistic1 >= 4) & (logistic4 >= 4)%如果符合条件则保存对应的特征数据和特征名
        for p = 1: length(sheet_name)   % 循环命名初始空数组
            eval(['num_data_avg',num2str(p),'_filt3 = [num_data_avg',num2str(p),'_filt3;num_data_avg',num2str(p),'_filt2(i3,:)];']);
        end
        txt_featname_filt3 = [txt_featname_filt3;txt_featname_filt2(i3)] ;
    end
end

%% 第三步筛选，筛选出dose35-45、45-55、55-60区间都满足10次比后续改变量在50%上
% for p = 1: length(sheet_name)   % 循环命名初始空数组
%     eval(['num_data_avg',num2str(p),'_filt4 = [];']);
% end
% txt_featname_filt4 = []; % 命名初始空数组
% for i4 = 1:length(txt_featname_filt3)
%     j = 1 ; % dose10-15
%     if (abs(num_data_avg4_filt3(i4,j)) <30) & (abs(num_data_avg2_filt3(i4,2)-num_data_avg5_filt3(i4,2)) <5)
%         for p = 1: length(sheet_name)   % 循环命名初始空数组
%             eval(['num_data_avg',num2str(p),'_filt4 = [num_data_avg',num2str(p),'_filt4;num_data_avg',num2str(p),'_filt3(i4,:)];']);
%         end
%         txt_featname_filt4 = [txt_featname_filt4;txt_featname_filt3(i4)] ;
%     end
% end


%% 找到筛选出的feat在原来数列中的顺序号即行号
col_feat = [];
for i = 1:length(txt_featname_filt3)
    [x,y] = find(strcmp(txt_featname,txt_featname_filt3(i)));  % x,y分别是行向量和列向量，这里只用到x
    col_feat = [col_feat;(x+2)] ;  % +2对应excel表中行号，方便做图
end

% 保存筛选出的数据
if save_mode ==1  % 保存模式
    clm_data = ['A',num2str(2)];     % 把特征名称写入excel文件
    xlswrite(save_file,txt_featname_filt3,'4',clm_data);
    clm_data1 = ['B',num2str(2)];     % 把特征名称写入excel文件
    xlswrite(save_file,col_feat,'4',clm_data1);
end

    
    
    