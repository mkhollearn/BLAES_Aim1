#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
This experiment was created using PsychoPy3 Experiment Builder (v3.2.4),
    on Sun Jan  9 10:52:45 2022
If you publish work using this script the most relevant publication is:

    Peirce J, Gray JR, Simpson S, MacAskill M, Höchenberger R, Sogo H, Kastman E, Lindeløv JK. (2019) 
        PsychoPy2: Experiments in behavior made easy Behav Res 51: 195. 
        https://doi.org/10.3758/s13428-018-01193-y

"""

from __future__ import absolute_import, division

import psychopy
psychopy.useVersion('3.2')


from psychopy import locale_setup
from psychopy import prefs
from psychopy import sound, gui, visual, core, data, event, logging, clock
from psychopy.constants import (NOT_STARTED, STARTED, PLAYING, PAUSED,
                                STOPPED, FINISHED, PRESSED, RELEASED, FOREVER)

import numpy as np  # whole numpy lib is available, prepend 'np.'
from numpy import (sin, cos, tan, log, log10, pi, average,
                   sqrt, std, deg2rad, rad2deg, linspace, asarray)
from numpy.random import random, randint, normal, shuffle
import os  # handy system and path functions
import sys  # to get file system encoding

from psychopy.hardware import keyboard

# Ensure that relative paths start from the same directory as this script
_thisDir = os.path.dirname(os.path.abspath(__file__))
os.chdir(_thisDir)

# Store info about the experiment session
psychopyVersion = '3.2.4'
expName = 'BLAES_MST_encoding'  # from the Builder filename that created this script
expInfo = {'participant': '', 'First name': '', 'Last name': ''}
dlg = gui.DlgFromDict(dictionary=expInfo, sortKeys=False, title=expName)
if dlg.OK == False:
    core.quit()  # user pressed cancel
expInfo['date'] = data.getDateStr()  # add a simple timestamp
expInfo['expName'] = expName
expInfo['psychopyVersion'] = psychopyVersion

# Data file name stem = absolute path + name; later add .psyexp, .csv, .log, etc
filename = _thisDir + os.sep + u'data/%s_%s_%s' % (expInfo['participant'], expName, expInfo['date'])

# An ExperimentHandler isn't essential but helps with data saving
thisExp = data.ExperimentHandler(name=expName, version='',
    extraInfo=expInfo, runtimeInfo=None,
    originPath='/Users/martinahollearn/Desktop/INMAN LAB/AMME/Aim 1/MST/BLAES_imageset/BLAES_MST_encoding.py',
    savePickle=True, saveWideText=True,
    dataFileName=filename)
# save a log file for detail verbose info
logFile = logging.LogFile(filename+'.log', level=logging.DEBUG)
logging.console.setLevel(logging.WARNING)  # this outputs to the screen, not a file

endExpNow = False  # flag for 'escape' or other condition => quit the exp
frameTolerance = 0.001  # how close to onset before 'same' frame

# Start Code - component code to be run before the window creation

# Setup the Window
win = visual.Window(
    size=[1080, 720], fullscr=False, screen=0, 
    winType='pyglet', allowGUI=True, allowStencil=False,
    monitor='testMonitor', color=[1.000,1.000,1.000], colorSpace='rgb',
    blendMode='avg', useFBO=True, 
    units='height')
# store frame rate of monitor if we can measure it
expInfo['frameRate'] = win.getActualFrameRate()
if expInfo['frameRate'] != None:
    frameDur = 1.0 / round(expInfo['frameRate'])
else:
    frameDur = 1.0 / 60.0  # could not measure, so guess

# create a default keyboard (e.g. to check for escape)
defaultKeyboard = keyboard.Keyboard()

# Initialize components for Routine "codeDefineImages"
codeDefineImagesClock = core.Clock()

all_images = []

with open('all_images/images_info.csv','r') as f:
    for line in f:
        line = line.strip('"')
        line_split = [col.strip().strip('"') for col in line.split(",")]
        all_images.append([f"{line_split[0].upper()}_{line_split[1]}", line_split[2]])

imgs = []
i = 0
while i < len(all_images)-1:
    imgs.append([all_images[i][0], all_images[i+1][0], all_images[i][-1]])
    i+=2
    
all_images = imgs





# Initialize components for Routine "codeSetupVars"
codeSetupVarsClock = core.Clock()
total_number_retrieval_sessions = 5
num_targ_per_ret = 50
num_foil_per_ret = 25
num_hsim_per_ret = 25
num_lsim_per_ret = 25


ITI = 1
trial_duration = 3

image_width = .5
image_height = .7

stim_size = (image_width, image_height)

circle_resp_size = (.2, .2)
left_resp_pos = (-.4,-.4)
right_resp_pos = (.4,-.4)

# Initialize components for Routine "setupImageLists"
setupImageListsClock = core.Clock()

import random
####### PARAMS
########

################ REAL IMAGES

hsim_imgs = [img_pair for img_pair in all_images if img_pair[2] in ['3','4']]
lsim_imgs = [img_pair for img_pair in all_images if img_pair[2] in ['1','2']]
ignored_imgs = [img_pair for img_pair in all_images if img_pair[2] in ['5']]

random.shuffle(hsim_imgs)
random.shuffle(lsim_imgs)
random.shuffle(ignored_imgs)

all_sessions = []
all_images_final = []
for session_id in range(1, total_number_retrieval_sessions+1):
    for i in range(num_hsim_per_ret):
        all_images_final.append(hsim_imgs.pop() + ['HSim', session_id])
    for i in range(num_lsim_per_ret):
        all_images_final.append(lsim_imgs.pop() + ['LSim', session_id])

leftovers = hsim_imgs + lsim_imgs + ignored_imgs
random.shuffle(leftovers)

for session_id in range(1, total_number_retrieval_sessions+1):
    for i in range(num_targ_per_ret):
        all_images_final.append(leftovers.pop() + ['Targ', session_id])
    for i in range(num_lsim_per_ret):
        all_images_final.append(leftovers.pop() + ['Foil', session_id])

random.shuffle(all_images_final)
for img in all_images_final:
    print(img)

#study_images = [[image[0], image[2]] for image in all_images if image[2] != 'Foil']
#test_images = all_images
#
#random.shuffle(study_images)
#random.shuffle(test_images)
#
#num_study = len(study_images)
#num_test = len(test_images)

# Initialize components for Routine "ITI"
ITIClock = core.Clock()
text_14 = visual.TextStim(win=win, name='text_14',
    text=None,
    font='Arial',
    pos=(0, 0), height=0.1, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);

# Initialize components for Routine "study_instructions_routine"
study_instructions_routineClock = core.Clock()
study_instructions = visual.TextStim(win=win, name='study_instructions',
    text="\n\nYou will be shown a series of images of objects. \nYou will decide whether each object belongs indoors or outdoors. \nIf you are unsure make your best guess.\n\nUse the 'F' key to respond 'Indoor', and the 'J' key to respond 'Outdoor'.\n'F': Indoor\n'J': Outdoor\n\nUse both of your index fingers, one on each key to \nrespond. Please keep your fingers on the keys at all times.\nYou have 3 seconds to respond to each object. The images will remain on the screen for 3 seconds even if you responded.\n\nOnce you have responded, you cannot change your answer.\nRespond as accurately and quickly as you can. \n\nPress the spacebar to start.",
    font='Arial',
    pos=(0, 0), height=0.025, wrapWidth=None, ori=0, 
    color=[-1.000,-1.000,-1.000], colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
study_instr_resp = keyboard.Keyboard()

# Initialize components for Routine "codeStudy"
codeStudyClock = core.Clock()
cur_study_trial = 0

# Initialize components for Routine "study_trial"
study_trialClock = core.Clock()
study_outdoor_selected = visual.ImageStim(
    win=win,
    name='study_outdoor_selected', 
    image='images/outdoor_selected.png', mask=None,
    ori=0, pos=[0,0], size=1.0,
    color=[1,1,1], colorSpace='rgb', opacity=0,
    flipHoriz=False, flipVert=False,
    texRes=512, interpolate=True, depth=0.0)
study_outdoor = visual.ImageStim(
    win=win,
    name='study_outdoor', 
    image='images/outdoor_unselected.png', mask=None,
    ori=0, pos=[0,0], size=1.0,
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=512, interpolate=True, depth=-1.0)
study_indoor_selected = visual.ImageStim(
    win=win,
    name='study_indoor_selected', 
    image='images/indoor_selected.png', mask=None,
    ori=0, pos=[0,0], size=1.0,
    color=[1,1,1], colorSpace='rgb', opacity=0,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=-2.0)
study_indoor = visual.ImageStim(
    win=win,
    name='study_indoor', 
    image='images/indoor_unselected.png', mask=None,
    ori=0, pos=[0,0], size=1.0,
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=-3.0)
study_image_shown = visual.ImageStim(
    win=win,
    name='study_image_shown', units='norm', 
    image='sin', mask=None,
    ori=0, pos=(0, 0), size=1.0,
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=-4.0)
study_resp = keyboard.Keyboard()

# Initialize components for Routine "ITI"
ITIClock = core.Clock()
text_14 = visual.TextStim(win=win, name='text_14',
    text=None,
    font='Arial',
    pos=(0, 0), height=0.1, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);

# Initialize components for Routine "end"
endClock = core.Clock()
text_4 = visual.TextStim(win=win, name='text_4',
    text='The experiment is over.\nThank you for participating.\nPress space complete your session.',
    font='Arial',
    pos=(0, 0), height=0.025, wrapWidth=None, ori=0, 
    color=[-1.000,-1.000,-1.000], colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
end_resp = keyboard.Keyboard()

# Create some handy timers
globalClock = core.Clock()  # to track the time since experiment started
routineTimer = core.CountdownTimer()  # to track time remaining of each (non-slip) routine 

# ------Prepare to start Routine "codeDefineImages"-------
# update component parameters for each repeat
# keep track of which components have finished
codeDefineImagesComponents = []
for thisComponent in codeDefineImagesComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED
# reset timers
t = 0
_timeToFirstFrame = win.getFutureFlipTime(clock="now")
codeDefineImagesClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
frameN = -1
continueRoutine = True

# -------Run Routine "codeDefineImages"-------
while continueRoutine:
    # get current time
    t = codeDefineImagesClock.getTime()
    tThisFlip = win.getFutureFlipTime(clock=codeDefineImagesClock)
    tThisFlipGlobal = win.getFutureFlipTime(clock=None)
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in codeDefineImagesComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "codeDefineImages"-------
for thisComponent in codeDefineImagesComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
# the Routine "codeDefineImages" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# ------Prepare to start Routine "codeSetupVars"-------
# update component parameters for each repeat
# keep track of which components have finished
codeSetupVarsComponents = []
for thisComponent in codeSetupVarsComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED
# reset timers
t = 0
_timeToFirstFrame = win.getFutureFlipTime(clock="now")
codeSetupVarsClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
frameN = -1
continueRoutine = True

# -------Run Routine "codeSetupVars"-------
while continueRoutine:
    # get current time
    t = codeSetupVarsClock.getTime()
    tThisFlip = win.getFutureFlipTime(clock=codeSetupVarsClock)
    tThisFlipGlobal = win.getFutureFlipTime(clock=None)
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in codeSetupVarsComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "codeSetupVars"-------
for thisComponent in codeSetupVarsComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
# the Routine "codeSetupVars" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# ------Prepare to start Routine "setupImageLists"-------
# update component parameters for each repeat
# keep track of which components have finished
setupImageListsComponents = []
for thisComponent in setupImageListsComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED
# reset timers
t = 0
_timeToFirstFrame = win.getFutureFlipTime(clock="now")
setupImageListsClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
frameN = -1
continueRoutine = True

# -------Run Routine "setupImageLists"-------
while continueRoutine:
    # get current time
    t = setupImageListsClock.getTime()
    tThisFlip = win.getFutureFlipTime(clock=setupImageListsClock)
    tThisFlipGlobal = win.getFutureFlipTime(clock=None)
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in setupImageListsComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "setupImageLists"-------
for thisComponent in setupImageListsComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
# the Routine "setupImageLists" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# ------Prepare to start Routine "ITI"-------
# update component parameters for each repeat
# keep track of which components have finished
ITIComponents = [text_14]
for thisComponent in ITIComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED
# reset timers
t = 0
_timeToFirstFrame = win.getFutureFlipTime(clock="now")
ITIClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
frameN = -1
continueRoutine = True

# -------Run Routine "ITI"-------
while continueRoutine:
    # get current time
    t = ITIClock.getTime()
    tThisFlip = win.getFutureFlipTime(clock=ITIClock)
    tThisFlipGlobal = win.getFutureFlipTime(clock=None)
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *text_14* updates
    if text_14.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
        # keep track of start time/frame for later
        text_14.frameNStart = frameN  # exact frame index
        text_14.tStart = t  # local t and not account for scr refresh
        text_14.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(text_14, 'tStartRefresh')  # time at next scr refresh
        text_14.setAutoDraw(True)
    if text_14.status == STARTED:
        # is it time to stop? (based on global clock, using actual start)
        if tThisFlipGlobal > text_14.tStartRefresh + ITI-frameTolerance:
            # keep track of stop time/frame for later
            text_14.tStop = t  # not accounting for scr refresh
            text_14.frameNStop = frameN  # exact frame index
            win.timeOnFlip(text_14, 'tStopRefresh')  # time at next scr refresh
            text_14.setAutoDraw(False)
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in ITIComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "ITI"-------
for thisComponent in ITIComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
thisExp.addData('text_14.started', text_14.tStartRefresh)
thisExp.addData('text_14.stopped', text_14.tStopRefresh)
# the Routine "ITI" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# ------Prepare to start Routine "study_instructions_routine"-------
# update component parameters for each repeat
study_instr_resp.keys = []
study_instr_resp.rt = []
# keep track of which components have finished
study_instructions_routineComponents = [study_instructions, study_instr_resp]
for thisComponent in study_instructions_routineComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED
# reset timers
t = 0
_timeToFirstFrame = win.getFutureFlipTime(clock="now")
study_instructions_routineClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
frameN = -1
continueRoutine = True

# -------Run Routine "study_instructions_routine"-------
while continueRoutine:
    # get current time
    t = study_instructions_routineClock.getTime()
    tThisFlip = win.getFutureFlipTime(clock=study_instructions_routineClock)
    tThisFlipGlobal = win.getFutureFlipTime(clock=None)
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *study_instructions* updates
    if study_instructions.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
        # keep track of start time/frame for later
        study_instructions.frameNStart = frameN  # exact frame index
        study_instructions.tStart = t  # local t and not account for scr refresh
        study_instructions.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(study_instructions, 'tStartRefresh')  # time at next scr refresh
        study_instructions.setAutoDraw(True)
    
    # *study_instr_resp* updates
    waitOnFlip = False
    if study_instr_resp.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
        # keep track of start time/frame for later
        study_instr_resp.frameNStart = frameN  # exact frame index
        study_instr_resp.tStart = t  # local t and not account for scr refresh
        study_instr_resp.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(study_instr_resp, 'tStartRefresh')  # time at next scr refresh
        study_instr_resp.status = STARTED
        # keyboard checking is just starting
        waitOnFlip = True
        win.callOnFlip(study_instr_resp.clock.reset)  # t=0 on next screen flip
        win.callOnFlip(study_instr_resp.clearEvents, eventType='keyboard')  # clear events on next screen flip
    if study_instr_resp.status == STARTED and not waitOnFlip:
        theseKeys = study_instr_resp.getKeys(keyList=['space'], waitRelease=False)
        if len(theseKeys):
            theseKeys = theseKeys[0]  # at least one key was pressed
            
            # check for quit:
            if "escape" == theseKeys:
                endExpNow = True
            study_instr_resp.keys = theseKeys.name  # just the last key pressed
            study_instr_resp.rt = theseKeys.rt
            # a response ends the routine
            continueRoutine = False
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in study_instructions_routineComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "study_instructions_routine"-------
for thisComponent in study_instructions_routineComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
thisExp.addData('study_instructions.started', study_instructions.tStartRefresh)
thisExp.addData('study_instructions.stopped', study_instructions.tStopRefresh)
# check responses
if study_instr_resp.keys in ['', [], None]:  # No response was made
    study_instr_resp.keys = None
thisExp.addData('study_instr_resp.keys',study_instr_resp.keys)
if study_instr_resp.keys != None:  # we had a response
    thisExp.addData('study_instr_resp.rt', study_instr_resp.rt)
thisExp.addData('study_instr_resp.started', study_instr_resp.tStartRefresh)
thisExp.addData('study_instr_resp.stopped', study_instr_resp.tStopRefresh)
thisExp.nextEntry()
# the Routine "study_instructions_routine" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# set up handler to look after randomisation of conditions etc
study_trials = data.TrialHandler(nReps=num_study, method='sequential', 
    extraInfo=expInfo, originPath=-1,
    trialList=[None],
    seed=None, name='study_trials')
thisExp.addLoop(study_trials)  # add the loop to the experiment
thisStudy_trial = study_trials.trialList[0]  # so we can initialise stimuli with some values
# abbreviate parameter names if possible (e.g. rgb = thisStudy_trial.rgb)
if thisStudy_trial != None:
    for paramName in thisStudy_trial:
        exec('{} = thisStudy_trial[paramName]'.format(paramName))

for thisStudy_trial in study_trials:
    currentLoop = study_trials
    # abbreviate parameter names if possible (e.g. rgb = thisStudy_trial.rgb)
    if thisStudy_trial != None:
        for paramName in thisStudy_trial:
            exec('{} = thisStudy_trial[paramName]'.format(paramName))
    
    # ------Prepare to start Routine "codeStudy"-------
    # update component parameters for each repeat
    study_img = study_images[cur_study_trial][0]
    
    
    thisExp.addData("StudyTrial",cur_study_trial+1)
    thisExp.addData("StudyImage",study_img)
    thisExp.addData("Condition",study_images[cur_study_trial][1])
    
    
    cur_study_trial += 1
    # keep track of which components have finished
    codeStudyComponents = []
    for thisComponent in codeStudyComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    codeStudyClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    continueRoutine = True
    
    # -------Run Routine "codeStudy"-------
    while continueRoutine:
        # get current time
        t = codeStudyClock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=codeStudyClock)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in codeStudyComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "codeStudy"-------
    for thisComponent in codeStudyComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    # the Routine "codeStudy" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    
    # ------Prepare to start Routine "study_trial"-------
    # update component parameters for each repeat
    study_outdoor_selected.setPos(right_resp_pos)
    study_outdoor_selected.setSize(circle_resp_size)
    study_outdoor.setPos(right_resp_pos)
    study_outdoor.setSize(circle_resp_size)
    study_indoor_selected.setPos(left_resp_pos)
    study_indoor_selected.setSize(circle_resp_size)
    study_indoor.setPos(left_resp_pos)
    study_indoor.setSize(circle_resp_size)
    study_image_shown.setSize(stim_size)
    study_image_shown.setImage(study_img)
    study_resp.keys = []
    study_resp.rt = []
    # keep track of which components have finished
    study_trialComponents = [study_outdoor_selected, study_outdoor, study_indoor_selected, study_indoor, study_image_shown, study_resp]
    for thisComponent in study_trialComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    study_trialClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    continueRoutine = True
    
    # -------Run Routine "study_trial"-------
    while continueRoutine:
        # get current time
        t = study_trialClock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=study_trialClock)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *study_outdoor_selected* updates
        if study_outdoor_selected.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            study_outdoor_selected.frameNStart = frameN  # exact frame index
            study_outdoor_selected.tStart = t  # local t and not account for scr refresh
            study_outdoor_selected.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(study_outdoor_selected, 'tStartRefresh')  # time at next scr refresh
            study_outdoor_selected.setAutoDraw(True)
        if study_outdoor_selected.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > study_outdoor_selected.tStartRefresh + trial_duration-frameTolerance:
                # keep track of stop time/frame for later
                study_outdoor_selected.tStop = t  # not accounting for scr refresh
                study_outdoor_selected.frameNStop = frameN  # exact frame index
                win.timeOnFlip(study_outdoor_selected, 'tStopRefresh')  # time at next scr refresh
                study_outdoor_selected.setAutoDraw(False)
        
        # *study_outdoor* updates
        if study_outdoor.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            study_outdoor.frameNStart = frameN  # exact frame index
            study_outdoor.tStart = t  # local t and not account for scr refresh
            study_outdoor.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(study_outdoor, 'tStartRefresh')  # time at next scr refresh
            study_outdoor.setAutoDraw(True)
        if study_outdoor.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > study_outdoor.tStartRefresh + trial_duration-frameTolerance:
                # keep track of stop time/frame for later
                study_outdoor.tStop = t  # not accounting for scr refresh
                study_outdoor.frameNStop = frameN  # exact frame index
                win.timeOnFlip(study_outdoor, 'tStopRefresh')  # time at next scr refresh
                study_outdoor.setAutoDraw(False)
        
        # *study_indoor_selected* updates
        if study_indoor_selected.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            study_indoor_selected.frameNStart = frameN  # exact frame index
            study_indoor_selected.tStart = t  # local t and not account for scr refresh
            study_indoor_selected.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(study_indoor_selected, 'tStartRefresh')  # time at next scr refresh
            study_indoor_selected.setAutoDraw(True)
        if study_indoor_selected.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > study_indoor_selected.tStartRefresh + trial_duration-frameTolerance:
                # keep track of stop time/frame for later
                study_indoor_selected.tStop = t  # not accounting for scr refresh
                study_indoor_selected.frameNStop = frameN  # exact frame index
                win.timeOnFlip(study_indoor_selected, 'tStopRefresh')  # time at next scr refresh
                study_indoor_selected.setAutoDraw(False)
        
        # *study_indoor* updates
        if study_indoor.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            study_indoor.frameNStart = frameN  # exact frame index
            study_indoor.tStart = t  # local t and not account for scr refresh
            study_indoor.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(study_indoor, 'tStartRefresh')  # time at next scr refresh
            study_indoor.setAutoDraw(True)
        if study_indoor.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > study_indoor.tStartRefresh + trial_duration-frameTolerance:
                # keep track of stop time/frame for later
                study_indoor.tStop = t  # not accounting for scr refresh
                study_indoor.frameNStop = frameN  # exact frame index
                win.timeOnFlip(study_indoor, 'tStopRefresh')  # time at next scr refresh
                study_indoor.setAutoDraw(False)
        
        # *study_image_shown* updates
        if study_image_shown.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            study_image_shown.frameNStart = frameN  # exact frame index
            study_image_shown.tStart = t  # local t and not account for scr refresh
            study_image_shown.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(study_image_shown, 'tStartRefresh')  # time at next scr refresh
            study_image_shown.setAutoDraw(True)
        if study_image_shown.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > study_image_shown.tStartRefresh + trial_duration-frameTolerance:
                # keep track of stop time/frame for later
                study_image_shown.tStop = t  # not accounting for scr refresh
                study_image_shown.frameNStop = frameN  # exact frame index
                win.timeOnFlip(study_image_shown, 'tStopRefresh')  # time at next scr refresh
                study_image_shown.setAutoDraw(False)
        
        # *study_resp* updates
        waitOnFlip = False
        if study_resp.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            study_resp.frameNStart = frameN  # exact frame index
            study_resp.tStart = t  # local t and not account for scr refresh
            study_resp.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(study_resp, 'tStartRefresh')  # time at next scr refresh
            study_resp.status = STARTED
            # keyboard checking is just starting
            waitOnFlip = True
            win.callOnFlip(study_resp.clock.reset)  # t=0 on next screen flip
            win.callOnFlip(study_resp.clearEvents, eventType='keyboard')  # clear events on next screen flip
        if study_resp.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > study_resp.tStartRefresh + trial_duration-frameTolerance:
                # keep track of stop time/frame for later
                study_resp.tStop = t  # not accounting for scr refresh
                study_resp.frameNStop = frameN  # exact frame index
                win.timeOnFlip(study_resp, 'tStopRefresh')  # time at next scr refresh
                study_resp.status = FINISHED
        if study_resp.status == STARTED and not waitOnFlip:
            theseKeys = study_resp.getKeys(keyList=['f', 'j'], waitRelease=False)
            if len(theseKeys):
                theseKeys = theseKeys[0]  # at least one key was pressed
                
                # check for quit:
                if "escape" == theseKeys:
                    endExpNow = True
                if study_resp.keys == []:  # then this was the first keypress
                    study_resp.keys = theseKeys.name  # just the first key pressed
                    study_resp.rt = theseKeys.rt
        if study_resp.keys == 'f':
            study_indoor_selected.opacity = 1
        if study_resp.keys == 'j':
            study_outdoor_selected.opacity = 1
        
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in study_trialComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "study_trial"-------
    for thisComponent in study_trialComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    study_trials.addData('study_outdoor_selected.started', study_outdoor_selected.tStartRefresh)
    study_trials.addData('study_outdoor_selected.stopped', study_outdoor_selected.tStopRefresh)
    study_trials.addData('study_outdoor.started', study_outdoor.tStartRefresh)
    study_trials.addData('study_outdoor.stopped', study_outdoor.tStopRefresh)
    study_trials.addData('study_indoor_selected.started', study_indoor_selected.tStartRefresh)
    study_trials.addData('study_indoor_selected.stopped', study_indoor_selected.tStopRefresh)
    study_trials.addData('study_indoor.started', study_indoor.tStartRefresh)
    study_trials.addData('study_indoor.stopped', study_indoor.tStopRefresh)
    study_trials.addData('study_image_shown.started', study_image_shown.tStartRefresh)
    study_trials.addData('study_image_shown.stopped', study_image_shown.tStopRefresh)
    # check responses
    if study_resp.keys in ['', [], None]:  # No response was made
        study_resp.keys = None
    study_trials.addData('study_resp.keys',study_resp.keys)
    if study_resp.keys != None:  # we had a response
        study_trials.addData('study_resp.rt', study_resp.rt)
    study_trials.addData('study_resp.started', study_resp.tStartRefresh)
    study_trials.addData('study_resp.stopped', study_resp.tStopRefresh)
    study_indoor_selected.opacity = 0
    study_outdoor_selected.opacity = 0
    
    # the Routine "study_trial" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    
    # ------Prepare to start Routine "ITI"-------
    # update component parameters for each repeat
    # keep track of which components have finished
    ITIComponents = [text_14]
    for thisComponent in ITIComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    ITIClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    continueRoutine = True
    
    # -------Run Routine "ITI"-------
    while continueRoutine:
        # get current time
        t = ITIClock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=ITIClock)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *text_14* updates
        if text_14.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            text_14.frameNStart = frameN  # exact frame index
            text_14.tStart = t  # local t and not account for scr refresh
            text_14.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(text_14, 'tStartRefresh')  # time at next scr refresh
            text_14.setAutoDraw(True)
        if text_14.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > text_14.tStartRefresh + ITI-frameTolerance:
                # keep track of stop time/frame for later
                text_14.tStop = t  # not accounting for scr refresh
                text_14.frameNStop = frameN  # exact frame index
                win.timeOnFlip(text_14, 'tStopRefresh')  # time at next scr refresh
                text_14.setAutoDraw(False)
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in ITIComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "ITI"-------
    for thisComponent in ITIComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    study_trials.addData('text_14.started', text_14.tStartRefresh)
    study_trials.addData('text_14.stopped', text_14.tStopRefresh)
    # the Routine "ITI" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    thisExp.nextEntry()
    
# completed num_study repeats of 'study_trials'


# ------Prepare to start Routine "end"-------
routineTimer.add(10.000000)
# update component parameters for each repeat
end_resp.keys = []
end_resp.rt = []
# keep track of which components have finished
endComponents = [text_4, end_resp]
for thisComponent in endComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED
# reset timers
t = 0
_timeToFirstFrame = win.getFutureFlipTime(clock="now")
endClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
frameN = -1
continueRoutine = True

# -------Run Routine "end"-------
while continueRoutine and routineTimer.getTime() > 0:
    # get current time
    t = endClock.getTime()
    tThisFlip = win.getFutureFlipTime(clock=endClock)
    tThisFlipGlobal = win.getFutureFlipTime(clock=None)
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *text_4* updates
    if text_4.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
        # keep track of start time/frame for later
        text_4.frameNStart = frameN  # exact frame index
        text_4.tStart = t  # local t and not account for scr refresh
        text_4.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(text_4, 'tStartRefresh')  # time at next scr refresh
        text_4.setAutoDraw(True)
    if text_4.status == STARTED:
        # is it time to stop? (based on global clock, using actual start)
        if tThisFlipGlobal > text_4.tStartRefresh + 10-frameTolerance:
            # keep track of stop time/frame for later
            text_4.tStop = t  # not accounting for scr refresh
            text_4.frameNStop = frameN  # exact frame index
            win.timeOnFlip(text_4, 'tStopRefresh')  # time at next scr refresh
            text_4.setAutoDraw(False)
    
    # *end_resp* updates
    waitOnFlip = False
    if end_resp.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
        # keep track of start time/frame for later
        end_resp.frameNStart = frameN  # exact frame index
        end_resp.tStart = t  # local t and not account for scr refresh
        end_resp.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(end_resp, 'tStartRefresh')  # time at next scr refresh
        end_resp.status = STARTED
        # keyboard checking is just starting
        waitOnFlip = True
        win.callOnFlip(end_resp.clock.reset)  # t=0 on next screen flip
        win.callOnFlip(end_resp.clearEvents, eventType='keyboard')  # clear events on next screen flip
    if end_resp.status == STARTED:
        # is it time to stop? (based on global clock, using actual start)
        if tThisFlipGlobal > end_resp.tStartRefresh + 10-frameTolerance:
            # keep track of stop time/frame for later
            end_resp.tStop = t  # not accounting for scr refresh
            end_resp.frameNStop = frameN  # exact frame index
            win.timeOnFlip(end_resp, 'tStopRefresh')  # time at next scr refresh
            end_resp.status = FINISHED
    if end_resp.status == STARTED and not waitOnFlip:
        theseKeys = end_resp.getKeys(keyList=['space'], waitRelease=False)
        if len(theseKeys):
            theseKeys = theseKeys[0]  # at least one key was pressed
            
            # check for quit:
            if "escape" == theseKeys:
                endExpNow = True
            end_resp.keys = theseKeys.name  # just the last key pressed
            end_resp.rt = theseKeys.rt
            # a response ends the routine
            continueRoutine = False
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in endComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "end"-------
for thisComponent in endComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
thisExp.addData('text_4.started', text_4.tStartRefresh)
thisExp.addData('text_4.stopped', text_4.tStopRefresh)
# check responses
if end_resp.keys in ['', [], None]:  # No response was made
    end_resp.keys = None
thisExp.addData('end_resp.keys',end_resp.keys)
if end_resp.keys != None:  # we had a response
    thisExp.addData('end_resp.rt', end_resp.rt)
thisExp.addData('end_resp.started', end_resp.tStartRefresh)
thisExp.addData('end_resp.stopped', end_resp.tStopRefresh)
thisExp.nextEntry()

# Flip one final time so any remaining win.callOnFlip() 
# and win.timeOnFlip() tasks get executed before quitting
win.flip()

# these shouldn't be strictly necessary (should auto-save)
thisExp.saveAsWideText(filename+'.csv')
thisExp.saveAsPickle(filename)
logging.flush()
# make sure everything is closed down
thisExp.abort()  # or data files will save again on exit
win.close()
core.quit()
