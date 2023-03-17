%This script adds white space in both width and height of images and saves
%the new images into a new directory
%Martina Hollearn @ James Swift 1/23/2023

clear;
close all;

imagepath  = fullfile(cd, 'LongDelay_images'); 

mkdir('padded_images_LongDelay');
newdir = 'padded_images_LongDelay';

allimages = dir(fullfile(imagepath, '*.PNG'));

for i = 1:size(allimages,1)
    clear AppendWhiteRight AppendWhiteLeft AppendWhiteTop AppendWhiteBottom appendSizeHeight appendStimulusWidth imagepath

    imagepath = fullfile(allimages(i).folder,allimages(i).name);
    image_matrix = imread(imagepath);

    if size(image_matrix,3) == 1
        image_matrix = image_matrix(:,:,[1,1,1]);
    end

    newpic = image_matrix;

    if size(newpic,2) ~= 400
        appendSizeHeight  = 400 - size(image_matrix,2);
        AppendWhiteTop    = 255*(ones(size(image_matrix,1),ceil(appendSizeHeight/2),3));
        AppendWhiteBottom = 255*(ones(size(image_matrix,1),floor(appendSizeHeight/2),3));
        newpic = [AppendWhiteTop,newpic, AppendWhiteBottom];
    end

    if size(newpic,1) ~= 400
        appendStimulusWidth = 400 - size(image_matrix, 1);
        AppendWhiteLeft     = 255*(ones(ceil(appendStimulusWidth/2),size(newpic,2),3));
        AppendWhiteRight    = 255*(ones(floor(appendStimulusWidth/2),size(newpic,2),3));
        newpic = [AppendWhiteLeft;newpic;AppendWhiteRight];
    end

    imwrite(newpic,fullfile(cd,newdir,allimages(i).name),'png');
end

% %visual checks
% figure(1);
% image(image_matrix)
% 
% figure(2);
% image(newpic)
