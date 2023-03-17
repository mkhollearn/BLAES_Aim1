% This script's goal is to create new versions of the study images with the possible
% response options added to the bottom of each image


clear;
close all;

imagepath  = fullfile(cd, 'padded_images_LongDelay'); 

mkdir('LongDelay_images_RO');
newdir = 'LongDelay_images_RO';

allimages = dir(fullfile(imagepath, '*.PNG'));
conf_resp = imread('confidence.png'); % confidence response option
%conf_resp = imresize(conf_resp,[50,400]);

for i = 1:length(allimages)
        clear newpic
        pic = imread(fullfile(allimages(i).folder,allimages(i).name));
        if size(pic(2)) ~= 400
            pic = imresize(pic,[NaN 400]);
        end
        newpic = [pic; conf_resp];
        imwrite(newpic,fullfile(cd,newdir,allimages(i).name),'png');
end