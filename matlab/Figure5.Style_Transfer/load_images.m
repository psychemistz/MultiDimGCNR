function [images] = load_images(images_path,vector,gray)
%LOAD_IMAGES Summary of this function goes here
%   Detailed explanation goes here
images =[];
for fr_loop = 1:numel(images_path)
    if(gray)
        temp = imread([images_path(fr_loop).folder,'\',images_path(fr_loop).name]);
        if(size(temp,3)>1)
            temp = rgb2gray(temp);
        end
    else
        temp = imread([images_path(fr_loop).folder,'\',images_path(fr_loop).name]);
    end
    if(vector)
        images = cat(1,images,temp(:)');
    else
        images = cat(4,images,temp);
    end
end
if(not(vector))
    images = permute(images,[4,1,2,3]);
end
end

