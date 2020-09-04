# vim: set ft=sh:


SEGMENT_SEPARATOR=$'\ue0b0'
PL_BRANCH_CHAR=$'\ue0a0'
UNI_BLACK_RIGHT_TRIANGLE=$'\U25b6'
UNI_BLACK_RIGHT_TRIANGLE_ISO=$'\U1f782'
UNI_WHITE_RIGHT_TRIANGLE=$'\U25B7'
UNI_DOTTED_RIGHT_ARROW=$'\U21E2'
UNI_SINGLE_RIGHT_QUOTATION_MARK=$'\U203A'
UNI_CW_ROTATION_ARROW=$'\U21BB'



EMOJI_MAGNET="🧲"
EMOJI_SNAKE="🐍"
EMOJI_ALEMBIC="⚗️ " # contains space, due to spacing error
EMOJI_YARN="🧶"
EMOJI_MUSICAL_SCORE="🎼"
EMOJI_WOLF="🐺"
EMOJI_FOX="🦊"
EMOJI_RACOON="🦝"
EMOJI_BOAR="🐗"
EMOJI_EWE="🐑"
EMOJI_BAT="🦇"
EMOJI_RECYCLING="♻️ " # contains space, due to spacing error
EMOJI_PLAY_BUTTON="▶️ " # contains space, due to spacing error



ZSH_THEME_SHELL_SYMBOL="%{$fg_bold[blue]%}$UNI_DOTTED_RIGHT_ARROW %{$reset_color%}"
#ZSH_THEME_SHELL_SYMBOL="%{$fg_bold[blue]%}%% %{$reset_color%}"
ZSH_THEME_SHELL_SYMBOL_ROOT=" %{$fg_bold[red]%}#{$reset_color%} "
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
ZSH_THEME_PYTHON_VENV_VERSION_SEPARATOR="%{$fg_bold[white]%}$EMOJI_SNAKE"
ZSH_THEME_PYTHON_VENV_PREFIX="("
ZSH_THEME_PYTHON_VENV_SUFFIX=")"
VIRTUAL_ENV_DISABLE_PROMPT=true


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
# ZSH_THEME_JOBS_PREFIX=" $EMOJI_RECYCLING"
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
  local __git_branch__=$(git branch 2>/dev/null | fgrep '*')
  __git_branch__=${__git_branch__:2} ## star cut

  local __git_status__=";$(git status --porcelain 2>/dev/null | tr '\n' ';')"
  local __git_workt__=""
  local __git_stage__=""
  local int_result=""

  if [[ -n ${__git_status__} ]]; then
    ## WORKING TREE
    [[ ${__git_status__} =~ \;.M ]] && __git_workt__+="M"
    [[ ${__git_status__} =~ \;.A ]] && __git_workt__+="A"
    [[ ${__git_status__} =~ \;.D ]] && __git_workt__+="D"
    [[ ${__git_status__} =~ \;.R ]] && __git_workt__+="R"
    [[ ${__git_status__} =~ \;.C ]] && __git_workt__+="C"
    [[ ${__git_status__} =~ \;.U ]] && __git_workt__+="U"

    [[ ${__git_status__} =~ \;.\? ]] && __git_workt__+="?"
    [[ ${__git_status__} =~ \;.! ]] && __git_workt__+="!"

    ## STAGE
    [[ ${__git_status__} =~ \;M ]] && __git_stage__+="M"
    [[ ${__git_status__} =~ \;A ]] && __git_stage__+="A"
    [[ ${__git_status__} =~ \;D ]] && __git_stage__+="D"
    [[ ${__git_status__} =~ \;R ]] && __git_stage__+="R"
    [[ ${__git_status__} =~ \;C ]] && __git_stage__+="C"
    [[ ${__git_status__} =~ \;U ]] && __git_stage__+="U"
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


PROMPT="\$(get_ecode_pipe),${user}${pwd}\$(parse_git_state)${shell_promt}"
RPROMPT="\$(get_python_venv)\$(get_jobs)"

