% Krista & Justin Aim 1 Check
% 10/31/22
%BLAES AIM 1 TEST PHASE CHECK

addpath(genpath('C:\Users\Brunnerlab\Desktop\BLAES\BCI2000Tools'))


%% Get stimulus codes from test file

%Enter only ONE test phase file and run this script for each file/breakout
%session separately
testFile = {'C:\Paradigms\data\BLAES_Aim1\LongDelay\UTAH\BLAES_test\UIC001\UICS001R04.dat'};

testSeqs = [];

for i = 1:length(testFile)
    [~,~,parameters] = load_bcidat(testFile{i});
    testSeqs = [testSeqs, parameters.Sequence.NumericValue];
end


%% Find codes for just images

testSeqs = testSeqs(testSeqs <= 2314);

%% Image counts by type (test phase) 

seqTable = parameters.Stimuli.Value;
testImageTypes = cell(1,length(testSeqs));
for i = 1:length(testSeqs)
    testImageTypes{1,i} = seqTable(9,testSeqs(i));
end


newCnt = 0;
targCnt = 0;


for i = 1:length(testSeqs)
    if contains(testImageTypes{i}, 'Targ')
        targCnt = targCnt + 1;
    elseif contains(testImageTypes{i}, 'New')
        foilCnt = foilCnt + 1;
    end
end


%% Stimulated vs  non-stimulated images
stimTable = parameters.Stimuli.Value;
stimImageTypes = cell(1,length(testSeqs));
for i = 1:length(testSeqs)
    stimImageTypes{1,i} = stimTable(8,testSeqs(i));
end


stimCnt = 0;
nostimCnt = 0;


for i = 1:length(testSeqs)
    if contains(stimImageTypes{i}, '1')
        stimCnt = stimCnt + 1;
    elseif contains(stimImageTypes{i}, '0')
        nostimCnt = nostimCnt + 1;
    end
end

