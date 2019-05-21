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

stereo$ = "../data/raw/stereo"
audio$ = "../data/raw/audio"
egg$ = "../data/raw/egg"

txt_list = Create Strings as file list: "txt_list", "'stereo$'/*.txt"
n_files = Get number of strings

writeInfoLine: "'n_files' files found. Start processing.'newline$'"

for file from 1 to n_files
  selectObject: txt_list
  file$ = Get string: file
  speaker$ = file$ - ".txt"
  appendInfoLine: "Processing 'speaker$'"

  ipu = Read from file: "'audio$'/'speaker$'.TextGrid"

  palign = Read from file: "'stereo$'/'speaker$'-palign-corrected.TextGrid"
  vuv = Read from file: "'egg$'/'speaker$'-vuv-corrected.TextGrid"

  selectObject: palign
  n_intervals = Get number of intervals: 3
  end_time = Get end time
  
  palign_2 = Create TextGrid: 0, end_time, "sentence word segments", ""
  vuv_2 = Create TextGrid: 0, end_time, "vuv", ""
  
  for sentence from 1 to n_intervals
  
    selectObject: palign
    speech$ = Get label of interval: 3, sentence
  
    if speech$ == "speech"
  
      speech_start = Get start time of interval: 3, sentence
      speech_end = Get end time of interval: 3, sentence
      first_word = Get interval at time: 2, speech_start
      first_word$ = Get label of interval: 2, first_word
  
      if first_word$ == "#"
        first_word = first_word + 1
        appendInfoLine: "'tab$'Misaligned sentence at 'speech_start's"
      endif
  
      if first_word$ == "ha"
        frame_end = Get end time of interval: 2, first_word + 1
      else
        frame_end = Get end time of interval: 2, first_word
      endif
  
      word_start = frame_end
      word = Get interval at time: 2, word_start
      word$ = Get label of interval: 2, word
      word_end = Get end time of interval: 2, word
  
      c1 = Get interval at time: 1, word_start
      c1$ = Get label of interval: 1, c1
  
      if c1$ == "e" or c1$ == "o"
        c1 = c1 + 1
        appendInfoLine: "'tab$'Misaligned word at 'speech_start's"
      endif
  
      c1_end = Get end time of interval: 1, c1
      v1_end = Get end time of interval: 1, c1 + 1
      v1$ = Get label of interval: 1, c1 + 1
      c2_end = Get end time of interval: 1, c1 + 2
      c2$ = Get label of interval: 1, c1 + 2
      v2$ = Get label of interval: 1, c1 + 3
  
      selectObject: palign_2
      Insert boundary: 1, speech_start
      Insert boundary: 1, speech_end
      sentence_2 = Get interval at time: 1, speech_start
      Set interval text: 1, sentence_2, "sentence"
      Set interval text: 1, sentence_2 - 1, "#"
  
      Insert boundary: 2, word_start
      Insert boundary: 2, word_end
      word_2 = Get interval at time: 2, word_start
      Set interval text: 2, word_2, word$
  
      Insert boundary: 3, word_start
      Insert boundary: 3, c1_end
      c1_2 = Get interval at time: 3, word_start
      Set interval text: 3, c1_2, c1$
  
      Insert boundary: 3, v1_end
      v1_2 = Get interval at time: 3, c1_end
      Set interval text: 3, v1_2, v1$
  
      Insert boundary: 3, c2_end
      c2_2 = Get interval at time: 3, v1_end
      Set interval text: 3, c2_2, c2$
  
      Insert boundary: 3, word_end
      v2_2 = Get interval at time: 3, c2_end
      Set interval text: 3, v2_2, v2$
  
      selectObject: vuv
      
      v1_mid = c1_end + ((v1_end - c1_end) / 2)
      
      vuv_i = Get interval at time: 1, v1_mid
      vuv_label$ = Get label of interval: 1, vuv_i
      
      if vuv_label$ == "V"
        voice_start = Get start time of interval: 1, vuv_i
        voice_end = Get end time of interval: 1, vuv_i
      
        selectObject: vuv_2
        Insert boundary: 1, voice_start
        Insert boundary: 1, voice_end
        voice = Get interval at time: 1, voice_start
        Set interval text: 1, voice, "voicing"
      endif
  
    elsif speech$ == ""
  
      speech_start = Get start time of interval: 3, sentence
      speech_end = Get end time of interval: 3, sentence
  
      selectObject: palign_2
      Insert boundary: 1, speech_start
      Insert boundary: 1, speech_end
      sentence_2 = Get interval at time: 1, speech_start
      Set interval text: 1, sentence_2, ""
      Set interval text: 1, sentence_2 - 1, "#"
  
    endif
  
  endfor

  releases = Read from file: "'audio$'/'speaker$'-rel-corrected.TextGrid"

  selectObject: ipu, palign_2, vuv_2, releases
  merged = Merge
  Save as text file: "'stereo$'/'speaker$'-align.TextGrid"

  removeObject: ipu, palign, palign_2, vuv, vuv_2, releases, merged

endfor

appendInfoLine: "'newline$'Done!"
