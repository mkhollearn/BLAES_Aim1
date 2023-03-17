% Krista & Justin Aim 1 Check
% 10/31/22
%BLAES AIM 1 STUDY PHASE CHECK
%% Get stimulus codes from study files
addpath(genpath('C:\Users\Brunnerlab\Desktop\BLAES\BCI2000Tools'))

%%[~,states,parameters] = load_bcidat('C:\Paradigms\data\BLAES_Aim1\UTAH\BLAES_test\KWJCTEST001\KWJCTESTS001R06.dat');




studyFiles = {'C:\Paradigms\data\BLAES_Aim1\LongDelay\UTAH\BLAES_study\UIC001\UICS001R01.dat',
    'C:\Paradigms\data\BLAES_Aim1\LongDelay\UTAH\BLAES_study\UIC001\UICS001R02.dat',};

studySeqs = [];

for i = 1:length(studyFiles)
    [~,~,parameters] = load_bcidat(studyFiles{i});
    studySeqs = [studySeqs, parameters.Sequence.NumericValue];
end
%% Get stimulus codes from test files
testFiles = {'C:\Paradigms\data\BLAES_Aim1\LongDelay\UTAH\BLAES_test\UIC001\UICS001R01.dat',
   'C:\Paradigms\data\BLAES_Aim1\LongDelay\UTAH\BLAES_test\UIC001\UICS001R02.dat',
    'C:\Paradigms\data\BLAES_Aim1\LongDelay\UTAH\BLAES_test\UIC001\UICS001R03.dat',
    'C:\Paradigms\data\BLAES_Aim1\LongDelay\UTAH\BLAES_test\UIC001\UICS001R04.dat'};

testSeqs = [];

for i = 1:length(testFiles)
    [~,~,parameters] = load_bcidat(testFiles{i});
    testSeqs = [testSeqs, parameters.Sequence.NumericValue];
end
%% Find codes for just images
studySeqs = reshape(studySeqs,[],1);
testSeqs = reshape(testSeqs,[],1);

studySeqs = studySeqs(studySeqs <= 2314);
testSeqs = testSeqs(testSeqs <= 2314);
%% Compare study vs. test (how many image stimulus codes from study phase also exist in the test phase)
sameCode = 0;
for i = 1:length(studySeqs)
    if ~isempty(find(testSeqs == studySeqs(i)))
        sameCode = sameCode + 1;
    end
end

