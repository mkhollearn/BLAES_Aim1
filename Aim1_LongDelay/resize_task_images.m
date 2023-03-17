%resizes test images

clear;
close all;

mkdir('LongDelay_images_fixed');
newdir = 'LongDelay_images_fixed';
imagepath  = fullfile(cd, 'padded_images_LongDelay'); 
allimages = dir(fullfile(imagepath, '*.PNG'));

whitespace = imread('whitespace.png'); % padding
whitespace = imresize(whitespace,[79,400]);

for i = 1:length(allimages)
        clear newpic
        pic = imread(fullfile(allimages(i).folder,allimages(i).name));
        if size(pic(2)) ~= 400
            pic = imresize(pic,[NaN 400]);
        end
        newpic = [pic; whitespace];
        imwrite(newpic,fullfile(cd,newdir,allimages(i).name),'png');
end
