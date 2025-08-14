#!/bin/zsh

source ~/.zshrc

SESSION="MAIN"

cd ~/code/maddox/services/frontend
nvm use
tmux new-session -d -s $SESSION
tmux rename-window -t $SESSION:0 'Maddox'
tmux splitw -t $SESSION:'Maddox' -h
tmux send-keys -t $SESSION:'Maddox'.0 'cd ~/code/maddox && clear' C-m
tmux send-keys -t $SESSION:'Maddox'.1 'nvm use && npm install && npm run dev' C-m
tmux new-window -t $SESSIONS:1 -n 'FOX'
tmux splitw -t $SESSION:'FOX' -h
tmux send-keys -t $SESSION:'FOX'.0 'cd ~/code/fox && clear' C-m
tmux send-keys -t $SESSION:'FOX'.1 'cd ~/code/fox/frontend && clear' C-m
tmux new-window -t $SESSION:2 -n 'Spotify'
tmux send-keys -t $SESSION:'Spotify' 'ncspot' C-m
tmux attach-session -t $SESSION:'Maddox'
