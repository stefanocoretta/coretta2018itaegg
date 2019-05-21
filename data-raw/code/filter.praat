######################################
# This is a script from the project 'Vowel duration and consonant voicing: An
# articulatory study', Stefano Coretta
######################################
# MIT License
#
# Copyright (c) 2016-2018 Stefano Coretta
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
######################################
#
# !!! WARNING !!!
#
# This script is generated automatically, DO NOT EDIT
#
######################################

raw$ = "../data/raw/audio"
derived$ = "../data/derived"
Create Strings as file list: "file_list", "'raw$'/*.wav"
files = Get number of strings

stereo$ = "../data/raw/stereo"
audio$ = "../data/raw/audio"

Create Strings as file list: "tg_list", "'stereo$'/*-palign-corrected.TextGrid"
tg_number = Get number of strings

writeInfoLine: "'tg_number' files found.'newline$'Starting now.'newline$'"

for file from 1 to tg_number

  selectObject: "Strings tg_list"
  file$ = Get string: file
  Read from file: "'stereo$'/'file$'"
  palign = selected("TextGrid")
  speaker$ = file$ - "-palign-corrected.TextGrid"

  appendInfoLine: "Processing 'speaker$'..."

  speech_intervals = Get number of intervals: 3
  sound = Read from file: "'audio$'/'speaker$'.wav"
  textgrid = To TextGrid: "releases","releases"
  
  for speech_interval to speech_intervals
  
    selectObject: palign
    speech_label$ = Get label of interval: 3, speech_interval
  
    if speech_label$ == "speech"
      speech_start = Get start time of interval: 3, speech_interval
      frame_interval = Get interval at time: 2, speech_start
      word_1$ = Get label of interval: 2, frame_interval
  
      if word_1$ == "ha"
        frame_end = Get end time of interval: 2, frame_interval + 1
        c1_interval = Get interval at time: 1, frame_end
        c2_interval = c1_interval + 2
      else
        frame_end = Get end time of interval: 2, frame_interval
        c1_interval = Get interval at time: 1, frame_end
        c2_interval = c1_interval + 2
      endif
  
  
      c1_start = Get start time of interval: 1, c1_interval
      c1_end = Get end time of interval: 1, c1_interval
      c2_start = Get start time of interval: 1, c2_interval
      c2_end = Get end time of interval: 1, c2_interval
  
      @findRelease: c1_start, c1_end, "release_c1"
  
      @findRelease: c2_start, c2_end, "release_c2"
    endif
  
  endfor
  
  selectObject: textgrid
  Save as text file: "'audio$'/'speaker$'-rel.TextGrid"

  removeObject: palign, sound, textgrid

endfor
