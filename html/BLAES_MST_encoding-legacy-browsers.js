/*************************** 
 * Blaes_Mst_Encoding Test *
 ***************************/

// init psychoJS:
var psychoJS = new PsychoJS({
  debug: true
});

// open window:
psychoJS.openWindow({
  fullscr: true,
  color: new util.Color([1.0, 1.0, 1.0]),
  units: 'height',
  waitBlanking: true
});

// store info about the experiment session:
let expName = 'BLAES_MST_encoding';  // from the Builder filename that created this script
let expInfo = {'participant': '', 'First name': '', 'Last name': ''};

// schedule the experiment:
psychoJS.schedule(psychoJS.gui.DlgFromDict({
  dictionary: expInfo,
  title: expName
}));

const flowScheduler = new Scheduler(psychoJS);
const dialogCancelScheduler = new Scheduler(psychoJS);
psychoJS.scheduleCondition(function() { return (psychoJS.gui.dialogComponent.button === 'OK'); }, flowScheduler, dialogCancelScheduler);

// flowScheduler gets run if the participants presses OK
flowScheduler.add(updateInfo); // add timeStamp
flowScheduler.add(experimentInit);
flowScheduler.add(codeDefineImagesRoutineBegin);
flowScheduler.add(codeDefineImagesRoutineEachFrame);
flowScheduler.add(codeDefineImagesRoutineEnd);
flowScheduler.add(codeSetupVarsRoutineBegin);
flowScheduler.add(codeSetupVarsRoutineEachFrame);
flowScheduler.add(codeSetupVarsRoutineEnd);
flowScheduler.add(setupImageListsRoutineBegin);
flowScheduler.add(setupImageListsRoutineEachFrame);
flowScheduler.add(setupImageListsRoutineEnd);
flowScheduler.add(ITIRoutineBegin);
flowScheduler.add(ITIRoutineEachFrame);
flowScheduler.add(ITIRoutineEnd);
flowScheduler.add(study_instructions_routineRoutineBegin);
flowScheduler.add(study_instructions_routineRoutineEachFrame);
flowScheduler.add(study_instructions_routineRoutineEnd);
const study_trialsLoopScheduler = new Scheduler(psychoJS);
flowScheduler.add(study_trialsLoopBegin, study_trialsLoopScheduler);
flowScheduler.add(study_trialsLoopScheduler);
flowScheduler.add(study_trialsLoopEnd);
flowScheduler.add(endRoutineBegin);
flowScheduler.add(endRoutineEachFrame);
flowScheduler.add(endRoutineEnd);
flowScheduler.add(quitPsychoJS, '', true);

// quit if user presses Cancel in dialog box:
dialogCancelScheduler.add(quitPsychoJS, '', false);

psychoJS.start({expName, expInfo});

var frameDur;
function updateInfo() {
  expInfo['date'] = util.MonotonicClock.getDateStr();  // add a simple timestamp
  expInfo['expName'] = expName;
  expInfo['psychopyVersion'] = '3.2.4';
  expInfo['OS'] = window.navigator.platform;

  // store frame rate of monitor if we can measure it successfully
  expInfo['frameRate'] = psychoJS.window.getActualFrameRate();
  if (typeof expInfo['frameRate'] !== 'undefined')
    frameDur = 1.0/Math.round(expInfo['frameRate']);
  else
    frameDur = 1.0/60.0; // couldn't get a reliable measure so guess

  // add info from the URL:
  util.addInfoFromUrl(expInfo);
  
  return Scheduler.Event.NEXT;
}

var codeDefineImagesClock;
var codeSetupVarsClock;
var total_number_retrieval_sessions;
var num_targ_per_ret;
var num_foil_per_ret;
var num_hsim_per_ret;
var num_lsim_per_ret;
var ITI;
var trial_duration;
var image_width;
var image_height;
var stim_size;
var circle_resp_size;
var left_resp_pos;
var right_resp_pos;
var setupImageListsClock;
var ITIClock;
var text_14;
var study_instructions_routineClock;
var study_instructions;
var study_instr_resp;
var codeStudyClock;
var cur_study_trial;
var study_trialClock;
var study_outdoor_selected;
var study_outdoor;
var study_indoor_selected;
var study_indoor;
var study_image_shown;
var study_resp;
var endClock;
var text_4;
var end_resp;
var globalClock;
var routineTimer;
function experimentInit() {
  // Initialize components for Routine "codeDefineImages"
  codeDefineImagesClock = new util.Clock();
  /* Syntax Error: Fix Python code */
  // Initialize components for Routine "codeSetupVars"
  codeSetupVarsClock = new util.Clock();
  total_number_retrieval_sessions = 5;
  num_targ_per_ret = 50;
  num_foil_per_ret = 25;
  num_hsim_per_ret = 25;
  num_lsim_per_ret = 25;
  ITI = 1;
  trial_duration = 3;
  image_width = 0.5;
  image_height = 0.7;
  stim_size = [image_width, image_height];
  circle_resp_size = [0.2, 0.2];
  left_resp_pos = [(- 0.4), (- 0.4)];
  right_resp_pos = [0.4, (- 0.4)];
  
  // Initialize components for Routine "setupImageLists"
  setupImageListsClock = new util.Clock();
  /* Syntax Error: Fix Python code */
  // Initialize components for Routine "ITI"
  ITIClock = new util.Clock();
  text_14 = new visual.TextStim({
    win: psychoJS.window,
    name: 'text_14',
    text: '',
    font: 'Arial',
    units : undefined, 
    pos: [0, 0], height: 0.1,  wrapWidth: undefined, ori: 0,
    color: new util.Color('white'),  opacity: 1,
    depth: 0.0 
  });
  
  // Initialize components for Routine "study_instructions_routine"
  study_instructions_routineClock = new util.Clock();
  study_instructions = new visual.TextStim({
    win: psychoJS.window,
    name: 'study_instructions',
    text: "\n\nYou will be shown a series of images of objects. \nYou will decide whether each object belongs indoors or outdoors. \nIf you are unsure make your best guess.\n\nUse the 'F' key to respond 'Indoor', and the 'J' key to respond 'Outdoor'.\n'F': Indoor\n'J': Outdoor\n\nUse both of your index fingers, one on each key to \nrespond. Please keep your fingers on the keys at all times.\nYou have 3 seconds to respond to each object. The images will remain on the screen for 3 seconds even if you responded.\n\nOnce you have responded, you cannot change your answer.\nRespond as accurately and quickly as you can. \n\nPress the spacebar to start.",
    font: 'Arial',
    units : undefined, 
    pos: [0.5, 0], height: 0.025,  wrapWidth: undefined, ori: 0,
    color: new util.Color([(- 1.0), (- 1.0), (- 1.0)]),  opacity: 1,
    depth: 0.0 
  });
  
  study_instr_resp = new core.Keyboard({psychoJS, clock: new util.Clock(), waitForStart: true});
  
  // Initialize components for Routine "codeStudy"
  codeStudyClock = new util.Clock();
  cur_study_trial = 0;
  
  // Initialize components for Routine "study_trial"
  study_trialClock = new util.Clock();
  study_outdoor_selected = new visual.ImageStim({
    win : psychoJS.window,
    name : 'study_outdoor_selected', units : undefined, 
    image : 'all_images/outdoor_selected.png', mask : undefined,
    ori : 0, pos : [0, 0], size : 1.0,
    color : new util.Color([1, 1, 1]), opacity : 0,
    flipHoriz : false, flipVert : false,
    texRes : 512, interpolate : true, depth : 0.0 
  });
  study_outdoor = new visual.ImageStim({
    win : psychoJS.window,
    name : 'study_outdoor', units : undefined, 
    image : 'all_images/outdoor_unselected.png', mask : undefined,
    ori : 0, pos : [0, 0], size : 1.0,
    color : new util.Color([1, 1, 1]), opacity : 1,
    flipHoriz : false, flipVert : false,
    texRes : 512, interpolate : true, depth : -1.0 
  });
  study_indoor_selected = new visual.ImageStim({
    win : psychoJS.window,
    name : 'study_indoor_selected', units : undefined, 
    image : 'all_images/indoor_selected.png', mask : undefined,
    ori : 0, pos : [0, 0], size : 1.0,
    color : new util.Color([1, 1, 1]), opacity : 0,
    flipHoriz : false, flipVert : false,
    texRes : 512, interpolate : true, depth : -2.0 
  });
  study_indoor = new visual.ImageStim({
    win : psychoJS.window,
    name : 'study_indoor', units : undefined, 
    image : 'all_images/indoor_unselected.png', mask : undefined,
    ori : 0, pos : [0, 0], size : 1.0,
    color : new util.Color([1, 1, 1]), opacity : 1,
    flipHoriz : false, flipVert : false,
    texRes : 512, interpolate : true, depth : -3.0 
  });
  study_image_shown = new visual.ImageStim({
    win : psychoJS.window,
    name : 'study_image_shown', units : 'norm', 
    image : undefined, mask : undefined,
    ori : 0, pos : [0, 0], size : 1.0,
    color : new util.Color([1, 1, 1]), opacity : 1,
    flipHoriz : false, flipVert : false,
    texRes : 512, interpolate : true, depth : -4.0 
  });
  study_resp = new core.Keyboard({psychoJS, clock: new util.Clock(), waitForStart: true});
  
  // Initialize components for Routine "ITI"
  ITIClock = new util.Clock();
  text_14 = new visual.TextStim({
    win: psychoJS.window,
    name: 'text_14',
    text: '',
    font: 'Arial',
    units : undefined, 
    pos: [0, 0], height: 0.1,  wrapWidth: undefined, ori: 0,
    color: new util.Color('white'),  opacity: 1,
    depth: 0.0 
  });
  
  // Initialize components for Routine "end"
  endClock = new util.Clock();
  text_4 = new visual.TextStim({
    win: psychoJS.window,
    name: 'text_4',
    text: 'The experiment is over.\nThank you for participating.\nPress space complete your session.',
    font: 'Arial',
    units : undefined, 
    pos: [0, 0], height: 0.025,  wrapWidth: undefined, ori: 0,
    color: new util.Color([(- 1.0), (- 1.0), (- 1.0)]),  opacity: 1,
    depth: 0.0 
  });
  
  end_resp = new core.Keyboard({psychoJS, clock: new util.Clock(), waitForStart: true});
  
  // Create some handy timers
  globalClock = new util.Clock();  // to track the time since experiment started
  routineTimer = new util.CountdownTimer();  // to track time remaining of each (non-slip) routine
  
  return Scheduler.Event.NEXT;
}

var t;
var frameN;
var codeDefineImagesComponents;
function codeDefineImagesRoutineBegin() {
  //------Prepare to start Routine 'codeDefineImages'-------
  t = 0;
  codeDefineImagesClock.reset(); // clock
  frameN = -1;
  // update component parameters for each repeat
  // keep track of which components have finished
  codeDefineImagesComponents = [];
  
  codeDefineImagesComponents.forEach( function(thisComponent) {
    if ('status' in thisComponent)
      thisComponent.status = PsychoJS.Status.NOT_STARTED;
     });
  
  return Scheduler.Event.NEXT;
}

var continueRoutine;
function codeDefineImagesRoutineEachFrame() {
  //------Loop for each frame of Routine 'codeDefineImages'-------
  let continueRoutine = true; // until we're told otherwise
  // get current time
  t = codeDefineImagesClock.getTime();
  frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
  // update/draw components on each frame
  // check for quit (typically the Esc key)
  if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
    return psychoJS.quit('The [Escape] key was pressed. Goodbye!', false);
  }
  
  // check if the Routine should terminate
  if (!continueRoutine) {  // a component has requested a forced-end of Routine
    return Scheduler.Event.NEXT;
  }
  
  continueRoutine = false;  // reverts to True if at least one component still running
  codeDefineImagesComponents.forEach( function(thisComponent) {
    if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
      continueRoutine = true;
    }});
  
  // refresh the screen if continuing
  if (continueRoutine) {
    return Scheduler.Event.FLIP_REPEAT;
  }
  else {
    return Scheduler.Event.NEXT;
  }
}


function codeDefineImagesRoutineEnd() {
  //------Ending Routine 'codeDefineImages'-------
  codeDefineImagesComponents.forEach( function(thisComponent) {
    if (typeof thisComponent.setAutoDraw === 'function') {
      thisComponent.setAutoDraw(false);
    }});
  // the Routine "codeDefineImages" was not non-slip safe, so reset the non-slip timer
  routineTimer.reset();
  
  return Scheduler.Event.NEXT;
}

var codeSetupVarsComponents;
function codeSetupVarsRoutineBegin() {
  //------Prepare to start Routine 'codeSetupVars'-------
  t = 0;
  codeSetupVarsClock.reset(); // clock
  frameN = -1;
  // update component parameters for each repeat
  // keep track of which components have finished
  codeSetupVarsComponents = [];
  
  codeSetupVarsComponents.forEach( function(thisComponent) {
    if ('status' in thisComponent)
      thisComponent.status = PsychoJS.Status.NOT_STARTED;
     });
  
  return Scheduler.Event.NEXT;
}


function codeSetupVarsRoutineEachFrame() {
  //------Loop for each frame of Routine 'codeSetupVars'-------
  let continueRoutine = true; // until we're told otherwise
  // get current time
  t = codeSetupVarsClock.getTime();
  frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
  // update/draw components on each frame
  // check for quit (typically the Esc key)
  if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
    return psychoJS.quit('The [Escape] key was pressed. Goodbye!', false);
  }
  
  // check if the Routine should terminate
  if (!continueRoutine) {  // a component has requested a forced-end of Routine
    return Scheduler.Event.NEXT;
  }
  
  continueRoutine = false;  // reverts to True if at least one component still running
  codeSetupVarsComponents.forEach( function(thisComponent) {
    if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
      continueRoutine = true;
    }});
  
  // refresh the screen if continuing
  if (continueRoutine) {
    return Scheduler.Event.FLIP_REPEAT;
  }
  else {
    return Scheduler.Event.NEXT;
  }
}


function codeSetupVarsRoutineEnd() {
  //------Ending Routine 'codeSetupVars'-------
  codeSetupVarsComponents.forEach( function(thisComponent) {
    if (typeof thisComponent.setAutoDraw === 'function') {
      thisComponent.setAutoDraw(false);
    }});
  // the Routine "codeSetupVars" was not non-slip safe, so reset the non-slip timer
  routineTimer.reset();
  
  return Scheduler.Event.NEXT;
}

var setupImageListsComponents;
function setupImageListsRoutineBegin() {
  //------Prepare to start Routine 'setupImageLists'-------
  t = 0;
  setupImageListsClock.reset(); // clock
  frameN = -1;
  // update component parameters for each repeat
  // keep track of which components have finished
  setupImageListsComponents = [];
  
  setupImageListsComponents.forEach( function(thisComponent) {
    if ('status' in thisComponent)
      thisComponent.status = PsychoJS.Status.NOT_STARTED;
     });
  
  return Scheduler.Event.NEXT;
}


function setupImageListsRoutineEachFrame() {
  //------Loop for each frame of Routine 'setupImageLists'-------
  let continueRoutine = true; // until we're told otherwise
  // get current time
  t = setupImageListsClock.getTime();
  frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
  // update/draw components on each frame
  // check for quit (typically the Esc key)
  if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
    return psychoJS.quit('The [Escape] key was pressed. Goodbye!', false);
  }
  
  // check if the Routine should terminate
  if (!continueRoutine) {  // a component has requested a forced-end of Routine
    return Scheduler.Event.NEXT;
  }
  
  continueRoutine = false;  // reverts to True if at least one component still running
  setupImageListsComponents.forEach( function(thisComponent) {
    if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
      continueRoutine = true;
    }});
  
  // refresh the screen if continuing
  if (continueRoutine) {
    return Scheduler.Event.FLIP_REPEAT;
  }
  else {
    return Scheduler.Event.NEXT;
  }
}


function setupImageListsRoutineEnd() {
  //------Ending Routine 'setupImageLists'-------
  setupImageListsComponents.forEach( function(thisComponent) {
    if (typeof thisComponent.setAutoDraw === 'function') {
      thisComponent.setAutoDraw(false);
    }});
  // the Routine "setupImageLists" was not non-slip safe, so reset the non-slip timer
  routineTimer.reset();
  
  return Scheduler.Event.NEXT;
}

var ITIComponents;
function ITIRoutineBegin() {
  //------Prepare to start Routine 'ITI'-------
  t = 0;
  ITIClock.reset(); // clock
  frameN = -1;
  // update component parameters for each repeat
  // keep track of which components have finished
  ITIComponents = [];
  ITIComponents.push(text_14);
  
  ITIComponents.forEach( function(thisComponent) {
    if ('status' in thisComponent)
      thisComponent.status = PsychoJS.Status.NOT_STARTED;
     });
  
  return Scheduler.Event.NEXT;
}

var frameRemains;
function ITIRoutineEachFrame() {
  //------Loop for each frame of Routine 'ITI'-------
  let continueRoutine = true; // until we're told otherwise
  // get current time
  t = ITIClock.getTime();
  frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
  // update/draw components on each frame
  
  // *text_14* updates
  if (t >= 0.0 && text_14.status === PsychoJS.Status.NOT_STARTED) {
    // keep track of start time/frame for later
    text_14.tStart = t;  // (not accounting for frame time here)
    text_14.frameNStart = frameN;  // exact frame index
    text_14.setAutoDraw(true);
  }

  frameRemains = 0.0 + ITI - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
  if (text_14.status === PsychoJS.Status.STARTED && t >= frameRemains) {
    text_14.setAutoDraw(false);
  }
  // check for quit (typically the Esc key)
  if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
    return psychoJS.quit('The [Escape] key was pressed. Goodbye!', false);
  }
  
  // check if the Routine should terminate
  if (!continueRoutine) {  // a component has requested a forced-end of Routine
    return Scheduler.Event.NEXT;
  }
  
  continueRoutine = false;  // reverts to True if at least one component still running
  ITIComponents.forEach( function(thisComponent) {
    if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
      continueRoutine = true;
    }});
  
  // refresh the screen if continuing
  if (continueRoutine) {
    return Scheduler.Event.FLIP_REPEAT;
  }
  else {
    return Scheduler.Event.NEXT;
  }
}


function ITIRoutineEnd() {
  //------Ending Routine 'ITI'-------
  ITIComponents.forEach( function(thisComponent) {
    if (typeof thisComponent.setAutoDraw === 'function') {
      thisComponent.setAutoDraw(false);
    }});
  // the Routine "ITI" was not non-slip safe, so reset the non-slip timer
  routineTimer.reset();
  
  return Scheduler.Event.NEXT;
}

var study_instructions_routineComponents;
function study_instructions_routineRoutineBegin() {
  //------Prepare to start Routine 'study_instructions_routine'-------
  t = 0;
  study_instructions_routineClock.reset(); // clock
  frameN = -1;
  // update component parameters for each repeat
  study_instr_resp.keys = undefined;
  study_instr_resp.rt = undefined;
  // keep track of which components have finished
  study_instructions_routineComponents = [];
  study_instructions_routineComponents.push(study_instructions);
  study_instructions_routineComponents.push(study_instr_resp);
  
  study_instructions_routineComponents.forEach( function(thisComponent) {
    if ('status' in thisComponent)
      thisComponent.status = PsychoJS.Status.NOT_STARTED;
     });
  
  return Scheduler.Event.NEXT;
}


function study_instructions_routineRoutineEachFrame() {
  //------Loop for each frame of Routine 'study_instructions_routine'-------
  let continueRoutine = true; // until we're told otherwise
  // get current time
  t = study_instructions_routineClock.getTime();
  frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
  // update/draw components on each frame
  
  // *study_instructions* updates
  if (t >= 0.0 && study_instructions.status === PsychoJS.Status.NOT_STARTED) {
    // keep track of start time/frame for later
    study_instructions.tStart = t;  // (not accounting for frame time here)
    study_instructions.frameNStart = frameN;  // exact frame index
    study_instructions.setAutoDraw(true);
  }

  
  // *study_instr_resp* updates
  if (t >= 0.0 && study_instr_resp.status === PsychoJS.Status.NOT_STARTED) {
    // keep track of start time/frame for later
    study_instr_resp.tStart = t;  // (not accounting for frame time here)
    study_instr_resp.frameNStart = frameN;  // exact frame index
    // keyboard checking is just starting
    psychoJS.window.callOnFlip(function() { study_instr_resp.clock.reset(); });  // t=0 on next screen flip
    psychoJS.window.callOnFlip(function() { study_instr_resp.start(); }); // start on screen flip
    psychoJS.window.callOnFlip(function() { study_instr_resp.clearEvents(); });
  }

  if (study_instr_resp.status === PsychoJS.Status.STARTED) {
    let theseKeys = study_instr_resp.getKeys({keyList: ['space'], waitRelease: false});
    
    // check for quit:
    if (theseKeys.length > 0 && theseKeys[0].name === 'escape') {
      psychoJS.experiment.experimentEnded = true;
    }
    
    if (theseKeys.length > 0) {  // at least one key was pressed
      study_instr_resp.keys = theseKeys[0].name;  // just the last key pressed
      study_instr_resp.rt = theseKeys[0].rt;
      // a response ends the routine
      continueRoutine = false;
    }
  }
  
  // check for quit (typically the Esc key)
  if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
    return psychoJS.quit('The [Escape] key was pressed. Goodbye!', false);
  }
  
  // check if the Routine should terminate
  if (!continueRoutine) {  // a component has requested a forced-end of Routine
    return Scheduler.Event.NEXT;
  }
  
  continueRoutine = false;  // reverts to True if at least one component still running
  study_instructions_routineComponents.forEach( function(thisComponent) {
    if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
      continueRoutine = true;
    }});
  
  // refresh the screen if continuing
  if (continueRoutine) {
    return Scheduler.Event.FLIP_REPEAT;
  }
  else {
    return Scheduler.Event.NEXT;
  }
}


function study_instructions_routineRoutineEnd() {
  //------Ending Routine 'study_instructions_routine'-------
  study_instructions_routineComponents.forEach( function(thisComponent) {
    if (typeof thisComponent.setAutoDraw === 'function') {
      thisComponent.setAutoDraw(false);
    }});
  psychoJS.experiment.addData('study_instr_resp.keys', study_instr_resp.keys);
  if (typeof study_instr_resp.keys !== undefined) {  // we had a response
      psychoJS.experiment.addData('study_instr_resp.rt', study_instr_resp.rt);
      routineTimer.reset();
      }
  
  study_instr_resp.stop();
  // the Routine "study_instructions_routine" was not non-slip safe, so reset the non-slip timer
  routineTimer.reset();
  
  return Scheduler.Event.NEXT;
}

var study_trials;
var currentLoop;
var trialIterator;
function study_trialsLoopBegin(thisScheduler) {
  // set up handler to look after randomisation of conditions etc
  study_trials = new TrialHandler({
    psychoJS: psychoJS,
    nReps: num_study, method: TrialHandler.Method.SEQUENTIAL,
    extraInfo: expInfo, originPath: undefined,
    trialList: undefined,
    seed: undefined, name: 'study_trials'});
  psychoJS.experiment.addLoop(study_trials); // add the loop to the experiment
  currentLoop = study_trials;  // we're now the current loop

  // Schedule all the trials in the trialList:
  trialIterator = study_trials[Symbol.iterator]();
  while(true) {
    let result = trialIterator.next();
    if (result.done);
      break;
    let thisStudy_trial = result.value;
    thisScheduler.add(importConditions(study_trials));
    thisScheduler.add(codeStudyRoutineBegin);
    thisScheduler.add(codeStudyRoutineEachFrame);
    thisScheduler.add(codeStudyRoutineEnd);
    thisScheduler.add(study_trialRoutineBegin);
    thisScheduler.add(study_trialRoutineEachFrame);
    thisScheduler.add(study_trialRoutineEnd);
    thisScheduler.add(ITIRoutineBegin);
    thisScheduler.add(ITIRoutineEachFrame);
    thisScheduler.add(ITIRoutineEnd);
    thisScheduler.add(endLoopIteration({thisScheduler, isTrials : true}));
  }

  return Scheduler.Event.NEXT;
}


function study_trialsLoopEnd() {
  psychoJS.experiment.removeLoop(study_trials);

  return Scheduler.Event.NEXT;
}

var study_img;
var codeStudyComponents;
function codeStudyRoutineBegin() {
  //------Prepare to start Routine 'codeStudy'-------
  t = 0;
  codeStudyClock.reset(); // clock
  frameN = -1;
  // update component parameters for each repeat
  study_img = study_images[cur_study_trial][0];
  thisExp.addData("StudyTrial", (cur_study_trial + 1));
  thisExp.addData("StudyImage", study_img);
  thisExp.addData("Condition", study_images[cur_study_trial][3]);
  cur_study_trial += 1;
  
  // keep track of which components have finished
  codeStudyComponents = [];
  
  codeStudyComponents.forEach( function(thisComponent) {
    if ('status' in thisComponent)
      thisComponent.status = PsychoJS.Status.NOT_STARTED;
     });
  
  return Scheduler.Event.NEXT;
}


function codeStudyRoutineEachFrame() {
  //------Loop for each frame of Routine 'codeStudy'-------
  let continueRoutine = true; // until we're told otherwise
  // get current time
  t = codeStudyClock.getTime();
  frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
  // update/draw components on each frame
  // check for quit (typically the Esc key)
  if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
    return psychoJS.quit('The [Escape] key was pressed. Goodbye!', false);
  }
  
  // check if the Routine should terminate
  if (!continueRoutine) {  // a component has requested a forced-end of Routine
    return Scheduler.Event.NEXT;
  }
  
  continueRoutine = false;  // reverts to True if at least one component still running
  codeStudyComponents.forEach( function(thisComponent) {
    if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
      continueRoutine = true;
    }});
  
  // refresh the screen if continuing
  if (continueRoutine) {
    return Scheduler.Event.FLIP_REPEAT;
  }
  else {
    return Scheduler.Event.NEXT;
  }
}


function codeStudyRoutineEnd() {
  //------Ending Routine 'codeStudy'-------
  codeStudyComponents.forEach( function(thisComponent) {
    if (typeof thisComponent.setAutoDraw === 'function') {
      thisComponent.setAutoDraw(false);
    }});
  // the Routine "codeStudy" was not non-slip safe, so reset the non-slip timer
  routineTimer.reset();
  
  return Scheduler.Event.NEXT;
}

var study_trialComponents;
function study_trialRoutineBegin() {
  //------Prepare to start Routine 'study_trial'-------
  t = 0;
  study_trialClock.reset(); // clock
  frameN = -1;
  // update component parameters for each repeat
  study_outdoor_selected.setPos(right_resp_pos);
  study_outdoor_selected.setSize(circle_resp_size);
  study_outdoor.setPos(right_resp_pos);
  study_outdoor.setSize(circle_resp_size);
  study_indoor_selected.setPos(left_resp_pos);
  study_indoor_selected.setSize(circle_resp_size);
  study_indoor.setPos(left_resp_pos);
  study_indoor.setSize(circle_resp_size);
  study_image_shown.setSize(stim_size);
  study_image_shown.setImage(study_img);
  study_resp.keys = undefined;
  study_resp.rt = undefined;
  // keep track of which components have finished
  study_trialComponents = [];
  study_trialComponents.push(study_outdoor_selected);
  study_trialComponents.push(study_outdoor);
  study_trialComponents.push(study_indoor_selected);
  study_trialComponents.push(study_indoor);
  study_trialComponents.push(study_image_shown);
  study_trialComponents.push(study_resp);
  
  study_trialComponents.forEach( function(thisComponent) {
    if ('status' in thisComponent)
      thisComponent.status = PsychoJS.Status.NOT_STARTED;
     });
  
  return Scheduler.Event.NEXT;
}


function study_trialRoutineEachFrame() {
  //------Loop for each frame of Routine 'study_trial'-------
  let continueRoutine = true; // until we're told otherwise
  // get current time
  t = study_trialClock.getTime();
  frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
  // update/draw components on each frame
  
  // *study_outdoor_selected* updates
  if (t >= 0.0 && study_outdoor_selected.status === PsychoJS.Status.NOT_STARTED) {
    // keep track of start time/frame for later
    study_outdoor_selected.tStart = t;  // (not accounting for frame time here)
    study_outdoor_selected.frameNStart = frameN;  // exact frame index
    study_outdoor_selected.setAutoDraw(true);
  }

  frameRemains = 0.0 + trial_duration - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
  if (study_outdoor_selected.status === PsychoJS.Status.STARTED && t >= frameRemains) {
    study_outdoor_selected.setAutoDraw(false);
  }
  
  // *study_outdoor* updates
  if (t >= 0.0 && study_outdoor.status === PsychoJS.Status.NOT_STARTED) {
    // keep track of start time/frame for later
    study_outdoor.tStart = t;  // (not accounting for frame time here)
    study_outdoor.frameNStart = frameN;  // exact frame index
    study_outdoor.setAutoDraw(true);
  }

  frameRemains = 0.0 + trial_duration - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
  if (study_outdoor.status === PsychoJS.Status.STARTED && t >= frameRemains) {
    study_outdoor.setAutoDraw(false);
  }
  
  // *study_indoor_selected* updates
  if (t >= 0.0 && study_indoor_selected.status === PsychoJS.Status.NOT_STARTED) {
    // keep track of start time/frame for later
    study_indoor_selected.tStart = t;  // (not accounting for frame time here)
    study_indoor_selected.frameNStart = frameN;  // exact frame index
    study_indoor_selected.setAutoDraw(true);
  }

  frameRemains = 0.0 + trial_duration - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
  if (study_indoor_selected.status === PsychoJS.Status.STARTED && t >= frameRemains) {
    study_indoor_selected.setAutoDraw(false);
  }
  
  // *study_indoor* updates
  if (t >= 0.0 && study_indoor.status === PsychoJS.Status.NOT_STARTED) {
    // keep track of start time/frame for later
    study_indoor.tStart = t;  // (not accounting for frame time here)
    study_indoor.frameNStart = frameN;  // exact frame index
    study_indoor.setAutoDraw(true);
  }

  frameRemains = 0.0 + trial_duration - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
  if (study_indoor.status === PsychoJS.Status.STARTED && t >= frameRemains) {
    study_indoor.setAutoDraw(false);
  }
  
  // *study_image_shown* updates
  if (t >= 0.0 && study_image_shown.status === PsychoJS.Status.NOT_STARTED) {
    // keep track of start time/frame for later
    study_image_shown.tStart = t;  // (not accounting for frame time here)
    study_image_shown.frameNStart = frameN;  // exact frame index
    study_image_shown.setAutoDraw(true);
  }

  frameRemains = 0.0 + trial_duration - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
  if (study_image_shown.status === PsychoJS.Status.STARTED && t >= frameRemains) {
    study_image_shown.setAutoDraw(false);
  }
  
  // *study_resp* updates
  if (t >= 0.0 && study_resp.status === PsychoJS.Status.NOT_STARTED) {
    // keep track of start time/frame for later
    study_resp.tStart = t;  // (not accounting for frame time here)
    study_resp.frameNStart = frameN;  // exact frame index
    // keyboard checking is just starting
    psychoJS.window.callOnFlip(function() { study_resp.clock.reset(); });  // t=0 on next screen flip
    psychoJS.window.callOnFlip(function() { study_resp.start(); }); // start on screen flip
    psychoJS.window.callOnFlip(function() { study_resp.clearEvents(); });
  }

  frameRemains = 0.0 + trial_duration - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
  if (study_resp.status === PsychoJS.Status.STARTED && t >= frameRemains) {
    study_resp.status = PsychoJS.Status.FINISHED;
  }

  if (study_resp.status === PsychoJS.Status.STARTED) {
    let theseKeys = study_resp.getKeys({keyList: ['f', 'j'], waitRelease: false});
    
    // check for quit:
    if (theseKeys.length > 0 && theseKeys[0].name === 'escape') {
      psychoJS.experiment.experimentEnded = true;
    }
    
    if (theseKeys.length > 0) {  // at least one key was pressed
      if (study_resp.keys === undefined) {  // then this was the first keypress
        study_resp.keys = theseKeys[0].name;  // just the first key pressed
        study_resp.rt = theseKeys[0].rt;
      }
    }
  }
  
  if ((study_resp.keys === "f")) {
      study_indoor_selected.opacity = 1;
  }
  if ((study_resp.keys === "j")) {
      study_outdoor_selected.opacity = 1;
  }
  
  // check for quit (typically the Esc key)
  if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
    return psychoJS.quit('The [Escape] key was pressed. Goodbye!', false);
  }
  
  // check if the Routine should terminate
  if (!continueRoutine) {  // a component has requested a forced-end of Routine
    return Scheduler.Event.NEXT;
  }
  
  continueRoutine = false;  // reverts to True if at least one component still running
  study_trialComponents.forEach( function(thisComponent) {
    if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
      continueRoutine = true;
    }});
  
  // refresh the screen if continuing
  if (continueRoutine) {
    return Scheduler.Event.FLIP_REPEAT;
  }
  else {
    return Scheduler.Event.NEXT;
  }
}


function study_trialRoutineEnd() {
  //------Ending Routine 'study_trial'-------
  study_trialComponents.forEach( function(thisComponent) {
    if (typeof thisComponent.setAutoDraw === 'function') {
      thisComponent.setAutoDraw(false);
    }});
  psychoJS.experiment.addData('study_resp.keys', study_resp.keys);
  if (typeof study_resp.keys !== undefined) {  // we had a response
      psychoJS.experiment.addData('study_resp.rt', study_resp.rt);
      }
  
  study_resp.stop();
  study_indoor_selected.opacity = 0;
  study_outdoor_selected.opacity = 0;
  
  // the Routine "study_trial" was not non-slip safe, so reset the non-slip timer
  routineTimer.reset();
  
  return Scheduler.Event.NEXT;
}

var endComponents;
function endRoutineBegin() {
  //------Prepare to start Routine 'end'-------
  t = 0;
  endClock.reset(); // clock
  frameN = -1;
  routineTimer.add(10.000000);
  // update component parameters for each repeat
  end_resp.keys = undefined;
  end_resp.rt = undefined;
  // keep track of which components have finished
  endComponents = [];
  endComponents.push(text_4);
  endComponents.push(end_resp);
  
  endComponents.forEach( function(thisComponent) {
    if ('status' in thisComponent)
      thisComponent.status = PsychoJS.Status.NOT_STARTED;
     });
  
  return Scheduler.Event.NEXT;
}


function endRoutineEachFrame() {
  //------Loop for each frame of Routine 'end'-------
  let continueRoutine = true; // until we're told otherwise
  // get current time
  t = endClock.getTime();
  frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
  // update/draw components on each frame
  
  // *text_4* updates
  if (t >= 0.0 && text_4.status === PsychoJS.Status.NOT_STARTED) {
    // keep track of start time/frame for later
    text_4.tStart = t;  // (not accounting for frame time here)
    text_4.frameNStart = frameN;  // exact frame index
    text_4.setAutoDraw(true);
  }

  frameRemains = 0.0 + 10 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
  if (text_4.status === PsychoJS.Status.STARTED && t >= frameRemains) {
    text_4.setAutoDraw(false);
  }
  
  // *end_resp* updates
  if (t >= 0.0 && end_resp.status === PsychoJS.Status.NOT_STARTED) {
    // keep track of start time/frame for later
    end_resp.tStart = t;  // (not accounting for frame time here)
    end_resp.frameNStart = frameN;  // exact frame index
    // keyboard checking is just starting
    psychoJS.window.callOnFlip(function() { end_resp.clock.reset(); });  // t=0 on next screen flip
    psychoJS.window.callOnFlip(function() { end_resp.start(); }); // start on screen flip
    psychoJS.window.callOnFlip(function() { end_resp.clearEvents(); });
  }

  frameRemains = 0.0 + 10 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
  if (end_resp.status === PsychoJS.Status.STARTED && t >= frameRemains) {
    end_resp.status = PsychoJS.Status.FINISHED;
  }

  if (end_resp.status === PsychoJS.Status.STARTED) {
    let theseKeys = end_resp.getKeys({keyList: ['space'], waitRelease: false});
    
    // check for quit:
    if (theseKeys.length > 0 && theseKeys[0].name === 'escape') {
      psychoJS.experiment.experimentEnded = true;
    }
    
    if (theseKeys.length > 0) {  // at least one key was pressed
      end_resp.keys = theseKeys[0].name;  // just the last key pressed
      end_resp.rt = theseKeys[0].rt;
      // a response ends the routine
      continueRoutine = false;
    }
  }
  
  // check for quit (typically the Esc key)
  if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
    return psychoJS.quit('The [Escape] key was pressed. Goodbye!', false);
  }
  
  // check if the Routine should terminate
  if (!continueRoutine) {  // a component has requested a forced-end of Routine
    return Scheduler.Event.NEXT;
  }
  
  continueRoutine = false;  // reverts to True if at least one component still running
  endComponents.forEach( function(thisComponent) {
    if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
      continueRoutine = true;
    }});
  
  // refresh the screen if continuing
  if (continueRoutine && routineTimer.getTime() > 0) {
    return Scheduler.Event.FLIP_REPEAT;
  }
  else {
    return Scheduler.Event.NEXT;
  }
}


function endRoutineEnd() {
  //------Ending Routine 'end'-------
  endComponents.forEach( function(thisComponent) {
    if (typeof thisComponent.setAutoDraw === 'function') {
      thisComponent.setAutoDraw(false);
    }});
  psychoJS.experiment.addData('end_resp.keys', end_resp.keys);
  if (typeof end_resp.keys !== undefined) {  // we had a response
      psychoJS.experiment.addData('end_resp.rt', end_resp.rt);
      routineTimer.reset();
      }
  
  end_resp.stop();
  return Scheduler.Event.NEXT;
}


function endLoopIteration({thisScheduler, isTrials=true}) {
  // ------Prepare for next entry------
  return function () {
    // ------Check if user ended loop early------
    if (currentLoop.finished) {
      // Check for and save orphaned data
      if (Object.keys(psychoJS.experiment._thisEntry).length > 0) {
        psychoJS.experiment.nextEntry();
      }
      thisScheduler.stop();
    } else if (isTrials) {
      psychoJS.experiment.nextEntry();
    }
  return Scheduler.Event.NEXT;
  };
}


function importConditions(loop) {
  const trialIndex = loop.getTrialIndex();
  return function () {
    loop.setTrialIndex(trialIndex);
    psychoJS.importAttributes(loop.getCurrentTrial());
    return Scheduler.Event.NEXT;
    };
}


function quitPsychoJS(message, isCompleted) {
  // Check for and save orphaned data
  if (Object.keys(psychoJS.experiment._thisEntry).length > 0) {
    psychoJS.experiment.nextEntry();
  }
  psychoJS.window.close();
  psychoJS.quit({message: message, isCompleted: isCompleted});

  return Scheduler.Event.QUIT;
}
