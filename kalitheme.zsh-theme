autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%b%F{black}(%F{red}%c%F{black})%b'

setopt PROMPT_SUBST
PROMPT=$'%{$fg[cyan]%}┌──(%{$fg[cyan]%}%{$fg[blue]%}%B%n%b%{$fg[blue]%}%B@%b%{$fg[cyan]%}%{$fg[blue]%}%B%m%b%{$fg[cyan]%})%{$fg[cyan]%}-%{$fg[cyan]%}[%{$fg[white]%}%B%~%b%{$fg[cyan]%}]%{$fg[blue]%}
%{$fg[cyan]%}%B└─%B%{$fg[blue]%}$%{$fg[cyan]%}%B%{$fg[cyan]%}%b '
RPROMPT='$(git_prompt_info)'
PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '

git_prompt_info() {
  local current_dir=$PWD

  while [[ $PWD != '/' ]]; do
    if [[ -d .git && -n $(git rev-parse --is-inside-work-tree 2>/dev/null) ]]; then
      local ref=$(git symbolic-ref HEAD 2>/dev/null) || return
      echo " %{$fg[cyan]%}(%{$fg[blue]%}${ref#refs/heads/}%{$fg[cyan]%})"
      return
    fi
    
    cd ..
  done

  cd "$current_dir"
}
