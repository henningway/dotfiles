#!/bin/zsh

source ~/.zshrc

SESSION="MAIN"

cd ~/code/maddox/services/frontend
nvm use
tmux new-session -d -s $SESSION
tmux splitw -t $SESSION:0 -h
tmux send-keys -t $SESSION:.0 '(cd ~/code/maddox && task down build up seed)' C-m
tmux send-keys -t $SESSION:.1 'nvm use && npm install && npm run dev' C-m
tmux rename-window -t $SESSION:0 'Maddox'
tmux new-window -t $SESSION:1 -n 'Spotify'
tmux send-keys -t $SESSION:'Spotify' 'ncspot' C-m
tmux attach-session -t $SESSION:'Maddox'
