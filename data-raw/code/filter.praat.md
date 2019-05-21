# Pre-process data for force-alignment

```praat filter.praat
raw$ = "../data/raw/audio"
derived$ = "../data/derived"
Create Strings as file list: "file_list", "'raw$'/*.wav"
files = Get number of strings

<<<file loop>>>
```

The files in `raw/` are read and processed for alignment.

```praat "file loop"
for file from 1 to files
    select Strings file_list
    file$ = Get string: file
    sound = Read from file: "'raw$'/'file$'"
    file_name$ = selected$("Sound")

    # The EGG output signal is inverted
    Multiply: -1

    # Filter audio
    audio = Extract one channel: 1

    audio_f = Filter (pass Hann band): 40, 10000, 100

    Save as WAV file: "'derived$'/audio/'file_name$'.wav"

    removeObject: audio, audio_f

    # Filter EGG
    selectObject: sound

    egg = Extract one channel: 2

    egg_f = Filter (pass Hann band): 40, 10000, 100

    Save as WAV file: "'derived$'/egg/'file_name$'_egg.wav"

    removeObject: egg, egg_f
endfor
```

For each file, read the file, extract the left channel (audio), filter within range 40-10000 Hz, save the file in `derived/`.
