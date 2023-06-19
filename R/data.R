#' Data on vowel duration, voicing duration, and vowel height in Italian.
#'
#' A dataset with durational measures from 19 speakers of Italian.
#'
#' @docType data
#' @format A tibble with 3268 observations and 31 variables.
#' \describe{
#'   \item{\code{speaker}}{speaker's ID}
#'   \item{\code{ipu}}{IPU index}
#'   \item{\code{stimulus}}{sentence stimulus}
#'   \item{\code{sentence_ons}}{time of sentence onset in seconds}
#'   \item{\code{sentence_off}}{time of sentence offset in seconds}
#'   \item{\code{word_ons}}{time of word onset (= C1 onset) in seconds}
#'   \item{\code{word_off}}{time of word offset (= V2 ofset) in seconds}
#'   \item{\code{v1_ons}}{time of V1 onset (= C1 offset) in seconds}
#'   \item{\code{c2_ons}}{time of C2 onset (= V1 offset) in seconds}
#'   \item{\code{v2_ons}}{time V2 onset (= C2 offset) in seconds}
#'   \item{\code{voice_ons}}{time of voice onset in seconds}
#'   \item{\code{voice_off}}{time of voice onset in seconds}
#'   \item{\code{c1_rel}}{time of C1 release in seconds}
#'   \item{\code{c2_rel}}{time of C2 release in seconds}
#'   \item{\code{stimulus_id}}{index of the stimulus sentence}
#'   \item{\code{sentence}}{frame sentence}
#'   \item{\code{word}}{target word}
#'   \item{\code{c1}}{C1 (\code{p, t, k})}
#'   \item{\code{vowel}}{V1 (\code{i, e, u, ɛ, a})}
#'   \item{\code{c2}}{C2 (\code{p, t, k})}
#'   \item{\code{backness}}{}
#'   \item{\code{height}}{}
#'   \item{\code{c1_place}}{C1 place of articulation}
#'   \item{\code{c2_place}}{C2 place of articulation}
#'   \item{\code{v1_duration}}{duration of V1 in milliseconds}
#'   \item{\code{c2_clos_duration}}{duration of C1 closure in milliseconds}
#'   \item{\code{rel_voff}}{duration of C1 release to V1 offset in milliseconds}
#'   \item{\code{sent_duration}}{sentence duration in seconds}
#'   \item{\code{speech_rate}}{speech rate as number of syllables per second (\code{= 8 / sentece_duration})}
#'   \item{\code{speech_rate_c}}{centered speech rate (\code{= speech_rate - mean(speech_rate)})}
#'   \item{\code{voice_duration}}{duration of the voiced interval of V1 in milliseconds}
#'   \item{\code{vot}}{duration of Voice Onset Time in milliseconds}
#'   \item{\code{voi_clo}}{duration of voicing during C2 closure in milliseconds}
#'   \item{\code{rel_rel}}{duration of C1 release to C2 release}
#' }
"ita_egg"

#' Data on vowel formants and duration in Italian.
#'
#' A dataset with duration and formants measures from 19 speakers of Italian.
#'
#' @docType data
#' @format A tibble with 3053 observations and 38 variables.
"formants"
