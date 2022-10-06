%% "GMDM: A generalized multi-dimensional distribution overlap metric for data and model quality evaluation"
% authors: Seongyong Park, Mohammad Sohail Ibrahim, Abdul Wahab, Shujaat Khan
% Purpose: GMDM metric to quantify effect of different normalization method to remove measurement-inconsistency in SERS.
% Code: Shujaat Khan: shujaat123@gmail.com

clc
clear all
close all

components=2000;
RAW_batch1 = readtable('data/pbno3_batch1.csv');
RAW_batch2 = readtable('data/pbno3_batch2.csv');
% concentrations = unique(RAW_batch1(2:end,3));

neg_data1 = table2array(RAW_batch1(table2array(RAW_batch1(2:end,3))<0.1,4:end));
pos_data1 = table2array(RAW_batch1(table2array(RAW_batch1(2:end,3))>=0.1,4:end));
neg_data2 = table2array(RAW_batch2(table2array(RAW_batch2(2:end,3))<0.1,4:end));
pos_data2 = table2array(RAW_batch2(table2array(RAW_batch2(2:end,3))>=0.1,4:end));

[G_raw_score_Nd1_Pd1] = findGMDM(neg_data1,pos_data1,components);
[G_raw_score_Nd1_Pd2] = findGMDM(neg_data1,pos_data2,components);
[G_raw_score_Nd1_Nd2] = findGMDM(neg_data1,neg_data2,components);
[G_raw_score_Nd2_Pd1] = findGMDM(neg_data2,pos_data1,components);
[G_raw_score_Nd2_Pd2] = findGMDM(neg_data2,pos_data2,components);
[G_raw_score_Pd1_Pd2] = findGMDM(pos_data1,pos_data2,components);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

RAW_BC_batch1 = readtable('data/pbno3_bc_batch1.csv');
RAW_BC_batch2 = readtable('data/pbno3_bc_batch2.csv');
% concentrations = unique(RAW_batch1(2:end,3));

neg_data1 = table2array(RAW_BC_batch1(table2array(RAW_BC_batch1(2:end,3))<0.1,4:end));
pos_data1 = table2array(RAW_BC_batch1(table2array(RAW_BC_batch1(2:end,3))>=0.1,4:end));
neg_data2 = table2array(RAW_BC_batch2(table2array(RAW_BC_batch2(2:end,3))<0.1,4:end));
pos_data2 = table2array(RAW_BC_batch2(table2array(RAW_BC_batch2(2:end,3))>=0.1,4:end));

[G_raw_bc_score_Nd1_Pd1] = findGMDM(neg_data1,pos_data1,components);
[G_raw_bc_score_Nd1_Pd2] = findGMDM(neg_data1,pos_data2,components);
[G_raw_bc_score_Nd1_Nd2] = findGMDM(neg_data1,neg_data2,components);
[G_raw_bc_score_Nd2_Pd1] = findGMDM(neg_data2,pos_data1,components);
[G_raw_bc_score_Nd2_Pd2] = findGMDM(neg_data2,pos_data2,components);
[G_raw_bc_score_Pd1_Pd2] = findGMDM(pos_data1,pos_data2,components);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

RAW_PSN_batch1 = readtable('data/pbno3_psn_batch1.csv');
RAW_PSN_batch2 = readtable('data/pbno3_psn_batch2.csv');
% concentrations = unique(RAW_batch1(2:end,3));

neg_data1 = table2array(RAW_PSN_batch1(table2array(RAW_PSN_batch1(2:end,3))<0.1,4:end));
pos_data1 = table2array(RAW_PSN_batch1(table2array(RAW_PSN_batch1(2:end,3))>=0.1,4:end));
neg_data2 = table2array(RAW_PSN_batch2(table2array(RAW_PSN_batch2(2:end,3))<0.1,4:end));
pos_data2 = table2array(RAW_PSN_batch2(table2array(RAW_PSN_batch2(2:end,3))>=0.1,4:end));

[G_raw_PSN_score_Nd1_Pd1] = findGMDM(neg_data1,pos_data1,components);
[G_raw_PSN_score_Nd1_Pd2] = findGMDM(neg_data1,pos_data2,components);
[G_raw_PSN_score_Nd1_Nd2] = findGMDM(neg_data1,neg_data2,components);
[G_raw_PSN_score_Nd2_Pd1] = findGMDM(neg_data2,pos_data1,components);
[G_raw_PSN_score_Nd2_Pd2] = findGMDM(neg_data2,pos_data2,components);
[G_raw_PSN_score_Pd1_Pd2] = findGMDM(pos_data1,pos_data2,components);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



