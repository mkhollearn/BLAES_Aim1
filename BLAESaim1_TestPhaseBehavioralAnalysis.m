function BLAESaim1_TestPhaseBehavioralAnalysis()

%% Load data
% 1-2314:    image stimuli - actual number of image stimuli here 1838
% 2501-2504: instructions
% 2601:      sync pulse
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

subjID = 'Pilot1_TC001';

%repsonse keys
%old = 37;
%new = 39;
%ResponseKeys = [old, new];
samp_rate = 2000;

      
% %% Get relevant .dat files at study
% f = dir(fullfile(cd,'UTAH','BLAES_study',subjID,'*.dat'));
% 
%     for file = 1:size(f,1)
%         if file ==1
%             continue
%         end
% 
%         [~, states, param] = load_bcidat(fullfile(f(file).folder,f(file).name));
%         pause(1);
%         
%         study_seq         = param.Sequence.NumericValue;
%         study_StimCode    = states.StimulusCode;
%         study_StimCode    = double(study_StimCode);
%         study_image_names = param.Stimuli.Value{2};
%         
%         
%         
%     end

%% Extract behavioral data
d = dir(fullfile(cd,'UTAH','BLAES_test',subjID,'*.dat'));

    for file = 1:size(d,1)
        
        [~, states, param] = load_bcidat(fullfile(d(file).folder,d(file).name));
        pause(1);
        
        seq         = param.Sequence.NumericValue;
        seqResponse = seq;
        KD          = states.KeyDown;
        StimCode    = states.StimulusCode;
        KD          = double(KD);
        StimCode    = double(StimCode);
    
    %get keydown indices transposed into one column
    KD_indices = (1:size(KD))'; 
    KD(:,3) = KD_indices; %insert indices into the third column
    KD_timestamps = KD_indices/samp_rate;
    KD(:,4) = KD_timestamps;
    
    %count number of responses
    sum(KD(:,1) == 37);%old
    sum(KD(:,1) == 39);%new
   
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
        KD_resp{i,2} = 'old';
    elseif KD_resp{i,1} == 39
        KD_resp{i,2} = 'new';
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
    
     Targ_total = 0;
     Targ_hit = 0;
     Targ_miss = 0;
     Lure_total = 0;
     Lure_FA = 0;
     Lure_CR = 0;
     Foil_total = 0;
     Foil_CR = 0;
     Foil_FA = 0;
     
%calculate accuracy
        for c = 1:size(KD_resp(:,1))
            if strcmp(KD_resp(c,2),'old') && strcmp(KD_resp(c,6),'Targ')
                KD_resp{c,10} = 'Correct';
                KD_resp{c,11} = 'Hit';
                Targ_hit = Targ_hit + 1;
            elseif strcmp(KD_resp(c,2),'old') && strcmp(KD_resp(c,6),'Lure')
                KD_resp{c,10} = 'Incorrect';
                KD_resp{c,11} = 'LureFA';
                Lure_FA = Lure_FA + 1;
            elseif strcmp(KD_resp(c,2),'old') && strcmp(KD_resp(c,6),'Foil')
                KD_resp{c,10} = 'Incorrect';
                KD_resp{c,11} = 'FoilFA';
                Foil_FA = Foil_FA + 1;
            elseif strcmp(KD_resp(c,2), 'new') && strcmp(KD_resp(c,6),'Targ')
                KD_resp{c,10} = 'Incorrect';
                KD_resp{c,11} = 'Miss';
                Targ_miss = Targ_miss + 1;
            elseif strcmp(KD_resp(c,2),'new') && strcmp(KD_resp(c,6), 'Lure')
                KD_resp{c,10} = 'Correct';
                KD_resp{c,11} = 'LureCR';
                Lure_CR = Lure_CR + 1;
            elseif strcmp(KD_resp(c,2),'new') && strcmp(KD_resp(c,6),'Foil')
                KD_resp{c,10} = 'Correct';
                KD_resp{c,11} = 'FoilCR';
                Foil_CR = Foil_CR + 1;
            end

        end
        
    Targ_total = Targ_hit + Targ_miss;
    Lure_total = Lure_CR + Lure_FA;
    Foil_total = Foil_CR + Foil_FA;%foil CR or FA! correct
    
    Targ_hitrate = Targ_hit/Targ_total;
    Lure_CRrate = Lure_CR/Lure_total;
    Lure_FArate = Lure_FA/Lure_total;
    Foil_CRrate = Foil_CR/Foil_total;
    Foil_FArate = Foil_FA/Foil_total;
    
    
    %calc LDI 
    %LDI = p(Lure CR)-p(Target Miss)
    LDI = Lure_CRrate/(1-Targ_hitrate);

    %calc d' 
    zTarg_hitrate = norminv(Targ_hitrate);
    zLure_FA = norminv(Lure_FArate);
    zFoil_CRrate = norminv(Foil_CRrate);
    dprime_targ = zTarg_hitrate - zLure_FA;
    dprime_foil = zFoil_CRrate - zLure_FA;
      
         stats(file,1)  = Targ_total;
         stats(file,2)  = Lure_total;
         stats(file,3)  = Foil_total;
         stats(file,4)  = Targ_hitrate;
         stats(file,5)  = Lure_CRrate;
         stats(file,6)  = Lure_FArate;
         stats(file,7)  = Foil_CRrate;
         stats(file,8)  = Foil_FArate;
         stats(file,9)  = LDI;
         stats(file,10) = dprime_targ;
         stats(file,11) = dprime_foil;
   
     %save created stats file for each session
     output_filename = [subjID, 'test_stats'];
     writematrix(stats,output_filename)
    
     %save the created dataframe as a csv file
     output_file = [subjID, 'test_resp', num2str(file)];
     writecell(KD_resp,output_file)
     
     %dataframe has the following structure
     %col1 = KeyDown (37 or 39)
     %col2 = 'old' or 'new'
     %col3 = raw time stamp stimulus code
     %col4 = col3/sampling rate - gives KeyDown in seconds
     %col5 = image stimulus code
     %col6 = image novelty condition
     %col7 = image path and name
     %col8 = image start time in seconds 
     %col9 = image end time in seconds
     %col10 = accuracy 'correct' or 'incorrect' 
     %col11 = signal detection condition 'hit', 'miss', 'FA', or 'CR' 
      
     fprintf('Done with %s file %d\n', subjID, file);
     
    end%extracting data
    
    
 %% Krista's code for BLAES Aim 2.1 
   
    
%         %% clean up sequence
%         % select only image stimuli
%         seq(seq<101) = [];
%         seq(seq>800) = [];
%         
%         seqResponse(seqResponse<801)  = [];
%         seqResponse(seqResponse>1500) = [];
%         
%         % ResponseStimCodeIdx also includes the no-response phase before they are allowed to respond
%         ResponseStimCodeIdx = {};
%         for i = 1:size(seq,1)
%             ResponseStimCodeIdx{i} = [find(StimCode==seq(i)); find(StimCode==seqResponse(i))];
%         end
%         
% 
% 
%         %% clean up KeyDown
%         % isolate keydown responses
%         
%         % find key down events during the no response or response phases and organize so we do not miss any responses
%         
%         % also take the second response if they respond during the no response phase and have to respond again
%         KD_cell = [];
%         for i = 1:size(seq,1)
%             KD_cell{i} = KD(ResponseStimCodeIdx{i});
%             KD_cell{i}(KD_cell{i}==0) = [];
%             if length(KD_cell{i}) > 1
%                 KD_cell{i} = KD_cell{i}(end);
%             end
%         end
%         
%         % swap out for a double version of KD
%         clear KD
%         for i = 1:size(KD_cell,2)
%             KD(i) = KD_cell{i};
%         end
%         clear KD_cell
%         
%         % Remove any key presses that were not the response keys
%         % This shouldn't ever do anything because I always take the second key down event, which should also meet
%         % the EarlyOffsetExpression and advance to the fixation cross
%         BadKD = [];
%         iter = 1;
%         for i = 1:length(KD)
% %             if KD(i) ~= ResponseKeys(1) && KD(i) ~= ResponseKeys(2) && KD(i) ~= ResponseKeys(3) && KD(i) ~= ResponseKeys(4)
%             if ~any(ismember(ResponseKeys,KD(i)))
%                 BadKD(iter) = i;
%                 iter = iter + 1;
%             end
%         end
%         
%         KD(BadKD) = 0;
%         
%         %% Compile data into single matrix
%         for i = 1:length(seq)
%             collectData{iter2,1} = param.Stimuli.Value{6,seq(i)};          % filename
%             collectData{iter2,2} = param.Stimuli.Value{9,seq(i)};          % identity
%             collectData{iter2,3} = str2num(param.Stimuli.Value{8,seq(i)}); % Stimulation
%             collectData{iter2,4} = param.Stimuli.Value{10,seq(i)};         % novelty
%             collectData{iter2,5} = KD(i);                                  % KeyDown
%             collectData{iter2,6} = seq(i);                                 % Sequence
%             iter2 = iter2 + 1;
%         end
%         
%     end
%     
%     save(fullfile(cd,'data',subjID,'Test',imageset,strcat(subjID,'_Test_Data',SureResponseString,'.mat')),'collectData')
% end
% 
% 
% %% Behavioral Analysis
% % hit/miss/false alarm/rejection
% % SURE NO        MAYBE NO       MAYBE YES      SURE YES
% % KeyDown == 67  KeyDown == 86  KeyDown == 66  KeyDown == 78
% 
% % confounded images 
% collectData = fixConfoundedImages(collectData,subjID,imageset); % only applicable for SLCH002
% 
% % number of hits and misses possible is the same
% TotalItemHitStim    = GetBA_MaxPossible(collectData, 'old', 'item',  1);
% TotalItemHitNoStim  = GetBA_MaxPossible(collectData, 'old', 'item',  0);
% TotalSceneHitStim   = GetBA_MaxPossible(collectData, 'old', 'scene', 1);
% TotalSceneHitNoStim = GetBA_MaxPossible(collectData, 'old', 'scene', 0);
% 
% % number of false alarms and rejections is the same
% TotalItemFA  = GetBA_MaxPossible(collectData, 'new', 'item',  0);
% TotalSceneFA = GetBA_MaxPossible(collectData, 'new', 'scene', 0);
% 
% for i = 1:size(collectData,1)
%     
%     % want to know if an item/scene was a hit or miss during stim or nostim
%     % for old and new items
%     
%     ItemHit_Stim(i,1)     = CheckBAConditions(collectData(i,:), 'old', 'item',  1, YesResponse);
%     ItemHit_NoStim(i,1)   = CheckBAConditions(collectData(i,:), 'old', 'item',  0, YesResponse);
%     SceneHit_Stim(i,1)    = CheckBAConditions(collectData(i,:), 'old', 'scene', 1, YesResponse);
%     SceneHit_NoStim(i,1)  = CheckBAConditions(collectData(i,:), 'old', 'scene', 0, YesResponse);
%     
%     ItemMiss_Stim(i,1)    = CheckBAConditions(collectData(i,:), 'old', 'item',  1, NoResponse);
%     ItemMiss_NoStim(i,1)  = CheckBAConditions(collectData(i,:), 'old', 'item',  0, NoResponse);
%     SceneMiss_Stim(i,1)   = CheckBAConditions(collectData(i,:), 'old', 'scene', 1, NoResponse);
%     SceneMiss_NoStim(i,1) = CheckBAConditions(collectData(i,:), 'old', 'scene', 0, NoResponse);
%     
%     ItemFalseAlarm(i,1)   = CheckBAConditions(collectData(i,:), 'new', 'item',  0, YesResponse);
%     SceneFalseAlarm(i,1)  = CheckBAConditions(collectData(i,:), 'new', 'scene', 0, YesResponse);
%     
%     ItemRejection(i,1)    = CheckBAConditions(collectData(i,:), 'new', 'item',  0, NoResponse);
%     SceneRejection(i,1)   = CheckBAConditions(collectData(i,:), 'new', 'scene', 0, NoResponse);
%     
% end
% 
% %%  combining item and scene
% labelstring = {'NoStim','Stim'};
% textStartY = 0.75;
% textStepY  = 0.05;
% 
% TrainedImagesCombinedResultsFig = figure('Position',figsize);
% b = bar([sum(ItemHit_NoStim + SceneHit_NoStim)/(TotalItemHitNoStim + TotalSceneHitNoStim),...
%     sum(ItemHit_Stim + SceneHit_Stim)/(TotalItemHitStim + TotalSceneHitStim)]);
% b(1).FaceColor = [0.4940 0.1840 0.5560]; % purple
% text(2.45,textStartY,'number of hits:','FontSize',18,'fontweight','bold')
% for i = 1:size(labelstring,2)
%     text(2.45,textStartY-i*textStepY,labelstring(i),'FontSize',18)
% end
% text(2.8,textStartY-1*textStepY,num2str(sum(ItemHit_NoStim + SceneHit_NoStim)),'FontSize',18)
% text(2.8,textStartY-2*textStepY,num2str(sum(ItemHit_Stim + SceneHit_Stim)),'FontSize',18)
% ylabel('Occurrences (% of Total)')
% set(gca,'YTick',0:0.25:1,'YTickLabel',100*round(0:0.25:1,2))
% set(gca,'FontName','Arial','FontSize',24,'LineWidth',2,'Box','off')
% title([subjID, ' ', imageset ' Hit Rate - Combined Item/Scene'])
% set(gca,'XTick',1:2,'XTickLabel',{'No Stim','Stim'})
% axis([0.5 3.0 0 1])
% 
% fprintf('Saving trained images - combined item/scene figure...\n')
% savefile = fullfile(cd, 'figures', subjID, imageset, strcat(subjID, '_', imageset, SureResponseString, '_TrainedImagesCombinedResults.png'));
% 
% saveas(TrainedImagesCombinedResultsFig, [savefile(1:end-4) '.png'],'png');
% fprintf('Done\n')
% 
% %%  combining item and scene - combine stim and no stim
% labelstring = {'NoStim + Stim'};
% textStartY = 0.75;
% textStepY  = 0.05;
% 
% TrainedImagesCombinedResultsCombinedStimFig = figure('Position',figsize);
% b = bar(sum(ItemHit_NoStim + SceneHit_NoStim + ItemHit_Stim + SceneHit_Stim)/...
%     (TotalItemHitNoStim + TotalSceneHitNoStim + TotalItemHitStim+TotalSceneHitStim));
% b(1).FaceColor = [0.4940 0.1840 0.5560]; % purple
% text(1.55,textStartY,'number of hits:','FontSize',18,'fontweight','bold')
% text(1.55,textStartY-1*textStepY,labelstring,'FontSize',18)
% text(1.8,textStartY-1*textStepY,num2str(sum(ItemHit_NoStim + SceneHit_NoStim + ItemHit_Stim + SceneHit_Stim)),'FontSize',18)
% ylabel('Occurrences (% of Total)')
% set(gca,'YTick',0:0.25:1,'YTickLabel',100*round(0:0.25:1,2))
% set(gca,'FontName','Arial','FontSize',24,'LineWidth',2,'Box','off')
% title([subjID, ' ', imageset ' Hit Rate - Combined Item/Scene - Combined Stim/NoStim'])
% set(gca,'XTick',1,'XTickLabel',{'Item/Scene/Stim/NoStim'})
% axis([0.5 2.0 0 1])
% 
% fprintf('Saving trained images - combined item/scene with combined stim figure...\n')
% savefile = fullfile(cd, 'figures', subjID, imageset, strcat(subjID, '_', imageset, SureResponseString, '_TrainedImagesCombinedResultsCombinedStim.png'));
% 
% saveas(TrainedImagesCombinedResultsCombinedStimFig, [savefile(1:end-4) '.png'],'png');
% fprintf('Done\n')
% 
% %% break out item and scene (hit rate out of total images)
% labelstring = {'NoStim Item','Stim Item','NoStim Scene','Stim Scene'};
% textStartY = 0.75;
% textStepY  = 0.05;
% 
% 
% TrainedImagesFig = figure('Position',figsize);
% b = bar([sum(ItemHit_NoStim)/TotalItemHitNoStim,    sum(ItemHit_Stim)/TotalItemHitStim;
%       sum(SceneHit_NoStim)/TotalSceneHitNoStim,  sum(SceneHit_Stim)/TotalSceneHitStim]);
% b(1).FaceColor = [0 0 1]; % blue
% b(2).FaceColor = [1 0 0]; % red
% 
% %Add hatches to bars
% hatchfill2(b(1),'single','HatchAngle',45, 'HatchDensity',60,'hatchcolor',[0 0 1]);
% hatchfill2(b(2),'cross','HatchAngle',45,'HatchDensity',40,'hatchcolor',[1 0 0]);
% for c = 1:numel(b)
%     b(c).FaceColor = 'none';
% end
% 
% 
% text(2.45,textStartY,'number of hits:','FontSize',18,'fontweight','bold')
% for i = 1:size(labelstring,2)
%     text(2.45,textStartY-i*textStepY,labelstring(i),'FontSize',18)
% end
% text(2.8,textStartY-1*textStepY,num2str(sum(ItemHit_NoStim)),'FontSize',18)
% text(2.8,textStartY-2*textStepY,num2str(sum(ItemHit_Stim)),'FontSize',18)
% text(2.8,textStartY-3*textStepY,num2str(sum(SceneHit_NoStim)),'FontSize',18)
% text(2.8,textStartY-4*textStepY,num2str(sum(SceneHit_Stim)),'FontSize',18)
% set(gca,'XTick',[1 2],'XTickLabel',{'item','scene'})
% ylabel('Occurrences (% of Total)')
% set(gca,'YTick',0:0.25:1,'YTickLabel',100*round(0:0.25:1,2))
% set(gca,'FontName','Arial','FontSize',24,'LineWidth',2,'Box','off')
% axis([0.5 3.0 0 1])
% title([subjID, ' ', imageset ' Hit Rate (out of total images)'])
% 
% %Create Legend
% legendData = {'No Stim', 'Stim'};
% [legend_h, object_h, plot_h, text_str] = legendflex(b, legendData, 'Padding', [2, 2, 10], 'FontSize', 18, 'Location', 'NorthEast');
% % object_h(1) is the first bar's text
% % object_h(2) is the second bar's text
% % object_h(3) is the first bar's patch
% % object_h(4) is the second bar's patch
% %
% % Set the two patches within the legend
% hatchfill2(object_h(3), 'single','HatchAngle',45, 'HatchDensity',60/4,'hatchcolor',[0 0 1]);
% hatchfill2(object_h(4), 'cross','HatchAngle',45,'HatchDensity',40/4,'hatchcolor',[1 0 0]);
% 
% 
% fprintf('Saving trained images figure...\n')
% savefile = fullfile(cd, 'figures', subjID, imageset, strcat(subjID, '_', imageset, SureResponseString,  '_TrainedImages.png'));
% 
% saveas(TrainedImagesFig, [savefile(1:end-4) '.png'],'png');
% fprintf('Done\n')
% 
% %% break out item and scene (ACTUAL hit rate -- Sure only for total number of "sure" images)
% 
% %This analysis/figure only runs when the two "sure" key responses are given
% %in lines 22/23
% if size(ResponseKeys,2) == 2
% 
%     labelstring = {'NoStim Item','Stim Item','NoStim Scene','Stim Scene'};
%     textStartY = 0.75;
%     textStepY  = 0.05;
%     
%     
%     ActualHitRateSureFig = figure('Position',figsize);
%     b = bar([sum(ItemHit_NoStim)/(sum(ItemHit_NoStim) + sum(ItemMiss_NoStim)),    sum(ItemHit_Stim)/(sum(ItemHit_Stim) + sum(ItemMiss_Stim));
%           sum(SceneHit_NoStim)/(sum(SceneHit_NoStim) + sum(SceneMiss_NoStim)),  sum(SceneHit_Stim)/(sum(SceneHit_Stim) + sum(SceneMiss_Stim))]);
%     b(1).FaceColor = [0 0 1]; % blue
%     b(2).FaceColor = [1 0 0]; % red
%     
%     %Add hatches to bars
%     hatchfill2(b(1),'single','HatchAngle',45, 'HatchDensity',60,'hatchcolor',[0 0 1]);
%     hatchfill2(b(2),'cross','HatchAngle',45,'HatchDensity',40,'hatchcolor',[1 0 0]);
%     for c = 1:numel(b)
%         b(c).FaceColor = 'none';
%     end
%     
%     
%     text(2.45,textStartY,'number of hits:','FontSize',18,'fontweight','bold')
%     for i = 1:size(labelstring,2)
%         text(2.45,textStartY-i*textStepY,labelstring(i),'FontSize',18)
%     end
%     text(2.8,textStartY-1*textStepY,strcat(num2str(sum(ItemHit_NoStim)),' (out of ',num2str(sum(ItemHit_NoStim) + sum(ItemMiss_NoStim)), ')'),'FontSize',18)
%     text(2.8,textStartY-2*textStepY,strcat(num2str(sum(ItemHit_Stim)),' (out of ',num2str(sum(ItemHit_Stim) + sum(ItemMiss_Stim)), ')'),'FontSize',18)
%     text(2.8,textStartY-3*textStepY,strcat(num2str(sum(SceneHit_NoStim)),' (out of ',num2str(sum(SceneHit_NoStim) + sum(SceneMiss_NoStim)), ')'),'FontSize',18)
%     text(2.8,textStartY-4*textStepY,strcat(num2str(sum(SceneHit_Stim)),' (out of ',num2str(sum(SceneHit_Stim) + sum(SceneMiss_Stim)), ')'),'FontSize',18)
%     set(gca,'XTick',[1 2],'XTickLabel',{'item','scene'})
%     ylabel('Occurrences (% of Sure)')
%     set(gca,'YTick',0:0.25:1,'YTickLabel',100*round(0:0.25:1,2))
%     set(gca,'FontName','Arial','FontSize',24,'LineWidth',2,'Box','off')
%     axis([0.5 3.0 0 1])
%     title([subjID, ' ', imageset ' Actual Hit Rate (out of sure only responses)'])
%     
%     %Create Legend
%     legendData = {'No Stim', 'Stim'};
%     [legend_h, object_h, plot_h, text_str] = legendflex(b, legendData, 'Padding', [2, 2, 10], 'FontSize', 18, 'Location', 'NorthEast');
%     % object_h(1) is the first bar's text
%     % object_h(2) is the second bar's text
%     % object_h(3) is the first bar's patch
%     % object_h(4) is the second bar's patch
%     %
%     % Set the two patches within the legend
%     hatchfill2(object_h(3), 'single','HatchAngle',45, 'HatchDensity',60/4,'hatchcolor',[0 0 1]);
%     hatchfill2(object_h(4), 'cross','HatchAngle',45,'HatchDensity',40/4,'hatchcolor',[1 0 0]);
%     
%     
%     fprintf('Saving trained images figure...\n')
%     savefile = fullfile(cd, 'figures', subjID, imageset, strcat(subjID, '_', imageset, SureResponseString,  '_ActualHitRateSURE.png'));
%     
%     saveas(ActualHitRateSureFig, [savefile(1:end-4) '.png'],'png');
%     fprintf('Done\n')
% 
% end
% 
% %% break out item and scene - combine stim and no stim
% labelstring = {'NoStim +Stim Item','NoStim + Stim Scene'};
% textStartY = 0.75;
% textStepY  = 0.05;
% 
% TrainedImagesCombinedStimFig = figure('Position',figsize);
%  bar([sum(ItemHit_NoStim + ItemHit_Stim)/(TotalItemHitNoStim + TotalItemHitStim);
%       sum(SceneHit_NoStim + SceneHit_Stim)/(TotalSceneHitNoStim + TotalSceneHitStim)])
% text(2.45,textStartY,'number of hits:','FontSize',18,'fontweight','bold')
% for i = 1:size(labelstring,2)
%     text(2.45,textStartY-i*textStepY,labelstring(i),'FontSize',18)
% end
% text(3.1,textStartY-1*textStepY,num2str(sum(ItemHit_NoStim + ItemHit_Stim)),'FontSize',18)
% text(3.1,textStartY-2*textStepY,num2str(sum(SceneHit_NoStim + SceneHit_Stim)),'FontSize',18)
% set(gca,'XTick',[1 2],'XTickLabel',{'item','scene'})
% ylabel('Occurrences (% of Total)')
% set(gca,'YTick',0:0.25:1,'YTickLabel',100*round(0:0.25:1,2))
% set(gca,'FontName','Arial','FontSize',24,'LineWidth',2,'Box','off')
% axis([0.5 3.5 0 1])
% title([subjID, ' ', imageset ' Hit Rate - Combined Stim/NoStim'])
% 
% fprintf('Saving trained images with combined stim figure...\n')
% savefile = fullfile(cd, 'figures', subjID, imageset, strcat(subjID, '_', imageset, SureResponseString,  '_TrainedImagesCombinedStim.png'));
% 
% saveas(TrainedImagesCombinedStimFig, [savefile(1:end-4) '.png'],'png');
% fprintf('Done\n')
% 
% %% novel - break out item and scene
% labelstring = {'Item','Scene'};
% textStartY = 0.75;
% textStepY  = 0.05;
% 
% NovelImagesFig = figure('Position',figsize);
% b = bar([sum(ItemFalseAlarm)/TotalItemFA; sum(SceneFalseAlarm)/TotalSceneFA],'FaceColor','Flat');
% b(1).FaceColor = [0.5 0.5 0.5];
% text(2.45,textStartY,'number of FAs:','FontSize',18,'fontweight','bold')
% for i = 1:size(labelstring,2)
%     text(2.45,textStartY-i*textStepY,labelstring(i),'FontSize',18)
% end
% text(2.8,textStartY-1*textStepY,num2str(sum(ItemFalseAlarm)),'FontSize',18)
% text(2.8,textStartY-2*textStepY,num2str(sum(SceneFalseAlarm)),'FontSize',18)
% set(gca,'XTick',[1 2],'XTickLabel',{'item','scene'})
% ylabel('Occurrences (% of Total)')
% set(gca,'YTick',0:0.25:1,'YTickLabel',100*round(0:0.25:1,2))
% set(gca,'FontName','Arial','FontSize',24,'LineWidth',2,'Box','off')
% axis([0.5 3.0 0 1])
% title([subjID, ' ', imageset ' False Alarm (out of total images)'])
% 
% fprintf('Saving novel images Figure...\n')
% savefile = fullfile(cd, 'figures', subjID, imageset, strcat(subjID, '_', imageset, SureResponseString, '_NovelImages.png'));
% 
% saveas(NovelImagesFig, [savefile(1:end-4) '.png'],'png');
% fprintf('Done\n')
% 
% %% novel - break out item and scene (ACTUAL FA rate -- Sure only for total number of "sure" images)
% 
% %This analysis/figure only runs when the two "sure" key responses are given
% %in lines 22/23
% if size(ResponseKeys,2) == 2
% 
%     labelstring = {'Item','Scene'};
%     textStartY = 0.75;
%     textStepY  = 0.05;
%     
%     ActualFARateSureFig = figure('Position',figsize);
%     b = bar([sum(ItemFalseAlarm)/(sum(ItemFalseAlarm) + sum(ItemRejection)); sum(SceneFalseAlarm)/(sum(SceneFalseAlarm)+ sum(SceneRejection))],'FaceColor','Flat');
%     b(1).FaceColor = [0.5 0.5 0.5];
%     text(2.45,textStartY,'number of FAs:','FontSize',18,'fontweight','bold')
%     for i = 1:size(labelstring,2)
%         text(2.45,textStartY-i*textStepY,labelstring(i),'FontSize',18)
%     end
%     text(2.8,textStartY-1*textStepY,strcat(num2str(sum(ItemFalseAlarm)),' (out of ',num2str(sum(ItemFalseAlarm) + sum(ItemRejection)), ')'),'FontSize',18)
%     text(2.8,textStartY-2*textStepY,strcat(num2str(sum(SceneFalseAlarm)),' (out of ',num2str(sum(SceneFalseAlarm) + sum(SceneRejection)), ')'),'FontSize',18)
%     set(gca,'XTick',[1 2],'XTickLabel',{'item','scene'})
%     ylabel('Occurrences (% of Sure)')
%     set(gca,'YTick',0:0.25:1,'YTickLabel',100*round(0:0.25:1,2))
%     set(gca,'FontName','Arial','FontSize',24,'LineWidth',2,'Box','off')
%     axis([0.5 3.0 0 1])
%     title([subjID, ' ', imageset ' Actual False Alarm (out of sure only responses)'])
%     
%     fprintf('Saving novel images Figure...\n')
%     savefile = fullfile(cd, 'figures', subjID, imageset, strcat(subjID, '_', imageset, SureResponseString, '_ActualFArateSure.png'));
%     
%     saveas(ActualFARateSureFig, [savefile(1:end-4) '.png'],'png');
%     fprintf('Done\n')
% end
% 
% %% d prime
% [dp(1,1), c(1)] = dprime_simple(sum(ItemHit_NoStim)/TotalItemHitNoStim,sum(ItemFalseAlarm)/TotalItemFA);         % nostim item
% [dp(1,2), c(2)] = dprime_simple(sum(ItemHit_Stim)/TotalItemHitStim,sum(ItemFalseAlarm)/TotalItemFA);             % stim item
% [dp(2,1), c(3)] = dprime_simple(sum(SceneHit_NoStim)/TotalSceneHitNoStim,sum(SceneFalseAlarm)/TotalSceneFA);     % nostim scene
% [dp(2,2), c(4)] = dprime_simple(sum(SceneHit_Stim)/TotalSceneHitStim,sum(SceneFalseAlarm)/TotalSceneFA);         % stim scene
% [dp(3,1), c(5)] = dprime_simple(sum(ItemHit_NoStim+SceneHit_NoStim)/(TotalItemHitNoStim+TotalSceneHitNoStim),... % nostim overall
%                     sum(ItemFalseAlarm+SceneFalseAlarm)/(TotalItemFA+TotalSceneFA)); 
% [dp(3,2), c(6)] = dprime_simple(sum(ItemHit_Stim+SceneHit_Stim)/(TotalItemHitStim+TotalSceneHitStim),...         % stim overall
%                     sum(ItemFalseAlarm+SceneFalseAlarm)/(TotalItemFA+TotalSceneFA)); 
% 
% dp(isinf(dp)) = NaN;
% 
% %For y axis limit locked at 4.0
% ylim = [min([min(dp,[],'omitnan'),0])-0.1 max(4.0)];
% 
% %For variable y axis limit
% %ylim = [min([min(dp,[],'omitnan'),0])-0.1 max([max(dp,[],'omitnan'),0])+0.1];
%           
% clabelstring    = {'item nostim', 'item stim', 'scene nostim', 'scene stim', 'overall nostim', 'overall stim'};
% textStartY = max(max(dp,[],'omitnan')) - 0.15*max(max(dp,[],'omitnan'));
% textStepY  = max(max(dp,[],'omitnan'))/20;
% 
% dprimefig = figure('Position',figsize);
% b = bar(dp);
% b(1).FaceColor = [0 0 1]; % blue
% b(2).FaceColor = [1 0 0]; % red
% text(3.5,3.0,'Criterion:','FontSize',18,'fontweight','bold')
% text(3.5,2.3,'Dprime:','FontSize',18,'fontweight','bold')
% 
% 
% %Plot dprime values
% DText1 = {'Item NoStim: '};
% DText1a = {strcat('  ',num2str(dp(1,1),3))};
% DText2 = {'Item Stim: '};
% DText2a = {strcat('  ',num2str(dp(1,2),3))};
% DText3 = {'Scene NoStim: '};
% DText3a = {strcat('  ',num2str(dp(2,1),3))};
% DText4 = {'Scene Stim: '};
% DText4a = {strcat('  ',num2str(dp(2,2),3))};
% DText5 = {'Overall NoStim: '};
% DText5a = {strcat('  ',num2str(dp(3,1),3))};
% DText6 = {'Overall Stim: '};
% DText6a = {strcat('  ',num2str(dp(3,2),3))};
% 
% 
% text(3.5, 2.2, DText1,'FontSize',15)
% text(4.0, 2.2, DText1a,'FontSize',15)
% text(3.5, 2.1, DText2,'FontSize',15)
% text(4.0, 2.1, DText2a,'FontSize',15)
% text(3.5, 2.0, DText3,'FontSize',15)
% text(4.0, 2.0, DText3a,'FontSize',15)
% text(3.5, 1.9, DText4,'FontSize',15)
% text(4.0, 1.9, DText4a,'FontSize',15)
% text(3.5, 1.8, DText5,'FontSize',15)
% text(4.0, 1.8, DText5a,'FontSize',15)
% text(3.5, 1.7, DText6,'FontSize',15)
% text(4.0, 1.7, DText6a,'FontSize',15)
% 
% 
% 
% 
% 
% 
% 
% %Plot Criterion text for when yaxis is locked at dprime of 4.0
% Text1 = {'Item NoStim: '};
% Text1a = {strcat('  ',num2str(c(1),3))};
% Text2 = {'Item Stim: '};
% Text2a = {strcat('  ',num2str(c(2),3))};
% Text3 = {'Scene NoStim: '};
% Text3a = {strcat('  ',num2str(c(3),3))};
% Text4 = {'Scene Stim: '};
% Text4a = {strcat('  ',num2str(c(4),3))};
% Text5 = {'Overall NoStim: '};
% Text5a = {strcat('  ',num2str(c(5),3))};
% Text6 = {'Overall Stim: '};
% Text6a = {strcat('  ',num2str(c(6),3))};
% 
% 
% text(3.5, 2.9, Text1,'FontSize',15)
% text(4.0, 2.9, Text1a,'FontSize',15)
% text(3.5, 2.8, Text2,'FontSize',15)
% text(4.0, 2.8, Text2a,'FontSize',15)
% text(3.5, 2.7, Text3,'FontSize',15)
% text(4.0, 2.7, Text3a,'FontSize',15)
% text(3.5, 2.6, Text4,'FontSize',15)
% text(4.0, 2.6, Text4a,'FontSize',15)
% text(3.5, 2.5, Text5,'FontSize',15)
% text(4.0, 2.5, Text5a,'FontSize',15)
% text(3.5, 2.4, Text6,'FontSize',15)
% text(4.0, 2.4, Text6a,'FontSize',15)
% 
% 
% %Plot criterion text if you have yaxis changing based on dprime vaues and
% %not locked
% % for i = 1:numel(c)
% %     text(3.35,textStartY-i*textStepY,clabelstring(i),'FontSize',18)
% %     if c(i)<0
% %     	text(3.965,textStartY-i*textStepY,num2str(c(i),3),'FontSize',18)
% %     else
% %         text(4,textStartY-i*textStepY,num2str(c(i),3),'FontSize',18)
% %     end
% % end
% 
% set(gca,'XTick',[1:3],'XTickLabel',{'item','scenes','overall'})
% ylabel('dprime')
% set(gca,'FontName','Arial','FontSize',24,'LineWidth',2,'Box','off')
% axis([0.5 4.5 ylim])
% legend('No Stim','Stim')
% title([subjID, ' ', imageset ' Discrimination Index (out of total images)'])
% 
% %Create plot text that lists the difference in dprime for stim vs. nostim
% %The 3 within the num2str function is the precision parameter for number of
% %significant decimal points
% plottext1 = {'Item Diff: '};
% plottext2 = {strcat('  ',num2str(abs(dprime_simple(sum(ItemHit_NoStim)/TotalItemHitNoStim,sum(ItemFalseAlarm)/TotalItemFA)-dprime_simple(sum(ItemHit_Stim)/TotalItemHitStim,sum(ItemFalseAlarm)/TotalItemFA)),3))};
% plottext3 = {'Scene Diff: '};
% plottext4 = {strcat('  ',num2str(abs(dprime_simple(sum(SceneHit_NoStim)/TotalSceneHitNoStim,sum(SceneFalseAlarm)/TotalSceneFA)-dprime_simple(sum(SceneHit_Stim)/TotalSceneHitStim,sum(SceneFalseAlarm)/TotalSceneFA)),3))};
% plottext5 = {'Overall Diff: '};
% plottext6 = {strcat('  ',num2str(abs(dprime_simple(sum(ItemHit_NoStim+SceneHit_NoStim)/(TotalItemHitNoStim+TotalSceneHitNoStim),sum(ItemFalseAlarm+SceneFalseAlarm)/(TotalItemFA+TotalSceneFA))-dprime_simple(sum(ItemHit_Stim+SceneHit_Stim)/(TotalItemHitStim+TotalSceneHitStim),sum(ItemFalseAlarm+SceneFalseAlarm)/(TotalItemFA+TotalSceneFA))),3))};
% 
% %Set the positioning of the above text
% text(0.8, 3.8, plottext1,'FontSize',19)
% text(0.8, 3.6, plottext2,'FontSize',19)
% 
% text(1.8, 3.8, plottext3,'FontSize',19)
% text(1.8, 3.6, plottext4,'FontSize',19)
% 
% text(2.8, 3.8, plottext5,'FontSize',19)
% text(2.8, 3.6, plottext6,'FontSize',19)
% 
% fprintf('Saving d prime figure...\n')
% savefile = fullfile(cd, 'figures', subjID, imageset, strcat(subjID, '_', imageset, SureResponseString,  '_dprime.png'));
% 
% saveas(dprimefig, [savefile(1:end-4) '.png'],'png');
% fprintf('Done\n')
% 
% 
% 
% %% d prime (ACTUAL dprime -- Sure only for total number of "sure" images)
% 
% %This analysis/figure only runs when the two "sure" key responses are given
% %in lines 22/23
% if size(ResponseKeys,2) == 2 
% 
%     [dp(1,1), c(1)] = dprime_simple(sum(ItemHit_NoStim)/(sum(ItemHit_NoStim) + sum(ItemMiss_NoStim)),sum(ItemFalseAlarm)/(sum(ItemFalseAlarm) + sum(ItemRejection)));         % nostim item
%     [dp(1,2), c(2)] = dprime_simple(sum(ItemHit_Stim)/(sum(ItemHit_Stim) + sum(ItemMiss_Stim)),sum(ItemFalseAlarm)/(sum(ItemFalseAlarm) + sum(ItemRejection)));             % stim item
%     [dp(2,1), c(3)] = dprime_simple(sum(SceneHit_NoStim)/(sum(SceneHit_NoStim) + sum(SceneMiss_NoStim)),sum(SceneFalseAlarm)/(sum(SceneFalseAlarm)+ sum(SceneRejection)));     % nostim scene
%     [dp(2,2), c(4)] = dprime_simple(sum(SceneHit_Stim)/(sum(SceneHit_Stim) + sum(SceneMiss_Stim)),sum(SceneFalseAlarm)/(sum(SceneFalseAlarm)+ sum(SceneRejection)));         % stim scene
%     [dp(3,1), c(5)] = dprime_simple(sum(ItemHit_NoStim+SceneHit_NoStim)/(sum(ItemHit_NoStim) + sum(ItemMiss_NoStim) + sum(SceneHit_NoStim) + sum(SceneMiss_NoStim)),... % nostim overall
%                         sum(ItemFalseAlarm+SceneFalseAlarm)/((sum(ItemFalseAlarm) + sum(ItemRejection) + sum(SceneFalseAlarm)+ sum(SceneRejection)))); 
%     [dp(3,2), c(6)] = dprime_simple(sum(ItemHit_Stim+SceneHit_Stim)/(sum(ItemHit_Stim) + sum(ItemMiss_Stim) + sum(SceneHit_Stim) + sum(SceneMiss_Stim)),...         % stim overall
%                         sum(ItemFalseAlarm+SceneFalseAlarm)/((sum(ItemFalseAlarm) + sum(ItemRejection) + sum(SceneFalseAlarm)+ sum(SceneRejection)))); 
%     
%     dp(isinf(dp)) = NaN;
%     
%     %For y axis limit locked at 4.0
%     ylim = [min([min(dp,[],'omitnan'),0])-0.1 max(4.0)];
%     
%     %For variable y axis limit
%     %ylim = [min([min(dp,[],'omitnan'),0])-0.1 max([max(dp,[],'omitnan'),0])+0.1];
%               
%     clabelstring    = {'item nostim', 'item stim', 'scene nostim', 'scene stim', 'overall nostim', 'overall stim'};
%     textStartY = max(max(dp,[],'omitnan')) - 0.15*max(max(dp,[],'omitnan'));
%     textStepY  = max(max(dp,[],'omitnan'))/20;
%     
%     Actualdprimefig = figure('Position',figsize);
%     b = bar(dp);
%     b(1).FaceColor = [0 0 1]; % blue
%     b(2).FaceColor = [1 0 0]; % red
%     text(3.5,3.0,'Criterion:','FontSize',18,'fontweight','bold')
%     text(3.5,2.3,'Dprime:','FontSize',18,'fontweight','bold')
%     
%     
%     %Plot dprime values
%     DText1 = {'Item NoStim: '};
%     DText1a = {strcat('  ',num2str(dp(1,1),3))};
%     DText2 = {'Item Stim: '};
%     DText2a = {strcat('  ',num2str(dp(1,2),3))};
%     DText3 = {'Scene NoStim: '};
%     DText3a = {strcat('  ',num2str(dp(2,1),3))};
%     DText4 = {'Scene Stim: '};
%     DText4a = {strcat('  ',num2str(dp(2,2),3))};
%     DText5 = {'Overall NoStim: '};
%     DText5a = {strcat('  ',num2str(dp(3,1),3))};
%     DText6 = {'Overall Stim: '};
%     DText6a = {strcat('  ',num2str(dp(3,2),3))};
%     
%     
%     text(3.5, 2.2, DText1,'FontSize',15)
%     text(4.0, 2.2, DText1a,'FontSize',15)
%     text(3.5, 2.1, DText2,'FontSize',15)
%     text(4.0, 2.1, DText2a,'FontSize',15)
%     text(3.5, 2.0, DText3,'FontSize',15)
%     text(4.0, 2.0, DText3a,'FontSize',15)
%     text(3.5, 1.9, DText4,'FontSize',15)
%     text(4.0, 1.9, DText4a,'FontSize',15)
%     text(3.5, 1.8, DText5,'FontSize',15)
%     text(4.0, 1.8, DText5a,'FontSize',15)
%     text(3.5, 1.7, DText6,'FontSize',15)
%     text(4.0, 1.7, DText6a,'FontSize',15)
%     
%     
%     
%     
%     
%     
%     
%     %Plot Criterion text for when yaxis is locked at dprime of 4.0
%     Text1 = {'Item NoStim: '};
%     Text1a = {strcat('  ',num2str(c(1),3))};
%     Text2 = {'Item Stim: '};
%     Text2a = {strcat('  ',num2str(c(2),3))};
%     Text3 = {'Scene NoStim: '};
%     Text3a = {strcat('  ',num2str(c(3),3))};
%     Text4 = {'Scene Stim: '};
%     Text4a = {strcat('  ',num2str(c(4),3))};
%     Text5 = {'Overall NoStim: '};
%     Text5a = {strcat('  ',num2str(c(5),3))};
%     Text6 = {'Overall Stim: '};
%     Text6a = {strcat('  ',num2str(c(6),3))};
%     
%     
%     text(3.5, 2.9, Text1,'FontSize',15)
%     text(4.0, 2.9, Text1a,'FontSize',15)
%     text(3.5, 2.8, Text2,'FontSize',15)
%     text(4.0, 2.8, Text2a,'FontSize',15)
%     text(3.5, 2.7, Text3,'FontSize',15)
%     text(4.0, 2.7, Text3a,'FontSize',15)
%     text(3.5, 2.6, Text4,'FontSize',15)
%     text(4.0, 2.6, Text4a,'FontSize',15)
%     text(3.5, 2.5, Text5,'FontSize',15)
%     text(4.0, 2.5, Text5a,'FontSize',15)
%     text(3.5, 2.4, Text6,'FontSize',15)
%     text(4.0, 2.4, Text6a,'FontSize',15)
%     
%     
%     %Plot criterion text if you have yaxis changing based on dprime vaues and
%     %not locked
%     % for i = 1:numel(c)
%     %     text(3.35,textStartY-i*textStepY,clabelstring(i),'FontSize',18)
%     %     if c(i)<0
%     %     	text(3.965,textStartY-i*textStepY,num2str(c(i),3),'FontSize',18)
%     %     else
%     %         text(4,textStartY-i*textStepY,num2str(c(i),3),'FontSize',18)
%     %     end
%     % end
%     
%     set(gca,'XTick',[1:3],'XTickLabel',{'item','scenes','overall'})
%     ylabel('dprime (sure only)')
%     set(gca,'FontName','Arial','FontSize',24,'LineWidth',2,'Box','off')
%     axis([0.5 4.5 ylim])
%     legend('No Stim','Stim')
%     title([subjID, ' ', imageset ' Actual Discrimination Index (out of sure only responses)'])
%     
%     %Create plot text that lists the difference in dprime for stim vs. nostim
%     %The 3 within the num2str function is the precision parameter for number of
%     %significant decimal points
%     plottext1 = {'Item Diff: '};
%     plottext2 = {strcat('  ',num2str(abs(dprime_simple(sum(ItemHit_NoStim)/(sum(ItemHit_NoStim) + sum(ItemMiss_NoStim)),sum(ItemFalseAlarm)/(sum(ItemFalseAlarm) + sum(ItemRejection)))-dprime_simple(sum(ItemHit_Stim)/(sum(ItemHit_Stim) + sum(ItemMiss_Stim)),sum(ItemFalseAlarm)/(sum(ItemFalseAlarm) + sum(ItemRejection)))),3))};
%     plottext3 = {'Scene Diff: '};
%     plottext4 = {strcat('  ',num2str(abs(dprime_simple(sum(SceneHit_NoStim)/(sum(SceneHit_NoStim) + sum(SceneMiss_NoStim)),sum(SceneFalseAlarm)/(sum(SceneFalseAlarm)+ sum(SceneRejection)))-dprime_simple(sum(SceneHit_Stim)/(sum(SceneHit_Stim) + sum(SceneMiss_Stim)),sum(SceneFalseAlarm)/(sum(SceneFalseAlarm)+ sum(SceneRejection)))),3))};
%     plottext5 = {'Overall Diff: '};
%     plottext6 = {strcat('  ',num2str(abs(dprime_simple(sum(ItemHit_NoStim+SceneHit_NoStim)/(sum(ItemHit_NoStim) + sum(ItemMiss_NoStim) + sum(SceneHit_NoStim) + sum(SceneMiss_NoStim)),sum(ItemFalseAlarm+SceneFalseAlarm)/((sum(ItemFalseAlarm) + sum(ItemRejection) + sum(SceneFalseAlarm)+ sum(SceneRejection))))-dprime_simple(sum(ItemHit_Stim+SceneHit_Stim)/(sum(ItemHit_Stim) + sum(ItemMiss_Stim) + sum(SceneHit_Stim) + sum(SceneMiss_Stim)),sum(ItemFalseAlarm+SceneFalseAlarm)/((sum(ItemFalseAlarm) + sum(ItemRejection) + sum(SceneFalseAlarm)+ sum(SceneRejection))))),3))};
%     
%     %Set the positioning of the above text
%     text(0.8, 3.8, plottext1,'FontSize',19)
%     text(0.8, 3.6, plottext2,'FontSize',19)
%     
%     text(1.8, 3.8, plottext3,'FontSize',19)
%     text(1.8, 3.6, plottext4,'FontSize',19)
%     
%     text(2.8, 3.8, plottext5,'FontSize',19)
%     text(2.8, 3.6, plottext6,'FontSize',19)
%     
%     fprintf('Saving d prime figure...\n')
%     savefile = fullfile(cd, 'figures', subjID, imageset, strcat(subjID, '_', imageset, SureResponseString,  '_ActualSuredprime.png'));
%     
%     saveas(Actualdprimefig, [savefile(1:end-4) '.png'],'png');
%     fprintf('Done\n')
% 
% end
% 
% 
% %% d prime - combined stim and no stim
% [dp_CombinedStim(1,1), c_CombinedStim(1)] = dprime_simple(sum(ItemHit_NoStim + ItemHit_Stim)/...
%                                                 (TotalItemHitNoStim + TotalItemHitStim),sum(ItemFalseAlarm)/TotalItemFA);           % item
% [dp_CombinedStim(2,1), c_CombinedStim(2)] = dprime_simple(sum(SceneHit_NoStim + SceneHit_Stim)/...
%                                                 (TotalSceneHitNoStim + TotalSceneHitStim),sum(SceneFalseAlarm)/TotalSceneFA);       % scene
% [dp_CombinedStim(3,1), c_CombinedStim(3)] = dprime_simple(sum(ItemHit_NoStim+SceneHit_NoStim + ItemHit_Stim + SceneHit_Stim)/...
%                                                 (TotalItemHitNoStim+TotalSceneHitNoStim + TotalItemHitStim + TotalSceneHitStim),... % nostim overall
%                                                     sum(ItemFalseAlarm+SceneFalseAlarm)/(TotalItemFA+TotalSceneFA)); 
%                                                 
% dp_CombinedStim(isinf(dp_CombinedStim)) = NaN;
% 
% ylim = [min([min(dp_CombinedStim,[],'omitnan'),0])-0.1 max([max(dp_CombinedStim,[],'omitnan'),0])+0.1];
%                                                 
% clabelstring    = {'item','scene','overall'};
% textStartY = max(max(dp_CombinedStim,[],'omitnan')) - 0.15*max(max(dp_CombinedStim,[],'omitnan'));
% textStepY  = max(max(dp_CombinedStim,[],'omitnan'))/20;
% 
% dprimeCombinedStimfig = figure('Position',figsize);
% b = bar(dp_CombinedStim);
% b(1).FaceColor = [0.3010 0.7450 0.9330]; % blue
% text(3.5,textStartY,'criterion:','FontSize',18,'fontweight','bold')
% for i = 1:numel(c_CombinedStim)
%     text(3.5,textStartY-i*textStepY,clabelstring(i),'FontSize',18)
%     if c_CombinedStim(i)<0
%     	text(3.965,textStartY-i*textStepY,num2str(c_CombinedStim(i)),'FontSize',18)
%     else
%         text(4,textStartY-i*textStepY,num2str(c_CombinedStim(i)),'FontSize',18)
%     end
% end
% set(gca,'XTick',[1:3],'XTickLabel',{'item','scenes','overall'})
% ylabel('dprime')
% set(gca,'FontName','Arial','FontSize',24,'LineWidth',2,'Box','off')
% axis([0.5 4.5 ylim])
% title([subjID, ' ', imageset ' Discrimination Index - Combined Stim/NoStim (out of total images)'])
% 
% fprintf('Saving d prime with combined stim figure...\n')
% savefile = fullfile(cd, 'figures', subjID, imageset, strcat(subjID, '_', imageset, SureResponseString,  '_dprimeCombinedStim.png'));
% 
% saveas(dprimeCombinedStimfig, [savefile(1:end-4) '.png'],'png');
% fprintf('Done\n')
% 
% 
% 
% %% d prime - combined stim and no stim (ACTUAL dprime -- Sure only for total number of "sure" images)
% 
% %This analysis/figure only runs when the two "sure" key responses are given
% %in lines 22/23
% if size(ResponseKeys,2) == 2
% 
%     [dp_CombinedStim(1,1), c_CombinedStim(1)] = dprime_simple(sum(ItemHit_NoStim + ItemHit_Stim)/...
%                                                     (sum(ItemHit_NoStim + ItemHit_Stim) + sum(ItemMiss_NoStim + ItemMiss_Stim)),sum(ItemFalseAlarm)/(sum(ItemFalseAlarm) + sum(ItemRejection)));           % item
%     [dp_CombinedStim(2,1), c_CombinedStim(2)] = dprime_simple(sum(SceneHit_NoStim + SceneHit_Stim)/...
%                                                     (sum(SceneHit_NoStim + SceneHit_Stim) + sum(SceneMiss_NoStim + SceneMiss_Stim)),sum(SceneFalseAlarm)/(sum(SceneFalseAlarm) + sum(SceneRejection)));       % scene
%     [dp_CombinedStim(3,1), c_CombinedStim(3)] = dprime_simple(sum(ItemHit_NoStim+SceneHit_NoStim + ItemHit_Stim + SceneHit_Stim)/...
%                                                     (sum(ItemHit_NoStim + ItemHit_Stim + ItemMiss_NoStim + ItemMiss_Stim + SceneHit_NoStim + SceneHit_Stim + SceneMiss_NoStim + SceneMiss_Stim)),... % nostim overall
%                                                         sum(ItemFalseAlarm+SceneFalseAlarm)/(sum(ItemFalseAlarm + ItemRejection + SceneFalseAlarm + SceneRejection))); 
%                                                     
%     dp_CombinedStim(isinf(dp_CombinedStim)) = NaN;
%     
%     ylim = [min([min(dp_CombinedStim,[],'omitnan'),0])-0.1 max([max(dp_CombinedStim,[],'omitnan'),0])+0.1];
%                                                     
%     clabelstring    = {'item','scene','overall'};
%     textStartY = max(max(dp_CombinedStim,[],'omitnan')) - 0.15*max(max(dp_CombinedStim,[],'omitnan'));
%     textStepY  = max(max(dp_CombinedStim,[],'omitnan'))/20;
%     
%     ActualdprimeCombinedStimfig = figure('Position',figsize);
%     b = bar(dp_CombinedStim);
%     b(1).FaceColor = [0.3010 0.7450 0.9330]; % blue
%     text(3.5,textStartY,'criterion:','FontSize',18,'fontweight','bold')
%     for i = 1:numel(c_CombinedStim)
%         text(3.5,textStartY-i*textStepY,clabelstring(i),'FontSize',18)
%         if c_CombinedStim(i)<0
%     	    text(3.965,textStartY-i*textStepY,num2str(c_CombinedStim(i)),'FontSize',18)
%         else
%             text(4,textStartY-i*textStepY,num2str(c_CombinedStim(i)),'FontSize',18)
%         end
%     end
%     set(gca,'XTick',[1:3],'XTickLabel',{'item','scenes','overall'})
%     ylabel('dprime (sure only)')
%     set(gca,'FontName','Arial','FontSize',24,'LineWidth',2,'Box','off')
%     axis([0.5 4.5 ylim])
%     title([subjID, ' ', imageset ' Actual Discrimination Index - Combined Stim/NoStim (out of sure only responses)'])
%     
%     fprintf('Saving d prime with combined stim figure...\n')
%     savefile = fullfile(cd, 'figures', subjID, imageset, strcat(subjID, '_', imageset, SureResponseString,  '_ActualSuredprimeCombinedStim.png'));
%     
%     saveas(ActualdprimeCombinedStimfig, [savefile(1:end-4) '.png'],'png');
%     fprintf('Done\n')
% 
% end
% 
% 
% 
% end
% 
% function output = CheckBAConditions(data,novelty,type,stim,KeyDownPressed)
% 
% if strcmp(data{4},novelty) && data{3} == stim && contains(data{2},type) && any(ismember(KeyDownPressed,data{5})) % (data{5} == KeyDownPressed(1) || data{5} == KeyDownPressed(2))
%     output = 1;
% else
%     output = 0;
% end
% 
% end
% 
% function [TotalNoveltyTypeStim] = GetBA_MaxPossible(data,novelty,type,stim)
% 
% for i = 1:size(data,1)
%     NoveltyPossible(i) = contains(data{i,4},novelty);
% 
%     TypePossible(i)  = contains(data{i,2},type);
%     
%     StimPossible(i)   = isequal(data{i,3},stim);
% end
% 
% NoveltyTypeStimPossible  = NoveltyPossible.*TypePossible.*StimPossible;
% TotalNoveltyTypeStim     = sum(NoveltyTypeStimPossible);
% 
% 
% end
% 
% function [collectData] = fixConfoundedImages(collectData, subjID, imageset)
% 
% if strcmp(subjID,'SLCH002') && strcmp(imageset,'imageset1')
%     
%     [~,~,uniqueNdx] = unique([collectData{:,6}],'stable');
% 
%     iter      = 1;
%     iter2     = 1;
%     confounds = [];
%     for i = 1:length(uniqueNdx)
%        if uniqueNdx(i) < iter
%            confounds(iter2) = i;
%            iter2 = iter2 + 1;
%        else
%            iter = iter + 1;
%        end
%     end
%     
%     collectData(confounds,:) = [];
%     
% elseif strcmp(subjID,'SLCH002') && strcmp(imageset,'imageset3')
%     
%     ReversalLearningImages_E ={'003a';'010a';'013a';'016a';'021a';'022a';'027a';'031a';'034a';'037a';'038a';'039a';...
%         '052a';'054a';'055a';'124a';'128a';'131a';'132a';'142a';'146a';'147a';'156a';'160a';'171a';'178a';'184a';'191a'};
% 
%     confounds = false(size(collectData,1),1);
%     for i = 1:size(collectData,1)
%         for j = 1:size(ReversalLearningImages_E,1)
%             if contains(collectData{i,1},strcat('Set-E-',ReversalLearningImages_E{j}))
%                 confounds(i) = true;
%             end
%         end
%     end
%     collectData(confounds,:) = [];
% 
% end
% end