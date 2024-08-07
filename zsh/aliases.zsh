alias cdssd="cd /mnt/space/projects"
alias cdcvut="cd ~/Documents/CVUT/current"
alias cdkeil="cd ~/.wine/drive_c/Keil"
alias pinggoogle="ping -O google.com; ping -O 8.8.8.8"
alias tmp="vim ~/tmp/tmp.md"
alias mv="mv -i"
alias lbc="bc -l"
alias xclip="xclip -sel c"
alias cat="bat"
alias nvidia-smi="watch -n .5 nvidia-smi"
function cd() { zoxide "$@"; }

alias libu="./gradlew --no-configuration-cache versionCatalogUpdate --interactive"
alias liba="./gradlew --no-configuration-cache versionCatalogApplyUpdates"
alias wrapperu="./gradlew wrapper --no-configuration-cache --gradle-version"
alias pracuj="history | tail -n 1 | tr -s ' ' | cut -d ' ' -f3- | xargs sudo"

