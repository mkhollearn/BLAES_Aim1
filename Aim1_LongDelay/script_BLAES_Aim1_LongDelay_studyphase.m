function param = script_BLAES_Aim1_LongDelay_studyphase(settings,ALL_IMAGES,slash,trials,breakoutnum_iter,practice_pairs)
%% Set up the different stimuli so they are represented by unique stimulus codes, separated into banks for easy evaluation later
total_events = 7000; % Total events
n_rows    = 9;

% break down into blocks for easier analysis later
% 1-2314:    image stimuli
% 2501:      instructions
% 2601:      sync pulse
% 2701:      No Stimulation
% 2702:      Stimulation
% 2801-5115: ITI (fixation cross)
% 5200:      ISI
% 6501-5510: Practice images


% Set up Stimuli
param.Stimuli.Section         = 'Application';
param.Stimuli.Type            = 'matrix';
param.Stimuli.DefaultValue    = '';
param.Stimuli.LowRange        = '';
param.Stimuli.HighRange       = '';
param.Stimuli.Comment         = 'captions and icons to be displayed, sounds to be played for different stimuli';
param.Stimuli.Value           = cell(n_rows,total_events);
param.Stimuli.Value(:)        = {''};
param.Stimuli.RowLabels       = cell(n_rows,1);
param.Stimuli.RowLabels(:)    = {''};
param.Stimuli.ColumnLabels    = cell(1,total_events);
param.Stimuli.ColumnLabels(:) = {''};

param.Stimuli.RowLabels{1}  = 'caption';
param.Stimuli.RowLabels{2}  = 'icon';
param.Stimuli.RowLabels{3}  = 'audio';
param.Stimuli.RowLabels{4}  = 'StimulusDuration';
param.Stimuli.RowLabels{5}  = 'AudioVolume';
param.Stimuli.RowLabels{6}  = 'Category';
param.Stimuli.RowLabels{7}  = 'EarlyOffsetExpression'; %advances to the next trial
param.Stimuli.RowLabels{8}  = 'Stimulation';
param.Stimuli.RowLabels{9}  = 'NoveltyCondition';

%% ISI
idx = 5200;
param.Stimuli.ColumnLabels{idx} = sprintf('%d',idx);
param.Stimuli.Value{1,idx}      = '+';
param.Stimuli.Value{2,idx}      = '';
param.Stimuli.Value{3,idx}      = '';
param.Stimuli.Value{4,idx}      = settings.StudyISI;
param.Stimuli.Value{5,idx}      = '0';      
param.Stimuli.Value{6,idx}      = ''; 
param.Stimuli.Value{7,idx}      = '';     
param.Stimuli.Value{8,idx}      = '';
param.Stimuli.Value{9,idx}      = '';

%% Stimulation Sequence numbers
StimulationString = {'Off', 'On'};
StimulationNum    = {'0',   '1'};
idx_iter = 1;
for idx = 2701:2702
    param.Stimuli.ColumnLabels{idx} = sprintf('%d',idx);
    param.Stimuli.Value{1,idx}      = '+';
    param.Stimuli.Value{2,idx}      = '';
    param.Stimuli.Value{3,idx}      = '';
    param.Stimuli.Value{4,idx}      = settings.StimulationDuration;
    param.Stimuli.Value{5,idx}      = '0';      
    param.Stimuli.Value{6,idx}      = 'StimNoStim'; 
    param.Stimuli.Value{7,idx}      = '';
    param.Stimuli.Value{8,idx}      = StimulationNum{idx_iter};
    param.Stimuli.Value{9,idx}      = '';

    idx_iter = idx_iter + 1;
end

%% Practice images 6501-6510
idx = 1;
for idx_iter = 6501:6500+size(practice_pairs)[0];
     if strcmp(practice_pairs{idx,3}, "Targ")
        param.Stimuli.ColumnLabels{idx_iter} = sprintf('%d',idx_iter);
        param.Stimuli.Value{1,idx_iter}      = '';
        param.Stimuli.Value{2,idx_iter}      = sprintf('%s',fullfile(settings.BCI2000path,'tasks', 'BLAES_Aim1', 'Aim1_LongDelay','practice_images',practice_pairs{idx,1}));
        param.Stimuli.Value{3,idx_iter}      = '';
        param.Stimuli.Value{4,idx_iter}      = settings.TaskDuration;
        param.Stimuli.Value{5,idx_iter}      = '0';      %no audio volume
        param.Stimuli.Value{6,idx_iter}      = 'image'; 
        param.Stimuli.Value{7,idx_iter}      = '';
        param.Stimuli.Value{8,idx_iter}      = '0'; % No stim for practice 
        param.Stimuli.Value{9,idx_iter}      = practice_pairs{idx,3}; %novelty condition
     end
    idx = idx + 1;
end 

%% Study images 1-2314
for idx = 1:length(ALL_IMAGES)
    param.Stimuli.ColumnLabels{idx} = sprintf('%d',idx);
    param.Stimuli.Value{1,idx}      = '';
    param.Stimuli.Value{2,idx}      = sprintf('%s',fullfile(settings.BCI2000path,'tasks', 'BLAES_Aim1', 'Aim1_LongDelay', 'LongDelay_images_fixed',ALL_IMAGES(idx).name));
    param.Stimuli.Value{3,idx}      = '';
    param.Stimuli.Value{4,idx}      = settings.TaskDuration;
    param.Stimuli.Value{5,idx}      = '0';      
    param.Stimuli.Value{6,idx}      = 'image'; 
    param.Stimuli.Value{7,idx}      = ''; 
    param.Stimuli.Value{8,idx}      = ''; 
    param.Stimuli.Value{9,idx}      = ''; 
end 

for idx = 1:length(trials)
    param.Stimuli.Value{8,trials{idx,4}} = num2str(trials{idx,2});%stim/nostim
    param.Stimuli.Value{9,trials{idx,4}} = trials{idx,3}; %novelty cond
end

%% inter-stimulus interval (fixation cross) 2801 - 5115
for idx=2801:5115
    blockvals = str2num(settings.FixationMin):str2num(settings.SampleBlockSize)/str2num(settings.SamplingRate):str2num(settings.FixationMax);
    randval   = randi(length(blockvals));
    duration  = blockvals(randval);

    param.Stimuli.ColumnLabels{idx} = sprintf('%d',idx);
    param.Stimuli.Value{1,idx}      = '+';
    param.Stimuli.Value{2,idx}      = '';
    param.Stimuli.Value{3,idx}      = '';
    param.Stimuli.Value{4,idx}      = strcat(num2str(duration,7),'s');
    param.Stimuli.Value{5,idx}      = '0';      
    param.Stimuli.Value{6,idx}      = 'fixation'; 
    param.Stimuli.Value{7,idx}      = ''; 
    param.Stimuli.Value{8,idx}      = ''; 
    param.Stimuli.Value{9,idx}      = ''; 
end

%% Instructions 2501-2504
InstructionsFilenames = {'study_instructions.png','practice_instructions.png','test_instructions.png','end_instructions.png'};

idx_iter = 1;
for idx = 2501:2500+length(InstructionsFilenames)
    param.Stimuli.ColumnLabels{idx} = sprintf('%d',idx);
    param.Stimuli.Value{1,idx}      = '';
    param.Stimuli.Value{2,idx}      = strcat(settings.instructionpath,slash,InstructionsFilenames{idx_iter});
    param.Stimuli.Value{3,idx}      = '';
    param.Stimuli.Value{4,idx}      = settings.InstructionDuration;
    param.Stimuli.Value{5,idx}      = '0';    
    param.Stimuli.Value{6,idx}      = 'instruction'; 
    param.Stimuli.Value{7,idx}      = 'KeyDown == 32'; % space key
    param.Stimuli.Value{8,idx}      = ''; 
    param.Stimuli.Value{9,idx}      = ''; 
    %right arrow keycode = 39 "outdoor"
    %left arrow keycode = 37 "indoor"
    
    idx_iter = idx_iter + 1;
end 

%% Sync pulse 2601
idx = 2601;
param.Stimuli.ColumnLabels{idx} = sprintf('%d',idx);
param.Stimuli.Value{1,idx}      = '';
param.Stimuli.Value{2,idx}      = '';
param.Stimuli.Value{3,idx}      = '';
param.Stimuli.Value{4,idx}      = settings.SyncPulseDuration;
param.Stimuli.Value{5,idx}      = '0';      
param.Stimuli.Value{6,idx}      = 'sync'; 
param.Stimuli.Value{7,idx}      = '';     
param.Stimuli.Value{8,idx}      = ''; 
param.Stimuli.Value{9,idx}      = ''; 

%% Sequence
taskseq = [5200]; %ISI
for i = 1:length(trials)
    taskseq = [taskseq trials{i,4} 2701+trials{i,2} 5200 2801+i];
end

seq = [2601 2501 taskseq 2504 2601]';

% Practice sequence
prac_seq = [5200]; %ISI
i = 1;
for idx_iter = 6501:6500+size(practice_pairs)[0];
%   if ~strcmp(practice_pairs{idx,4},'New')
%        continue
%    else
        if length(param.Stimuli.Value{9,idx_iter}) ~= 0
        prac_seq = [prac_seq idx_iter 5200];
        end
    i = i + 1;
  % end
end

prac_seq = [2601 2501 2502 prac_seq 2601]';

param.Sequence.Section      = 'Application';
param.Sequence.Type         = 'intlist';
param.Sequence.DefaultValue = '1';
param.Sequence.LowRange     = '1';
param.Sequence.HighRange    = '';
param.Sequence.Comment      = 'Sequence in which stimuli are presented (deterministic mode)/ Stimulus frequencies for each stimulus (random mode)';
param.Sequence.Value        = cellfun(@num2str, num2cell(seq), 'un',0);
param.Sequence.NumericValue = seq;

%% UserComment
param.UserComment.Section         = 'Application';
param.UserComment.Type            = 'string';
param.UserComment.DefaultValue    = '';
param.UserComment.LowRange        = '';
param.UserComment.HighRange       = '';
param.UserComment.Comment         = 'User comments for a specific run';
param.UserComment.Value           = {settings.UserComment};

%%
param.SamplingRate.Section         = 'Source';
param.SamplingRate.Type            = 'int';
param.SamplingRate.DefaultValue    = '256Hz';
param.SamplingRate.LowRange        = '1';
param.SamplingRate.HighRange       = '';
param.SamplingRate.Comment         = 'sample rate';
param.SamplingRate.Value           = {settings.SamplingRate};

%%
param.SampleBlockSize.Section         = 'Source';
param.SampleBlockSize.Type            = 'int';
param.SampleBlockSize.DefaultValue    = '8';
param.SampleBlockSize.LowRange        = '1';
param.SampleBlockSize.HighRange       = '';
param.SampleBlockSize.Comment         = 'number of samples transmitted at a time';
param.SampleBlockSize.Value           = {settings.SampleBlockSize};

%%
param.NumberOfSequences.Section         = 'Application';
param.NumberOfSequences.Type            = 'int';
param.NumberOfSequences.DefaultValue    = '1';
param.NumberOfSequences.LowRange        = '0';
param.NumberOfSequences.HighRange       = '';
param.NumberOfSequences.Comment         = 'number of sequence repetitions in a run';
param.NumberOfSequences.Value           = {settings.NumberOfSequences};

%%
param.StimulusWidth.Section         = 'Application';
param.StimulusWidth.Type            = 'int';
param.StimulusWidth.DefaultValue    = '0';
param.StimulusWidth.LowRange        = '';
param.StimulusWidth.HighRange       = '';
param.StimulusWidth.Comment         = 'StimulusWidth in percent of screen width (zero for original pixel size)';
param.StimulusWidth.Value           = {settings.StimulusWidth};

%%
param.SequenceType.Section              = 'Application';
param.SequenceType.Type                 = 'int';
param.SequenceType.DefaultValue         = '0';
param.SequenceType.LowRange             = '0';
param.SequenceType.HighRange            = '1';
param.SequenceType.Comment              = 'Sequence of stimuli is 0 deterministic, 1 random (enumeration)';
param.SequenceType.Value                = {'0'};

%%
param.StimulusDuration.Section           = 'Application';
param.StimulusDuration.Type              = 'float';
param.StimulusDuration.DefaultValue      = '40ms';
param.StimulusDuration.LowRange          = '0';
param.StimulusDuration.HighRange         = '';
param.StimulusDuration.Comment           = 'stimulus duration';
param.StimulusDuration.Value             = {};

%%
param.ISIMaxDuration.Section       = 'Application';
param.ISIMaxDuration.Type          = 'float';
param.ISIMaxDuration.DefaultValue  = '80ms';
param.ISIMaxDuration.LowRange      = '0';
param.ISIMaxDuration.HighRange     = '';
param.ISIMaxDuration.Comment       = 'maximum duration of inter-stimulus interval';
param.ISIMaxDuration.Value         = {'0ms'};

%%
param.ISIMinDuration.Section       = 'Application';
param.ISIMinDuration.Type          = 'float';
param.ISIMinDuration.DefaultValue  = '80ms';
param.ISIMinDuration.LowRange      = '0';
param.ISIMinDuration.HighRange     = '';
param.ISIMinDuration.Comment       = 'minimum duration of inter-stimulus interval';
param.ISIMinDuration.Value         = {'0ms'};

%%
param.PreSequenceDuration.Section       = 'Application';
param.PreSequenceDuration.Type          = 'float';
param.PreSequenceDuration.DefaultValue  = '2s';
param.PreSequenceDuration.LowRange      = '0';
param.PreSequenceDuration.HighRange     = '';
param.PreSequenceDuration.Comment       = 'pause preceding sequences/sets of intensifications';
param.PreSequenceDuration.Value         = {'0s'};

%%
param.PostSequenceDuration.Section       = 'Application';
param.PostSequenceDuration.Type          = 'float';
param.PostSequenceDuration.DefaultValue  = '2s';
param.PostSequenceDuration.LowRange      = '0';
param.PostSequenceDuration.HighRange     = '';
param.PostSequenceDuration.Comment       = 'pause following sequences/sets of intensifications';
param.PostSequenceDuration.Value         = {'0s'};

%%
param.PreRunDuration.Section       = 'Application';
param.PreRunDuration.Type          = 'float';
param.PreRunDuration.DefaultValue  = '2000ms';
param.PreRunDuration.LowRange      = '0';
param.PreRunDuration.HighRange     = '';
param.PreRunDuration.Comment       = 'pause preceding first sequence';
param.PreRunDuration.Value         = {settings.PreRunDuration};

%%
param.PostRunDuration.Section       = 'Application';
param.PostRunDuration.Type          = 'float';
param.PostRunDuration.DefaultValue  = '2000ms';
param.PostRunDuration.LowRange      = '0';
param.PostRunDuration.HighRange     = '';
param.PostRunDuration.Comment       = 'pause following last squence';
param.PostRunDuration.Value         = {settings.PostRunDuration};


%%
param.BackgroundColor.Section      = 'Application';
param.BackgroundColor.Type         = 'string';
param.BackgroundColor.DefaultValue = '0x00FFFF00';
param.BackgroundColor.LowRange     = '0x00000000';
param.BackgroundColor.HighRange    = '0x00000000';
param.BackgroundColor.Comment      = 'Color of stimulus background (color)';
param.BackgroundColor.Value        = {settings.BackgroundColor};

%%
param.CaptionColor.Section      = 'Application';
param.CaptionColor.Type         = 'string';
param.CaptionColor.DefaultValue = '0x00FFFF00';
param.CaptionColor.LowRange     = '0x00000000';
param.CaptionColor.HighRange    = '0x00000000';
param.CaptionColor.Comment      = 'Color of stimulus caption text (color)';
param.CaptionColor.Value        = {settings.CaptionColor};

%%
param.WindowBackgroundColor.Section      = 'Application';
param.WindowBackgroundColor.Type         = 'string';
param.WindowBackgroundColor.DefaultValue = '0x00FFFF00';
param.WindowBackgroundColor.LowRange     = '0x00000000';
param.WindowBackgroundColor.HighRange    = '0x00000000';
param.WindowBackgroundColor.Comment      = 'background color (color)';
param.WindowBackgroundColor.Value        = {settings.WindowBackgroundColor};

%%
param.IconSwitch.Section          = 'Application';
param.IconSwitch.Type             = 'int';
param.IconSwitch.DefaultValue     = '1';
param.IconSwitch.LowRange         = '0';
param.IconSwitch.HighRange        = '1';
param.IconSwitch.Comment          = 'Present icon files (boolean)';
param.IconSwitch.Value            = {'1'};

%%
param.AudioSwitch.Section         = 'Application';
param.AudioSwitch.Type            = 'int';
param.AudioSwitch.DefaultValue    = '1';
param.AudioSwitch.LowRange        = '0';
param.AudioSwitch.HighRange       = '1';
param.AudioSwitch.Comment         = 'Present audio files (boolean)';
param.AudioSwitch.Value           = {'0'};

%%
param.CaptionSwitch.Section       = 'Application';
param.CaptionSwitch.Type          = 'int';
param.CaptionSwitch.DefaultValue  = '1';
param.CaptionSwitch.LowRange      = '0';
param.CaptionSwitch.HighRange     = '1';
param.CaptionSwitch.Comment       = 'Present captions (boolean)';
param.CaptionSwitch.Value         = {settings.CaptionSwitch};

%%
param.WindowHeight.Section        = 'Application';
param.WindowHeight.Type           = 'int';
param.WindowHeight.DefaultValue   = '480';
param.WindowHeight.LowRange       = '0';
param.WindowHeight.HighRange      = '';
param.WindowHeight.Comment        = 'height of application window';
param.WindowHeight.Value          = {settings.WindowHeight};

%%
param.WindowWidth.Section        = 'Application';
param.WindowWidth.Type           = 'int';
param.WindowWidth.DefaultValue   = '480';
param.WindowWidth.LowRange       = '0';
param.WindowWidth.HighRange      = '';
param.WindowWidth.Comment        = 'width of application window';
param.WindowWidth.Value          = {settings.WindowWidth};

%%
param.WindowLeft.Section        = 'Application';
param.WindowLeft.Type           = 'int';
param.WindowLeft.DefaultValue   = '0';
param.WindowLeft.LowRange       = '';
param.WindowLeft.HighRange      = '';
param.WindowLeft.Comment        = 'screen coordinate of application window''s left edge';
param.WindowLeft.Value          = {settings.WindowLeft};

%%
param.WindowTop.Section        = 'Application';
param.WindowTop.Type           = 'int';
param.WindowTop.DefaultValue   = '0';
param.WindowTop.LowRange       = '';
param.WindowTop.HighRange      = '';
param.WindowTop.Comment        = 'screen coordinate of application window''s top edge';
param.WindowTop.Value          = {settings.WindowTop};

%%
param.CaptionHeight.Section      = 'Application';
param.CaptionHeight.Type         = 'int';
param.CaptionHeight.DefaultValue = '0';
param.CaptionHeight.LowRange     = '0';
param.CaptionHeight.HighRange    = '100';
param.CaptionHeight.Comment      = 'Height of stimulus caption text in percent of screen height';
param.CaptionHeight.Value        = {'5'};

%%
param.WarningExpression.Section      = 'Filtering';
param.WarningExpression.Type         = 'string';
param.WarningExpression.DefaultValue = '';
param.WarningExpression.LowRange     = '';
param.WarningExpression.HighRange    = '';
param.WarningExpression.Comment      = 'expression that results in a warning when it evaluates to true';
param.WarningExpression.Value        = {''};

%%
param.Expressions.Section      = 'Filtering';
param.Expressions.Type         = 'matrix';
param.Expressions.DefaultValue = '';
param.Expressions.LowRange     = '';
param.Expressions.HighRange    = '';
param.Expressions.Comment      = 'expressions used to compute the output of the ExpressionFilter';
param.Expressions.Value        = {''};

%%
param.SubjectName.Section      = 'Storage';
param.SubjectName.Type         = 'string';
param.SubjectName.DefaultValue = 'Name';
param.SubjectName.LowRange     = '';
param.SubjectName.HighRange    = '';
param.SubjectName.Comment      = 'subject alias';
param.SubjectName.Value        = {settings.SubjectName};

%%
param.DataDirectory.Section      = 'Storage';
param.DataDirectory.Type         = 'string';
param.DataDirectory.DefaultValue = strcat('..',slash,',,', slash, 'data');
param.DataDirectory.LowRange     = '';
param.DataDirectory.HighRange    = '';
param.DataDirectory.Comment      = 'path to top level data directory (directory)';
param.DataDirectory.Value        = {settings.DataDirectory};

%%
param.SubjectRun.Section      = 'Storage';
param.SubjectRun.Type         = 'string';
param.SubjectRun.DefaultValue = '00';
param.SubjectRun.LowRange     = '';
param.SubjectRun.HighRange    = '';
param.SubjectRun.Comment      = 'two-digit run number';
param.SubjectRun.Value        = {settings.SubjectRun};

%%
param.SubjectSession.Section      = 'Storage';
param.SubjectSession.Type         = 'string';
param.SubjectSession.DefaultValue = '00';
param.SubjectSession.LowRange     = '';
param.SubjectSession.HighRange    = '';
param.SubjectSession.Comment      = 'three-digit session number';
param.SubjectSession.Value        = {settings.SubjectSession};

%% save param.stimuli.value AND save the sequence (seq variable) to .mat files
param_value = param.Stimuli.Value;
save(['study_param_value', num2str(breakoutnum_iter),'.mat'], 'param_value')
save(['study_task_sequence', num2str(breakoutnum_iter), '.mat'], 'taskseq')

%% write the param struct to a bci2000 parameter file
parameter_lines = convert_bciprm( param );
fid = fopen(strcat(settings.parm_filename, '_study_breakout_', num2str(breakoutnum_iter), '.prm'), 'w');

for i=1:length(parameter_lines)
    fprintf( fid, '%s', parameter_lines{i} );
    fprintf( fid, '\r\n' );
end
fclose(fid);

%% Write study practice parameter file 
param.Sequence.Value        = cellfun(@num2str, num2cell(prac_seq), 'un',0);
param.Sequence.NumericValue = prac_seq;
parameter_lines = convert_bciprm( param );
fid = fopen(strcat(settings.parm_filename, '_study_practice_breakout_', num2str(breakoutnum_iter), '.prm'), 'w');

for i=1:length(parameter_lines)
    fprintf( fid, '%s', parameter_lines{i} );
    fprintf( fid, '\r\n' );
end
fclose(fid);
