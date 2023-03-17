function BLAESaim1_StudyPhaseBehavioralAnalysis()

%% Load data
% 1-2314:    image stimuli - actual number of image stimuli here 1838
% 2501-2504: instructions
% 2601:      sync pulse
% 2701-2701: stiulation
% 2801-5115: ITI (fixation cross)
% 5200:      ISI
% 5301-5421: Confidence Ratings
% 5500:      Practice images 
%recorded responses in image stimuli range    

%%% this script exctracts behavioral data from each .dat file,
%%% calcuates accuracy, LDI, and d', and
%%% outputs a csv table of all responses for each breakout session
%%% and outputs a separate summary statistics txt file for subject stats

clear;
close all;

addpath(genpath(fullfile(cd,'BCI2000Tools')))

subjID = 'Pilot1_LA001';

%repsonse keys
%indoor = 37;
%outdoor = 39;
samp_rate = 2000;

      
%% Get relevant .dat files at study
f = dir(fullfile(cd,'UTAH','BLAES_study',subjID,'*.dat'));

    for file = 1:size(f,1)

        [~, states, param] = load_bcidat(fullfile(f(file).folder,f(file).name));
        pause(1);
        
        seq         = param.Sequence.NumericValue;
        StimCode    = states.StimulusCode;
        StimCode    = double(StimCode);
        KD          = states.KeyDown;
        KD          = double(KD);

        
    %get keydown indices transposed into one column
    KD_indices = (1:size(KD))'; 
    KD(:,3) = KD_indices; %insert indices into the third column
    KD_timestamps = KD_indices/samp_rate;
    KD(:,4) = KD_timestamps;
    
    %count number of responses
    sum(KD(:,1) == 37);%indoor
    sum(KD(:,1) == 39);%outdoor
   
    %save index of stimulus codes
    imageStimCode_indices = (1:size(StimCode))'; 
    StimCode(:,2) = imageStimCode_indices; 
    KD(:,5) = StimCode(:,1);
    
    %filter out actual responses by deleting keydown = 0 
    KD_filter_mask1 = KD(:,1) ~= 0;
    KD_resp = KD(KD_filter_mask1,:); %create a new variable with the mask
    
    %filter out space bar from the other 
    KD_filter_mask2 = KD_resp(:,1) ~= 32;
    KD_resp = KD_resp(KD_filter_mask2,:);
    KD_filter_mask3 = KD_resp(:,5) <1839;%filter out key press when not at an image stimcode
    KD_resp = KD_resp(KD_filter_mask3,:);
    
    %count #of images in a sequence
    num_test_images = sum(seq(:,1)< 1839); %responses should not exceed 120
    images = KD_resp(:,5);
    
    %get stimulus code for images and filter them
    num_image_stimcode = sum(StimCode(:,1)< 1839);
    image_stimcode_mask1 = StimCode(:,1)< 1839;
    image_stimcode = StimCode(image_stimcode_mask1,:);
    image_stimcode_mask2 = image_stimcode(:,1) ~=0;
    image_stimcode = image_stimcode(image_stimcode_mask2,:);
   
    %extract the first and last timestamp value of images StimCode 
    for idx = 1:size(images)
        image_stimcode_value = images(idx);
        image_stimcode_mask = image_stimcode(:,1) == image_stimcode_value;
        image_stimcode_filter = image_stimcode(image_stimcode_mask,:); %add time_stimcode at second column
        timestimcode_start = min(image_stimcode_filter(:,2));
        image_timestamp_start = timestimcode_start/samp_rate;
        timestimcode_end = max(image_stimcode_filter(:,2));
        image_timestamp_end = timestimcode_end/samp_rate;
        
        %add start and stop time stim code to dataframe
        KD_resp(idx,8) = image_timestamp_start;
        KD_resp(idx,9) = image_timestamp_end;
        
        %filter if the keydown response is within the image stimulus code timestamp
%         if KD_resp(idx,3)>= timestimcode_start && KD_resp(idx,3) <= timestimcode_end
%             KD_resp(idx,9)= 1;%True
%         else
%             KD_resp(idx,9) = 0;%False
%         end
    end   
        
 
 %create a cell instead of a matrix so i can add strings
    KD_resp = num2cell(KD_resp);
    
 %add response condition as a string to cell matrix
   for i = 1:size(KD_resp)
    if KD_resp{i,1} == 37
        KD_resp{i,2} = 'indoor';
    elseif KD_resp{i,1} == 39
        KD_resp{i,2} = 'outdoor';
    end
   end
   
   %from param.Stimuli.Value{2} get the last 10 characters for the image
   %name or after the last slash - add it to the KD_resp cell
    for i = 1:size(images)
       image_value = images(i); %taking the image number as a value
       param.Stimuli.Value(:,image_value); %indexing 
       novelty_cond = param.Stimuli.Value(9, image_value); %get novelty condition
       image_path = param.Stimuli.Value(2, image_value); %get image_path
       %image_path = image_path{end-10:end}; %get the last 10 characters of image_path to get the image name
        KD_resp(i,6) = novelty_cond;
        KD_resp(i,7) = image_path;
    end
    
     %save the created dataframe as a csv file
     output_file = [subjID, 'study_resp', num2str(file)];
     writecell(KD_resp,output_file)
     
     fprintf('Done with %s file %d\n', subjID, file);
     
    end
