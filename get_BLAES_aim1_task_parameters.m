function get_BLAES_aim1_task_parameters

clear;
close all;

addpath(genpath(fullfile(cd,'BCI2000Tools')))

subjID = 'testing_before_pilot001';
samp_rate = 2000;

%% get study parameters
f = dir(fullfile(cd,'data','UTAH','BLAES_study',subjID,'*.dat'));

    for file = 1:size(f,1)

        [~, states, param] = load_bcidat(fullfile(f(file).folder,f(file).name));
        pause(1);
        
        seq         = param.Sequence.NumericValue;
        StimCode    = states.StimulusCode;
        StimCode    = double(StimCode);
        KD          = states.KeyDown;
        KD          = double(KD);
        param_value = param.Stimuli.Value;
        
        save(['study_param_value', num2str(file), '.mat'], 'param_value')
        save(['study_task_seq', num2str(file), '.mat'], 'seq')
    end
    
  %% get test parameters
d = dir(fullfile(cd,'data','UTAH','BLAES_test',subjID,'*.dat'));

    for file = 1:size(d,1)

        [~, states, param] = load_bcidat(fullfile(d(file).folder,d(file).name));
        pause(1);
        
        seq         = param.Sequence.NumericValue;
        StimCode    = states.StimulusCode;
        StimCode    = double(StimCode);
        KD          = states.KeyDown;
        KD          = double(KD);
        param_value = param.Stimuli.Value;
        
        save(['test_param_value', num2str(file), '.mat'], 'param_value')
        save(['test_task_seq', num2str(file), '.mat'], 'seq')
    end
      
