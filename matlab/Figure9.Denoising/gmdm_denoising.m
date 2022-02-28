clc; clear all; close all;

%load('Label_Noisy_Predicted_Images.mat')
load('C:\Users\sypark\Dropbox (KAIST_20)\Project_w_SK\Multi_GCNR\0data\input.mat')
load('C:\Users\sypark\Dropbox (KAIST_20)\Project_w_SK\Multi_GCNR\0data\predicted.mat')
load('C:\Users\sypark\Dropbox (KAIST_20)\Project_w_SK\Multi_GCNR\0data\target.mat')

%% Input 
input_red = zeros(352, 256*256);
input_green = zeros(352, 256*256);
input_blue = zeros(352, 256*256);

for i=1:352
    input_red(i,:) = reshape(input(i,:,:,1), [1, 256*256]);
    input_green(i,:)= reshape(input(i,:,:,2), [1, 256*256]);
    input_blue(i,:)= reshape(input(i,:,:,3), [1, 256*256]);
end;

%% target
clean_red = zeros(352, 256*256);
clean_green = zeros(352, 256*256);
clean_blue = zeros(352, 256*256);

for i=1:352
    clean_red(i,:) = reshape(target(i,:,:,1), [1, 256*256]);
    clean_green(i,:)= reshape(target(i,:,:,2), [1, 256*256]);
    clean_blue(i,:)= reshape(target(i,:,:,3), [1, 256*256]);
end;

%% CB_output
denoised_red = zeros(352, 256*256);
denoised_green = zeros(352, 256*256);
denoised_blue = zeros(352, 256*256);

for i=1:352
    denoised_red(i,:) = reshape(predicted(i,:,:,1), [1, 256*256]);
    denoised_green(i,:)= reshape(predicted(i,:,:,2), [1, 256*256]);
    denoised_blue(i,:)= reshape(predicted(i,:,:,3), [1, 256*256]);
end;

clean_vs_clean_red = zeros(1, 352);
clean_vs_noisy_red = zeros(1, 352);
clean_vs_denoised_red = zeros(1, 352);
noisy_vs_denoised_red = zeros(1, 352);

clean_vs_clean_green = zeros(1, 352);
clean_vs_noisy_green = zeros(1, 352);
clean_vs_denoised_green = zeros(1, 352);
noisy_vs_denoised_green = zeros(1, 352);

clean_vs_clean_blue = zeros(1, 352);
clean_vs_noisy_blue = zeros(1, 352);
clean_vs_denoised_blue = zeros(1, 352);
noisy_vs_denoised_blue = zeros(1, 352);

for i=1:352
    %red
    clean_vs_clean_red(i) = get_ovl(clean_red(i,:), clean_red(i,:));
    clean_vs_noisy_red(i) = get_ovl(input_red(i,:), clean_red(i,:));
    clean_vs_denoised_red(i) = get_ovl(denoised_red(i,:), clean_red(i,:));
    noisy_vs_denoised_red(i) = get_ovl(denoised_red(i,:), input_red(i,:));
    %green
    clean_vs_clean_green(i) = get_ovl(clean_green(i,:), clean_green(i,:));
    clean_vs_noisy_green(i) = get_ovl(input_green(i,:), clean_green(i,:));
    clean_vs_denoised_green(i) = get_ovl(denoised_green(i,:), clean_green(i,:));
    noisy_vs_denoised_green(i) = get_ovl(denoised_green(i,:), input_green(i,:));
    %blue    
    clean_vs_clean_blue(i) = get_ovl(clean_blue(i,:), clean_blue(i,:));
    clean_vs_noisy_blue(i) = get_ovl(input_blue(i,:), clean_blue(i,:));
    clean_vs_denoised_blue(i) = get_ovl(denoised_blue(i,:), clean_blue(i,:));
    noisy_vs_denoised_blue(i) = get_ovl(denoised_blue(i,:), input_blue(i,:));
end;

res_R=[clean_vs_clean_red', clean_vs_noisy_red', clean_vs_denoised_red', noisy_vs_denoised_red'];
res_G=[clean_vs_clean_green', clean_vs_noisy_green', clean_vs_denoised_green', noisy_vs_denoised_green'];
res_B=[clean_vs_clean_blue', clean_vs_noisy_blue', clean_vs_denoised_blue', noisy_vs_denoised_blue'];


 