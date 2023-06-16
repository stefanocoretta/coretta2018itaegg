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
align_list = Create Strings as file list: "align_list", "'stereo$'/*-palign-corrected.TextGrid"
n_files = Get number of strings

writeInfoLine: "'n_files' files found. Start processing.'newline$'"

for textgrid from 1 to n_files

  selectObject: align_list
  file$ = Get string: textgrid
  speaker$ = file$ - "-palign-corrected.TextGrid"
  appendInfoLine: "Processing 'speaker$'"

  align = Read from file: "'stereo$'/'file$'"
  Insert interval tier: 4, "vowels"

  n_sentences = Get number of intervals: 3

  for interval from 1 to n_sentences - 1

    selectObject: align
    interval$ = Get label of interval: 3, interval

    if interval$ == "speech"
      interval_start = Get start time of interval: 3, interval
      word_int = Get interval at time: 2, interval_start
      word_label$ = Get label of interval: 2, word_int

      if word_label$ == "ha"
        target_start = Get start time of interval: 2, word_int + 2
        segment_int = Get interval at time: 1, target_start
      else
        target_start = Get start time of interval: 2, word_int + 1
        segment_int = Get interval at time: 1, target_start
      endif

      # Get start and end time of target vowel
      target_seg$ = Get label of interval: 1, segment_int + 1
      target_seg_start = Get start time of interval: 1, segment_int + 1
      target_seg_end = Get end time of interval: 1, segment_int + 1
      # Create new interval with vowel
      Insert boundary: 4, target_seg_start
      Insert boundary: 4, target_seg_end
      new_int = Get interval at time: 4, target_seg_start
      Set interval text: 4, new_int, target_seg$
    endif
  endfor

  selectObject: align
  Save as text file: "'stereo$'/formants-tg/'speaker$'.TextGrid"
endfor
