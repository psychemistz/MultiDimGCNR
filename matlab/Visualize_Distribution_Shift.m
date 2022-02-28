vector = true;

src_dir = ['data\Test\predicted'];
input_path = dir([src_dir, '\input_*']);
target_path = dir([src_dir, '\target_*']);
output_path = dir([src_dir, '\output_*']);

[input_images] = load_images(input_path,vector);
[target_images] = load_images(target_path,vector);
[output_images] = load_images(output_path,vector);

data_full = double([input_images;target_images;output_images])/255;

data_tsne = tsne(data_full);

input_indices = 1:356;
target_indices = 357:712;
output_indices = 713:1068;

figure(1)
scatter(data_tsne(input_indices,1),data_tsne(input_indices,2))
hold on
scatter(data_tsne(target_indices,1),data_tsne(target_indices,2))
scatter(data_tsne(output_indices,1),data_tsne(output_indices,2))
legend('input','target','output')
