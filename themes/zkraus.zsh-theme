# vim: set ft=sh:


SEGMENT_SEPARATOR=$'\ue0b0'
PL_BRANCH_CHAR=$'\ue0a0'
UNI_BLACK_RIGHT_TRIANGLE=$'\U25b6'
UNI_BLACK_RIGHT_TRIANGLE_ISO=$'\U1f782'
UNI_WHITE_RIGHT_TRIANGLE=$'\U25B7'
UNI_DOTTED_RIGHT_ARROW=$'\U21E2'
UNI_SINGLE_RIGHT_QUOTATION_MARK=$'\U203A'
UNI_CW_ROTATION_ARROW=$'\U21BB'



UNI_SNAKE=$'\U1F40D'
UNI_RECYCLING=$'\u267B'
UNI_STOPWATCH=$'\U23F1'
#UNI_STOPWATCH="x"



ZSH_THEME_SHELL_SYMBOL="%{$fg_bold[blue]%}$UNI_DOTTED_RIGHT_ARROW %{$reset_color%}"
#ZSH_THEME_SHELL_SYMBOL="%{$fg_bold[blue]%}%% %{$reset_color%}"
ZSH_THEME_SHELL_SYMBOL_ROOT=" %{$fg_bold[red]%}#%{$reset_color%} "
ZSH_THEME_USER_COLOR="%{$fg_bold[green]%}"
ZSH_THEME_USER_ROOT_COLOR="%{$fg_bold[red]%}"




ZSH_THEME_GIT_PROMPT_PREFIX="$PL_BRANCH_CHAR"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_STATUS_PREFIX="("
ZSH_THEME_GIT_PROMPT_STATUS_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_STAGE="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_WORKT="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[green]%}+"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[red]%}-"



ZSH_THEME_PYTHON_VENV="%{${fg[white]}%}"
ZSH_THEME_PYTHON_VENV_VERSION_ENABLE=true
ZSH_THEME_PYTHON_VENV_VERSION=""
ZSH_THEME_PYTHON_VENV_VERSION_SEPARATOR="%{$fg_bold[white]%}$UNI_SNAKE"
ZSH_THEME_PYTHON_VENV_PREFIX="("
ZSH_THEME_PYTHON_VENV_SUFFIX=")"
VIRTUAL_ENV_DISABLE_PROMPT=true

ZSH_THEME_OS="%{${fg[white]}%}"
ZSH_THEME_OS_LABEL="%{${fg[green]}%}"
ZSH_THEME_OS_SEPARATOR=""
ZSH_THEME_OS_PREFIX="["
ZSH_THEME_OS_SUFFIX="]"

ZSH_THEME_ECODE_PASS="%{$fg_bold[green]%}"
ZSH_THEME_ECODE_FAIL="%{$fg_bold[red]%}"
ZSH_THEME_ECODE_PIPE_PREFIX="["
ZSH_THEME_ECODE_PIPE_SUFFIX="]"
ZSH_THEME_ECODE_PIPE_SEPARATOR=","

ZSH_THEME_JOBS_ALL="false"
ZSH_THEME_JOBS_PREFIX=" $UNI_CW_ROTATION_ARROW"
ZSH_THEME_JOBS_SUFFIX=""
ZSH_THEME_JOBS_RUNNING="%{$fg_bold[default]%}"
ZSH_THEME_JOBS_STOPPED="%{$fg_bold[grey]%}/"

ZSH_TIMER_TRESHOLD=10
ZSH_TIMER_PREFIX="$UNI_STOPWATCH"
ZSH_TIMER_SECONDS_PREFIX="%{$fg[gray]%}"
ZSH_TIMER_MINUTES_TRESHOLD=300
ZSH_TIMER_MINUTES_PREFIX="%{$fg[yellow]%}"
ZSH_TIMER_HOURS_TRESHOLD=3600
ZSH_TIMER_HOURS_PREFIX="%{$fg[red]%}"


###############################################################################
### Basics


# ZSH_THEME_SHELL_SYMBOL="%{$fg_bold[blue]%} % %{$reset_color%}"
# ZSH_THEME_SHELL_SYMBOL_ROOT=" %{$fg_bold[red]%}#{$reset_color%} "
# ZSH_THEME_USER_COLOR="%{$fg_bold[green]%}"
# ZSH_THEME_USER_ROOT_COLOR="%{$fg_bold[red]%}"

local user='$ZSH_THEME_USER_COLOR%m%{$reset_color%} '
local shell_promt="$ZSH_THEME_SHELL_SYMBOL"
if [[ $USER == root ]]; then
    user='$ZSH_THEME_USER_ROOT_COLOR%m%{$reset_color%} '
    shell_promt="$ZSH_THEME_SHELL_SYMBOL_ROOT"
fi


local pwd='%{$fg_bold[blue]%}%~%{$reset_color%}'
local return_code='%(?.%{$fg_bold[green]%}.%{$fg[red]%})$?%{$reset_color%}'
local git_branch='$(git_prompt_info)%{$reset_color%}$(git_prompt_status)%{$reset_color%} '


###############################################################################
### processes section

# ZSH_THEME_ECODE_PASS="%{$fg_bold[green]%}"
# ZSH_THEME_ECODE_FAIL="%{$fg_bold[red]%}"
# ZSH_THEME_ECODE_PIPE_PREFIX="["
# ZSH_THEME_ECODE_PIPE_SUFFIX="]"
# ZSH_THEME_ECODE_PIPE_SEPARATOR=","

function parse_ecode { #1: "ecode pipestatus[@]"
  local int_result=""
  local pstat=( $@ )
  for xcode in ${pstat[@]}; do
    if [[ $xcode == 0 ]]; then
      int_result+="$ZSH_THEME_ECODE_PASS"
    else
      int_result+="$ZSH_THEME_ECODE_FAIL"
    fi
    int_result+="${xcode}%{$reset_color%}$ZSH_THEME_ECODE_PIPE_SEPARATOR"
  done
  int_result=${int_result%%,}
  if (( ${#pstat[@]} > 1 )); then
    int_result="$ZSH_THEME_ECODE_PIPE_PREFIX${int_result}$ZSH_THEME_ECODE_PIPE_SUFFIX"
  fi
  echo "${int_result}"
}

function get_ecode {
  echo "$(parse_ecode $?)"
}

function get_ecode_pipe {
  echo "$(parse_ecode ${pipestatus[@]})"
}


# ZSH_THEME_JOBS_ALL="false"
# ZSH_THEME_JOBS_PREFIX=" $UNI_RECYCLING"
# ZSH_THEME_JOBS_SUFFIX=""
# ZSH_THEME_JOBS_RUNNING="%{$fg_bold[default]%}"
# ZSH_THEME_JOBS_STOPPED="%{$fg_bold[grey]%}/"


function get_jobs {
#all
    local jobs_all="$(jobs | wc -l)"
    jobs_all="${jobs_all// }"
#running
    local jobs_running="$(jobs -r | wc -l)"
    jobs_running="${jobs_running// }"
#stopped
    local jobs_stopped="$(jobs -s | wc -l)"
    jobs_stopped="${jobs_stopped// }"
#IDs?
    local result=""

    # no jobs skipping
    if [[ $jobs_all == 0 ]]; then
        return
    fi

    result+="$ZSH_THEME_JOBS_PREFIX"
    if [[ $ZSH_THEME_JOBS_RUNNING != false ]]; then
        result+="$ZSH_THEME_JOBS_RUNNING$jobs_running"
    fi
    if [[ $ZSH_THEME_JOBS_STOPPED != false ]]; then
        result+="$ZSH_THEME_JOBS_STOPPED$jobs_stopped"
    fi
    if [[ $ZSH_THEME_JOBS_ALL != false ]]; then
        result+="$ZSH_THEME_JOBS_ALL$jobs_stopped"
    fi

    result+="$ZSH_THEME_JOBS_SUFFIX%{$reset_color%}"

    echo "${result}"
}


###############################################################################
### python section

# ZSH_THEME_PYTHON_VENV="%{${fg[white]}%}"
# ZSH_THEME_PYTHON_VENV_VERSION_ENABLE=true
# ZSH_THEME_PYTHON_VENV_VERSION="py"
# ZSH_THEME_PYTHON_VENV_VERSION_SEPARATOR="%{$fg_bold[white]%}@"
# ZSH_THEME_PYTHON_VENV_PREFIX="("
# ZSH_THEME_PYTHON_VENV_SUFFIX=")"
# VIRTUAL_ENV_DISABLE_PROMPT=true

function get_python_venv {
    local ps_python_virtualenv=""
    local python_version="$(python -V 2>&1)"
    python_version="${python_version#Python }"
    if [[ -n $VIRTUAL_ENV ]]; then
        ps_python_virtualenv="$ZSH_THEME_PYTHON_VENV"
        ps_python_virtualenv+="$ZSH_THEME_PYTHON_VENV_PREFIX$(basename "$VIRTUAL_ENV")"
            ps_python_virtualenv+="%{$reset_color%}"
        if [[ $ZSH_THEME_PYTHON_VENV_VERSION_ENABLE == true ]]; then
            ps_python_virtualenv+="$ZSH_THEME_PYTHON_VENV_VERSION_SEPARATOR"
            ps_python_virtualenv+="$ZSH_THEME_PYTHON_VENV_VERSION$python_version"
            ps_python_virtualenv+="%{$reset_color%}"
        fi
        ps_python_virtualenv+="$ZSH_THEME_PYTHON_VENV"
        ps_python_virtualenv+="$ZSH_THEME_PYTHON_VENV_SUFFIX%{$reset_color%}"
    fi
    echo "${ps_python_virtualenv}"
}

###############################################################################
### opentack

# ZSH_THEME_OS="%{${fg[white]}%}"
# ZSH_THEME_OS_LABEL="%{${fg[green]}%}"
# ZSH_THEME_OS_SEPARATOR=""
# ZSH_THEME_OS_PREFIX="["
# ZSH_THEME_OS_SUFFIX="]"

function get_openstack {
    local ps_os=""
    if [[ -n $OS_PS1_LABEL ]]; then
        ps_os="$ZSH_THEME_OS"
        ps_os+="$ZSH_THEME_OS_PREFIX"
        if [[ -n $ZSH_THEME_OS_SEPARATOR ]]; then
            ps_os+="$ZSH_THEME_OS_SEPARATOR"
            ps_os+="%{$reset_color%}"
        fi
        ps_os+="$ZSH_THEME_OS_LABEL${OS_PS1_LABEL}"
        ps_os+="%{$reset_color%}"
        ps_os+="$ZSH_THEME_OS$ZSH_THEME_OS_SUFFIX"
        ps_os+="%{$reset_color%}"
    fi
    echo "${ps_os}"
}


###############################################################################
### GIT section
# ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}"
# ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_DIRTY=""
# ZSH_THEME_GIT_PROMPT_CLEAN=""
# ZSH_THEME_GIT_PROMPT_STAGE="%{$fg[green]%}"
# ZSH_THEME_GIT_PROMPT_WORKT="%{$fg[red]%}"
# ZSH_THEME_GIT_PROMPT_AHEAD="+%{$fg[green]%}"
# ZSH_THEME_GIT_PROMPT_BEHIND="-%{$fg[red]%}"

function parse_git_state {
  # check if there is an git repo
  git rev-parse --git-dir &>/dev/null || return

  # BRANCH NAME
  local __git_branch__=$(git branch 2>/dev/null | grep -F '*')
  __git_branch__=${__git_branch__:2} ## star cut

  local __git_status__=";$(git status --porcelain 2>/dev/null | tr '\n' ';')"
  local __git_workt__=""
  local __git_stage__=""
  local int_result=""

  if [[ -n ${__git_status__} ]]; then
    ## WORKING TREE
    [[ ${__git_status__} =~ '\;.M' ]] && __git_workt__+="M"
    [[ ${__git_status__} =~ '\;.A' ]] && __git_workt__+="A"
    [[ ${__git_status__} =~ '\;.D' ]] && __git_workt__+="D"
    [[ ${__git_status__} =~ '\;.R' ]] && __git_workt__+="R"
    [[ ${__git_status__} =~ '\;.C' ]] && __git_workt__+="C"
    [[ ${__git_status__} =~ '\;.U' ]] && __git_workt__+="U"

    [[ ${__git_status__} =~ '\;.\?' ]] && __git_workt__+="?"
    [[ ${__git_status__} =~ '\;.!' ]] && __git_workt__+="!"

    ## STAGE
    [[ ${__git_status__} =~ '\;M' ]] && __git_stage__+="M"
    [[ ${__git_status__} =~ '\;A' ]] && __git_stage__+="A"
    [[ ${__git_status__} =~ '\;D' ]] && __git_stage__+="D"
    [[ ${__git_status__} =~ '\;R' ]] && __git_stage__+="R"
    [[ ${__git_status__} =~ '\;C' ]] && __git_stage__+="C"
    [[ ${__git_status__} =~ '\;U' ]] && __git_stage__+="U"
  fi

  if [[ -n ${__git_branch__} ]]; then
    int_result+="$ZSH_THEME_GIT_PROMPT_PREFIX${__git_branch__}"
  fi
  #git flags
  if [[ -n ${__git_workt__}${__git_stage__} ]]; then
    int_result+="$ZSH_THEME_GIT_PROMPT_STATUS_PREFIX"
  fi
  if [[ -n ${__git_stage__} ]]; then
    int_result+="$ZSH_THEME_GIT_PROMPT_STAGE${__git_stage__}%{$reset_color%}"
  fi
  if [[ -n ${__git_workt__} ]]; then
    int_result+="$ZSH_THEME_GIT_PROMPT_WORKT${__git_workt__}%{$reset_color%}"
  fi
  if [[ -n ${__git_workt__}${__git_stage__} ]]; then
    int_result+="$ZSH_THEME_GIT_PROMPT_STATUS_SUFFIX"
  fi

  local ahead=$(git rev-list --count @{upstream}..HEAD 2>/dev/null)
  local behind=$(git rev-list --count HEAD..@{upstream} 2>/dev/null)
  if [[ ${?} == 0 && -n ${ahead} ]]; then
    if [[ ${ahead} != 0 ]]; then
      int_result+="$ZSH_THEME_GIT_PROMPT_AHEAD${ahead}%{$reset_color%}"
    fi
    if [[ ${behind} != 0 ]]; then
      int_result+="$ZSH_THEME_GIT_PROMPT_BEHIND${behind}%{$reset_color%}"
    fi
  fi
  int_result+="$ZSH_THEME_GIT_PROMPT_SUFFIX"

  echo "${int_result}"
}


###############################################################################
### timer section

# ZSH_TIMER_TRESHOLD=60
# ZSH_TIMER_PREFIX="$UNI_STOPWATCH"
# ZSH_TIMER_SECONDS_PREFIX="%{$fg[gray]%}"
# ZSH_TIMER_MINUTES_TRESHOLD=300
# ZSH_TIMER_MINUTES_PREFIX="%{$fg[yellow]%}"
# ZSH_TIMER_HOURS_TRESHOLD=3600
# ZSH_TIMER_HOURS_PREFIX="%{$fg[red]%}"


timer_start () {
    export timer=${timer:-$SECONDS}
    export ZSH_COMMAND_TIME=""
}

timer_stop () {
    [[ -z $timer ]] && return
    timer_show=$(($SECONDS - $timer))
    if (( timer_show > ZSH_TIMER_TRESHOLD)); then
        export ZSH_COMMAND_TIME="$timer_show"
        unset timer
    fi
}

function get_timer {
    local timer_text
    [[ -z $ZSH_COMMAND_TIME ]] && return
    if ((ZSH_COMMAND_TIME < ZSH_TIMER_MINUTES_TRESHOLD)); then
        timer_text="$ZSH_TIMER_SECONDS_PREFIX$(printf '%ds' $((ZSH_COMMAND_TIME)))"
    elif ((ZSH_COMMAND_TIME < ZSH_TIMER_HOURS_TRESHOLD)); then
        timer_text="$ZSH_TIMER_MINUTES_PREFIX$(printf '%dm:%02ds' $((ZSH_COMMAND_TIME%3600/60)) $((ZSH_COMMAND_TIME%60)))"
    else
        timer_text="$ZSH_TIMER_HOURS_PREFIX$(printf '%dh:%02dm' $((ZSH_COMMAND_TIME/3600)) $((ZSH_COMMAND_TIME%3600/60)))"
    fi
    echo "$ZSH_TIMER_PREFIX$timer_text%{$reset_color%}"

}

###############################################################################
### section

# TODO
function get_machine {
    local machine="${crx_none},${!PS_BASE_COLOR_NAME}"

    if [[ -z ${PS_MACHINE_NAME} ]]; then
        machine+="\h"
    else
        machine+="${PS_MACHINE_NAME}"
    fi
    if [[ ${PS_DEFAULT_IP} == true ]]; then
        machine+="|$(get_default_ip)"
    fi
    if [[ ${PS_HOSTNAME} == true ]]; then
        machine+="|\h"
    fi
    echo "${machine}"
}

## precmd
# Executed before each prompt. Note that precommand functions are not
# re-executed simply because the command line is redrawn, as happens,
# for example, when a notification about an exiting job is displayed.
precmd_functions=()

## preexec
# Executed just after a command has been read and is about to be executed.
# If the history mechanism is active (regardless of whether the line was
# discarded from the history buffer), the string that the user typed is
# passed as the first argument, otherwise it is an empty string. The actual
# command that will be executed (including expanded aliases) is passed in
# two different forms: the second argument is a single-line, size-limited
# version of the command (with things like function bodies elided);
# the third argument contains the full text that is being executed.
preexec_functions=()

PROMPT="\$(get_ecode_pipe),${user}${pwd}\$(parse_git_state)${shell_promt}"
#RPROMPT="\$(get_timer)\$(get_openstack)\$(get_python_venv)\$(get_jobs)"
RPROMPT="\$(get_python_venv)"

