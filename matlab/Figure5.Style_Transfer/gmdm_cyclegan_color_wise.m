clc
clear all
close all

data_path = 'C:\Users\sypark\Desktop\Projects\w_Shujaat\0ovltools-GSSMD\7MultiDimGCNR\Test';
save_path = 'C:\Users\sypark\Desktop\Projects\w_Shujaat\0ovltools-GSSMD\7MultiDimGCNR\Test';

vector = false;
gray = false;

epoch_list = [500, 1000, 1500, 2000, 2500, 3000, 3500, 4000];
epoch_list = epoch_list';

for j=1:8
    src_dir = [strcat(data_path, '\predicted_', num2str(epoch_list(j)))];
    % src_dir = ['data\Test\predicted_1500'];
    % G_IT: 0.70412
    % G_OT: 0.83906
    % G_IO: 0.7311

    % src_dir = ['data\Test\predicted_3000'];
    % G_IT: 0.70412
    % G_OT: 0.90828
    % G_IO: 0.68454

    input_path = dir([src_dir, '\input_*']);
    target_path = dir([src_dir, '\target_*']);
    output_path = dir([src_dir, '\output_*']);

    [input_images] = double(load_images(input_path,vector,gray))/255;
    [target_images] = double(load_images(target_path,vector,gray))/255;
    [output_images] = double(load_images(output_path,vector,gray))/255;

    res = cell(100,1);

    for k=1:100
        sampling_indices = randsample(1:356, round(356*0.7));

        R = input_images(sampling_indices,:,:,1);
        G = input_images(sampling_indices,:,:,2);
        B = input_images(sampling_indices,:,:,3);
        data_input = [R(:) G(:) B(:)];

        R = target_images(sampling_indices,:,:,1);
        G = target_images(sampling_indices,:,:,2);
        B = target_images(sampling_indices,:,:,3);
        data_target = [R(:) G(:) B(:)];

        R = output_images(sampling_indices,:,:,1);
        G = output_images(sampling_indices,:,:,2);
        B = output_images(sampling_indices,:,:,3);
        data_output = [R(:) G(:) B(:)];

        components = 3;
        lambda = [1,1,1]/3;

        % input vs target
        G_X = 0;
        for i = 1:components
        temp =  OVL(data_input(:,i)',data_target(:,i)');
        G_X = G_X + lambda(i)*temp;
        end
        G_IT = G_X./sum(lambda);

        % output vs target
        G_X = 0;
        for i = 1:components
        temp(i) =  OVL(data_output(:,i)',data_target(:,i)');
        G_X = G_X + lambda(i)*temp(i);
        end
        G_OT = G_X./sum(lambda);

        % input vs output
        G_X = 0;
        for i = 1:components
        temp =  OVL(data_input(:,i)',data_output(:,i)');
        G_X = G_X + lambda(i)*temp;
        end
        G_IO = G_X./sum(lambda);

        res{k} = [G_IT, G_OT, G_IO];

        display(['G_IT: ', num2str(G_IT)])
        display(['G_OT: ', num2str(G_OT)])
        display(['G_IO: ', num2str(G_IO)])

    end

    res2 = cell2mat(res);

    %save(strcat(save_path, '\epoch_', num2str(epoch_list(j)), '.mat'), 'res2');
    
end