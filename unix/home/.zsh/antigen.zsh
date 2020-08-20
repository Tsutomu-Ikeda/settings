/bin/rm -f $HOME/.antigen/.zcompdump

# antigen
source ~/.antigen/antigen.zsh

COUNT=0

OMZ=oh-my-zsh
LIST=$(antigen list)
echo $LIST | grep $OMZ > /dev/null; if [ $? -ne 0 ];
then
  antigen use $OMZ
  # Bundle from oh-my-zsh
  antigen bundle git
  antigen bundle docker
  (( COUNT++ ))
fi

BUNDLES=("zsh-users/zsh-syntax-highlighting" "zsh-users/zsh-autosuggestions" "zsh-users/zsh-completions" "zsh-users/zsh-history-substring-search")
for b in $BUNDLES; do echo $LIST | grep $b > /dev/null; if [ $? -ne 0 ]; then antigen bundle $b; (( COUNT++ )); fi; done

THEME=romkatv/powerlevel10k
echo $LIST | grep $THEME > /dev/null; if [ $? -ne 0 ]; then antigen theme $THEME; (( COUNT++ )); fi

if [ $COUNT -gt 0 ]; then antigen apply; fi
