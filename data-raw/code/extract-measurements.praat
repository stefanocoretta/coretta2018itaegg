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
result_file$ = "../data/datasets/measurements.csv"
header$ = "speaker,ipu,stimulus,sentence_ons,sentence_off,word_ons,word_off,v1_ons,c2_ons,v2_ons,voice_ons,voice_off,c1_rel,c2_rel"

writeFileLine: result_file$, header$

align_list = Create Strings as file list: "align_list", "'stereo$'/*-align.TextGrid"
n_files = Get number of strings

writeInfoLine: "'n_files' files found. Start processing.'newline$'"

for textgrid from 1 to n_files

  selectObject: align_list
  file$ = Get string: textgrid
  speaker$ = file$ - "-align.TextGrid"
  appendInfoLine: "Processing 'speaker$'"

  align = Read from file: "'stereo$'/'file$'"

  n_sentences = Get number of intervals: 3

  for interval from 1 to n_sentences - 1

    selectObject: align
    interval$ = Get label of interval: 3, interval

    if interval$ == "sentence"

      sentence_start = Get start time of interval: 3, interval
      sentence_end = Get end time of interval: 3, interval
      sentence_mid = sentence_start + ((sentence_end - sentence_start) / 2)

      ipu_i = Get interval at time: 1, sentence_mid
      ipu_i$ = Get label of interval: 1, ipu_i
      sentence = Get interval at time: 2, sentence_mid
      sentence$ = Get label of interval: 2, sentence
      sentence$ = replace$(sentence$, """", "'", 2)

      pre_word = Get interval at time: 5, sentence_start
      c1 = pre_word + 1
      c1_start = Get start time of interval: 5, c1
      v1_start = Get start time of interval: 5, c1 + 1
      v1_end = Get end time of interval: 5, c1 + 1
      c2_end = Get end time of interval: 5, c1 + 2
      v2_end = Get end time of interval: 5, c1 + 3

      v1_mid = v1_start + ((v1_end - v1_start) / 2)
      voicing = Get interval at time: 6, v1_mid
      voicing$ = Get label of interval: 6, voicing

      if voicing$ == "voicing"
        voice_start = Get start time of interval: 6, voicing
        voice_end = Get end time of interval: 6, voicing

        if voice_start < c1_start or voice_end > c2_end
          voice_start = undefined
          voice_end = undefined
        endif

      else
        voice_start = undefined
        voice_end = undefined
      endif

      c1_rel_i = Get nearest index from time: 7, c1_start
      c1_rel = Get time of point: 7, c1_rel_i

      if c1_rel < c1_start or c1_rel > v1_start
        c1_rel = undefined
      endif

      c2_rel_i = Get nearest index from time: 7, c2_end
      c2_rel = Get time of point: 7, c2_rel_i

      if c2_rel < v1_end or c2_rel > c2_end
        c2_rel = undefined
      endif

      results$ = "'speaker$','ipu_i$','sentence$','sentence_start','sentence_end','c1_start','v2_end','v1_start','v1_end','c2_end','voice_start','voice_end','c1_rel','c2_rel'"

      appendFileLine: result_file$, results$

    elsif interval$ == ""

      sentence_start = Get start time of interval: 3, interval
      sentence_end = Get end time of interval: 3, interval
      sentence_mid = sentence_start + ((sentence_end - sentence_start) / 2)

      ipu_i = Get interval at time: 1, sentence_mid
      ipu_i$ = Get label of interval: 1, ipu_i
      sentence = Get interval at time: 2, sentence_mid
      sentence$ = Get label of interval: 2, sentence
      sentence$ = replace$(sentence$, """", "'", 2)

      results$ = "'speaker$','ipu_i$','sentence$',--undefined--,--undefined--,--undefined--,--undefined--,--undefined--,--undefined--,--undefined--,--undefined--,--undefined--,--undefined--,--undefined--"

      appendFileLine: result_file$, results$

    endif

  endfor

  removeObject: align

endfor

appendInfoLine: "'newline$'Done!"
