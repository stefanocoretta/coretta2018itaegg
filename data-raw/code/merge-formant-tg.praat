######################################
# This is a script from the project 'Vowel duration and consonant voicing: An
# articulatory study', Stefano Coretta
######################################
# MIT License
#
# Copyright (c) 2016-2024 Stefano Coretta
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
ftg$ = "'stereo$'/formants-tg"
ftg_list = Create Strings as file list: "ftg_list", "'ftg$'/*.TextGrid"
ftg_n = Get number of strings

align_list = Create Strings as file list: "align_list", "'stereo$'/*-align.TextGrid"
align_n = Get number of strings

out_file$ = "../datasets/formants-ids.csv"
heading$ = "speaker,interval,vowel,ipu"
writeFileLine: out_file$, heading$

for tg from 1 to ftg_n
  selectObject: ftg_list
  current_tg$ = Get string: tg
  speaker$ = current_tg$ - ".TextGrid"

  current_tg = Read from file: "'ftg$'/'current_tg$'"
  align_tg = Read from file: "'stereo$'/'speaker$'-align.TextGrid"

  selectObject: current_tg, align_tg
  merged = Merge

  v_n = Get number of intervals: 4

  for v from 1 to v_n
    v_label$ = Get label of interval: 4, v
    if v_label$ != ""
      v_start = Get start time of interval: 4, v
      ipu = Get interval at time: 5, v_start
      ipu_label$ = Get label of interval: 5, ipu

      new_line$ = "'speaker$','v','v_label$','ipu_label$'"
      appendFileLine: out_file$, new_line$
    endif  
  endfor

endfor