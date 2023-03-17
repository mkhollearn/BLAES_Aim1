 % BCI2000 Stimulus Presentation Demo Script
% 
% StimulusPresentationScript_Demo creates a parameter fragment that can be
% loaded into BCI2000 to create a stimulus presentation experiment.
% 
% This demo script will take the image files located in the BCI2000 prog
% directory and create a stimuli matrix containing these images, variable
% duration fixation cross stimuli, instructions, and a sync pulse. 
% 
% Change the n_rows and total_events variables to store more information with
% the stimuli or add additional stimuli. Best practice is to separate
% stimuli into banks (e.g. 1-25, 101-125, etc) for easy evaluation later. 
% 
% Note that every stimulus needs to have an index for every row desired,
% even if that row label is not meaningful for the stimulus.
% 
% A sequence is created to alternate the fixation cross stimuli with the
% image stimuli.
% 
% The stimuli and meaningful parameters are written into a param
% variable and stored as a *.prm file using the convert_bciprm function.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Author: Martina Hollearn <martina.hollearn@psych.utah.edu>
%%
%% $BEGIN_BCI2000_LICENSE$
%% 
%% This file is part of BCI2000, a platform for real-time bio-signal research.
%% [ Copyright (C) 2000-2021: BCI2000 team and many external contributors ]
%% 
%% BCI2000 is free software: you can redistribute it and/or modify it under the
%% terms of the GNU General Public License as published by the Free Software
%% Foundation, either version 3 of the License, or (at your option) any later
%% version.
%% 
%% BCI2000 is distributed in the hope that it will be useful, but
%%                         WITHOUT ANY WARRANTY
%% - without even the implied warranty of MERCHANTABILITY or FITNESS FOR
%% A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
%% 
%% You should have received a copy of the GNU General Public License along with
%% this program.  If not, see <http://www.gnu.org/licenses/>.
%% 
%% $END_BCI2000_LICENSE$
%% http://www.bci2000.org 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%rng(100)


clear;
close all;

if isunix
    slash = '/';
else
    slash = '\';
end


%% Set the path of the BCI2000 main directory here
%settings.BCI2000path = 'C:\Users\Brunnerlab\Desktop\BLAES_Aim1\Aim1_LongDelay';
settings.BCI2000path = fullfile('C:','Paradigms');

% Add BCI2000 tools to path
addpath(genpath(fullfile(cd,'BCI2000Tools')))


%% Settings
settings.SamplingRate          = '2000'; % device sampling rate
settings.SampleBlockSize       = '8';     % number of samples in a block - what's this?

settings.StimulationDuration   = '1s';

settings.PreRunDuration        = '2s';
settings.PostRunDuration       = '0.5s';
settings.TaskDuration          = '3s'; %changed to 3s
settings.TestDuration          = '1000s';
settings.InstructionDuration   = '64000s';
settings.SyncPulseDuration     = '1s';
settings.BaselineMinDuration   = '0.5s';
settings.BaselineMaxDuration   = '1.5s';
settings.NumberOfSequences     = '1';
settings.StimulusWidth         = '40';
settings.WindowTop             = '0';
settings.WindowLeft            = '0';
settings.WindowWidth           = '640';
settings.WindowHeight          = '480';
settings.BackgroundColor       = '0xFFFFFF';
settings.CaptionColor          = '0x000000';
settings.CaptionSwitch         = '1';
settings.WindowBackgroundColor = '0xFFFFFF';
settings.StudyISI              = '4s';
settings.FixationMin           = '0.5';
settings.FixationMax           = '1.5';
settings.SubjectName           = 'BCI';
settings.DataDirectory         = fullfile('..',slash,',,', slash, 'data');
settings.SubjectSession        = 'auto';
settings.SubjectRun            = '01';
settings.parm_filename         = fullfile(settings.BCI2000path,'parms','BLAES_Aim1','Aim1_LongDelay'); %where the parm file is going and rename it to spec the task name
settings.UserComment           = 'Enter user comment here';

settings.instructionpath   = fullfile(settings.BCI2000path, 'tasks','BLAES_Aim1', 'Aim1_LongDelay', 'instructions');
settings.fixationcrosspath = fullfile('..','fixation_cross');
settings.confidencepath    = dir(fullfile(settings.BCI2000path, 'tasks', 'BLAES_Aim1', 'Aim1_LongDelay', 'LongDelay_images_RO', '*.PNG'));
settings.prac_confpath     = dir(fullfile(settings.BCI2000path, 'tasks', 'BLAES_Aim1', 'Aim1_LongDelay', 'practice_conf_RO', '*.PNG'));


%% Get task images
ALL_IMAGES = dir(fullfile(settings.BCI2000path,'tasks', 'BLAES_Aim1', 'Aim1_LongDelay','LongDelay_images','*.PNG')); % We need to keep this for later!
idxes = 1:size(ALL_IMAGES,1);
idxes = idxes';
idxes = num2cell(idxes);
[ALL_IMAGES.idx] = idxes{:};

task_images = struct2cell(ALL_IMAGES)';

i = 1;
for idx=1:size(task_images,1)-1
    if mod(idx,2) ~= 0
        task_pairs{i,1} = task_images{idx,1}; %A image name
        task_pairs{i,2} = task_images{idx+1,1}; %B image name
        task_pairs{i,5} = task_images{idx,7}; % A image IDX
        task_pairs{i,6} = task_images{idx+1,7}; % B image IDX
        i = i + 1;
    end
end

% If you want deterministic randomization. Maybe use subject number here?
%rng(5);

% Shuffle the images
rd = randperm(size(task_pairs,1));
task_pairs = task_pairs(rd,:);

%% Condition numbers
%original number of conditions per trials is 30, like 30stimTargets and 30
%nostimTargets
% Study
n_study_breakouts = 2;
n_study_images_per_breakout_per_novelty_condition = 80; 


% Test
n_test_breakouts = 4;
n_test_images_per_breakout_per_novelty_condition = 40;

n_stim_targ = 80;
n_nostim_targ = 80;
n_new = 160;

%% Segment Conditions

%NOTES
%total_images_used is number of image pairs used
%task_images filtered are the image pairs with corresponding stim and novelty conditions and indices used in the task
%task images is list of all images available (not formatted into image pairs)
%task_pairs is the image pairs available to use(formatted into image pairs with corresponding stim and novelyt cond and indices


total_images_used = 0;

for i=1:n_stim_targ+1
    task_pairs{i,3} = 1; % Stim
    task_pairs{i,4} = 'Targ'; %
end
total_images_used = total_images_used + n_stim_targ + 1;

for i=total_images_used:total_images_used+n_nostim_targ
    task_pairs{i,3} = 0; % No Stim
    task_pairs{i,4} = 'Targ'; %
end
total_images_used = total_images_used + n_nostim_targ;

for i=total_images_used:total_images_used+n_new-1
    task_pairs{i,3} = 0; % No Stim
    task_pairs{i,4} = 'New'; %
end
total_images_used = total_images_used + n_new-1;

%need to use these non-chosen images's image A for the 'New' novelty
%condition
for i=1:total_images_used
    task_images_filtered{i,1} = task_pairs{i,1};
    task_images_filtered{i,2} = task_pairs{i,3};
    task_images_filtered{i,3} = task_pairs{i,4};
    task_images_filtered{i,4} = task_pairs{i,5};
end

% % read in existing prac image folder and w/o shuffling
% % create the prac image set
practice_images = dir(fullfile(settings.BCI2000path,'tasks', 'BLAES_Aim1', 'Aim1_LongDelay','practice_images','*.PNG'));
prac_idxes = 1:size(practice_images,1);
prac_idxes = prac_idxes';
prac_idxes = num2cell(prac_idxes);
[practice_images.idx] = prac_idxes{:};
prac_images = struct2cell(practice_images)';

i = 1;
for prac_idx=1:size(prac_images,1)
        practice_pairs{i,1} = prac_images{prac_idx,1};
        practice_pairs{i,4} = prac_images{prac_idx,7}; % A image IDX
        i = i + 1;
end

for i=1:size(prac_images,1)
    practice_pairs{i,2} = 0; % No Stim
end

%add condition label to practice images
practice_pairs{1,3} = 'Targ';
practice_pairs{2,3} = 'New';
practice_pairs{3,3} = 'New';
practice_pairs{4,3} = 'Targ';
practice_pairs{5,3} = 'Targ';

%rd = randperm(size(practice_images_filtered,1));
%practice_images_filtered = practice_images_filtered(rd,:);

% Shuffle again
rd = randperm(size(task_images_filtered,1));
task_images_filtered = task_images_filtered(rd,:);
task_images_filtered_test = task_images_filtered;

%task_images_filtered columns:
%col 1 = A image name
%col 2 = stimulation (0 or 1)
%col 3 = novelty cond (Targ or New)
%col 4 = A image index (for sequence later)

% check images filtered
total = 0;
for i=1:size(task_images_filtered,1)
    if task_images_filtered{i,2} == 0 && strcmp(task_images_filtered{i,3}, 'Targ')
        total = total + 1;
    end
end
if total ~= 80
    'UNBALANCED NoStim Targets!';
    return;
end

total = 0;
for i=1:size(task_images_filtered,1)
    if task_images_filtered{i,2} == 1 && strcmp(task_images_filtered{i,3}, 'Targ')
        total = total + 1;
    end
end
if total ~= 80
    'UNBALANCED Stim Targets!';
    return;
end


total = 0;
for i=1:size(task_images_filtered,1)
    if strcmp(task_images_filtered{i,3}, 'New')
        total = total + 1;
    end
end
if total ~= 160
    'UNBALANCED New images!';
    return;
end

% In task_images_filtered:
% column 2 = stim/nostim
% column 3 = novelty condition

% -- Assign the study breakout numbers
% Iterate over each study breakout
for n_breakout=1:n_study_breakouts
    % Create the order for this breakout
    %pseudorandomization(conditions,repeat_limit,number_trials_per_condition)
    order = pseudorandomization({{'Stim', 'NoStim'},{'Targ'}}, [3,80], n_study_images_per_breakout_per_novelty_condition/2);
    
    total = 0;
    for j=1:size(order,2)
        s = split(order(j), '-');
        if strcmp('Stim', s(1))
        total = total + 1;
        end
    end
    if total ~= 40
        'UNBALANCED!!!'
        return;
    end
    % Grab images from task_images_filtered, and move them to the new
    % breakout cells
    for i=1:size(order,2)
        order_trial_split = split(order(i),'-'); % 'Stim-Targ' / 'NoStim-Targ'
        novelty_condition = order_trial_split(2); % Targ/New
        stim_condition = order_trial_split(1); % Stim/No-Stim
        
        if strcmp(novelty_condition, 'New')
            continue
        end

        if strcmp(stim_condition, 'Stim')
            stim_condition = 1;
        else
            stim_condition = 0;
        end

        % Now we need to find the latest trial that satisfies these
        % conditions. Then we delete it from task_trials_filtered so that
        % other breakouts don't get this image.
        idx_found = 0;

        for j=1:size(task_images_filtered,1)
            if task_images_filtered{j,2} == stim_condition && strcmp(task_images_filtered{j,3}, novelty_condition)
                % Found a matching condition
                idx_found = j;
                break
            end
        end

        %here i only need Targ items
        study_breakouts{n_breakout}{i,1} = task_images_filtered{idx_found,1};
        study_breakouts{n_breakout}{i,2} = task_images_filtered{idx_found,2};
        study_breakouts{n_breakout}{i,3} = task_images_filtered{idx_found,3};
        study_breakouts{n_breakout}{i,4} = task_images_filtered{idx_found,4};
        
        task_images_filtered{idx_found,1} = -1;
        task_images_filtered{idx_found,2} = -1;
        task_images_filtered{idx_found,3} = -1;
        task_images_filtered{idx_found,4} = -1;

    end

end

rd = randperm(size(task_images_filtered_test,1));
task_images_filtered_test = task_images_filtered_test(rd,:);

%% Old Logic. Didn't include counterbalancing or pseudorandomization
% for i=1:size(task_images_filtered_test)
%     if strcmp(task_images_filtered_test{i,4}, 'Targ')
%         task_images_filtered_test_clean{i,1} = task_images_filtered_test{i,1};
%         task_images_filtered_test_clean{i,4} = task_images_filtered_test{i,5};
%     elseif strcmp(task_images_filtered_test{i,4}, 'Lure')
%         task_images_filtered_test_clean{i,1} = task_images_filtered_test{i,2};
%         task_images_filtered_test_clean{i,4} = task_images_filtered_test{i,6};
%     elseif strcmp(task_images_filtered_test{i,4}, 'Foil')
%         task_images_filtered_test_clean{i,1} = task_images_filtered_test{i,1};
%         task_images_filtered_test_clean{i,4} = task_images_filtered_test{i,5};
%     else
%         'Unknown condition type!'
%         return
%     end
%     task_images_filtered_test_clean{i,2} = task_images_filtered_test{i,3};
%     task_images_filtered_test_clean{i,3} = task_images_filtered_test{i,4};
% end
% task_images_filtered_test = task_images_filtered_test_clean;
% clear task_images_filtered_test_clean;
% 
% n_per_breakout = size(task_images_filtered_test,1) / 6;
% for i=1:n_test_breakouts
%     for j=1:n_per_breakout
%         test_breakouts{i}{j,1} = task_images_filtered_test{((i-1)*n_per_breakout)+j,1};
%         test_breakouts{i}{j,2} = task_images_filtered_test{((i-1)*n_per_breakout)+j,2};
%         test_breakouts{i}{j,3} = task_images_filtered_test{((i-1)*n_per_breakout)+j,3};        
%         test_breakouts{i}{j,4} = task_images_filtered_test{((i-1)*n_per_breakout)+j,4};
%     end
% end
%% New logic. Add pseudorandomization and counterbalancing for test breakouts. Copied from study section
% In task_images_filtered_test:
% column 3 = stim/nostim
% column 4 = novelty condition


%MUST RUN PSEUDORAND TWICE. oNCE WITH STIM AND ONCE WITH NOVELTY, CREATE
%TWO SEPARATE ORDERS BELOW AND CROSS CHECK WITH IF TARG STATEMENT



% -- Assign the test breakout numbers
% Iterate over each test breakout
for n_breakout=1:n_test_breakouts
        % Create the order for this breakout
        order = pseudorandomization({{'Stim', 'NoStim'},{'Targ', 'New'}}, [3,3], n_test_images_per_breakout_per_novelty_condition/2);
    
            total = 0;
        for j=1:size(order,2)
            s = split(order(j), '-');
            if strcmp('Stim', s(1))
            total = total + 1;
            end
        end
        if total ~= 40
            'UNBALANCED!!!'
            return;
        end
        
        % Grab images from task_images_filtered, and move them to the new
        % breakout cells
        for i=1:size(order,2)
            order_trial_split = split(order(i),'-'); % 'Stim-Targ / 'NoStim-Targ in the first pseudorand script
            novelty_condition = order_trial_split(2); % Targ/New from the first pseudorand script
            stim_condition = order_trial_split(1); % Stim/No-Stim
% 
%             if strcmp(stim_condition, 'Stim')
%                 stim_condition = 1;
%             else
%                 stim_condition = 0;
%             end

            if strcmp(stim_condition, 'Stim') && ~strcmp(novelty_condition, 'New')
                stim_condition = 1;
            else
                stim_condition = 0;
            end

            % Now we need to find the latest trial that satisfies these
            % conditions. Then we delete it from task_trials_filtered_test so that
            % other breakouts don't get this image.
            idx_found = 0;
    
            for j=1:size(task_images_filtered_test,1) %filter novelty cond
                if  task_images_filtered_test{j,2} == stim_condition && strcmp(task_images_filtered_test{j,3}, novelty_condition)
                    idx_found = j;
                    break
                end
            end
    
            if idx_found == 0
                'No image found in task_images_filtered_test! Trying to get too many images'
                return
            end
            
%             repeatmax = 3;
%             new_cond = task_images_filtered_test{c,3} == "New";
%             for c= 1:size(task_images_filtered_test,1)
%                 if new_cond(c) 

            
    %writing the breakout files
    %here i need both Targ and New images
            test_breakouts{n_breakout}{i,1} = task_images_filtered_test{idx_found,1};%take image a
            test_breakouts{n_breakout}{i,2} = task_images_filtered_test{idx_found,2};
            test_breakouts{n_breakout}{i,3} = task_images_filtered_test{idx_found,3};
            test_breakouts{n_breakout}{i,4} = task_images_filtered_test{idx_found,4};%image a index
    
     %deleting each file from the big task list to show it has already been used
     %based on image index it makes the image =-1
            task_images_filtered_test{idx_found,1} = -1;
            task_images_filtered_test{idx_found,2} = -1;
            task_images_filtered_test{idx_found,3} = -1;
            task_images_filtered_test{idx_found,4} = -1;
        end

end
%% Write out study param files
for breakoutnum_iter=1:n_study_breakouts
    script_BLAES_Aim1_LongDelay_studyphase(settings,ALL_IMAGES,slash,study_breakouts{breakoutnum_iter},breakoutnum_iter, practice_pairs)
end

%% Write out test param files
for breakoutnum_iter=1:length(test_breakouts)
    script_BLAES_Aim1_LongDelay_testphase(settings,ALL_IMAGES,slash,test_breakouts{breakoutnum_iter},breakoutnum_iter, practice_pairs)
end