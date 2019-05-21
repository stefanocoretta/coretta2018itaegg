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

stereo$ = "../data/raw/stereo"
egg$ = "../data/raw/egg"

Create Strings as file list: "tg_list", "'stereo$'/*-palign-corrected.TextGrid"
tg_number = Get number of strings

writeInfoLine: "Found 'tg_number' files.'newline$'Starting now!'newline$'"

for file from 1 to tg_number

  selectObject: "Strings tg_list"
  file$ = Get string: file

  speaker$ = file$ - "-palign-corrected.TextGrid"
  appendInfoLine: "Processing 'speaker$'..."

  Read from file: "'stereo$'/'file$'"
  palign = selected("TextGrid")
  Read from file: "'egg$'/'speaker$'_egg.wav"
  egg = selected("Sound")

  appendInfoLine: "'tab$'Smoothing."
  
  @smoothing: 11
  
  egg_smoothed = selected("Sound")
  
  Create Sound from formula: "silence", 1, 0, time_lag, 44100, "0"
  silence = selected("Sound")
  selectObject: egg_smoothed, silence
  Save as WAV file: "'egg$'/'speaker$'_egg_smoothed.wav"
  
  appendInfoLine: "'tab$'Getting VUV"
  
  selectObject: egg_smoothed
  
  noprogress To PointProcess (periodic, cc): 75, 600
  
  To TextGrid (vuv): 0.02, 0
  
  # Extend time: time_lag, "Start"
  
  Write to text file: "'egg$'/'speaker$'-vuv.TextGrid"

endfor

appendInfoLine: "Done!"

procedure smoothing : .width
    .weight = .width / 2 + 0.5

    .formula$ = "( "

    for .w to .weight - 1
        .formula$ = .formula$ + string$(.w) + " * (self [col - " + string$(.w) + "] +
            ...self [col - " + string$(.w) + "]) + "
    endfor

    .formula$ = .formula$ + string$(.weight) + " * (self [col]) ) / " +
        ...string$(.weight ^ 2)

    Formula: .formula$

    .sampling_period = Get sampling period
    time_lag = (.width - 1) / 2 * .sampling_period
    Shift times by: time_lag
endproc
