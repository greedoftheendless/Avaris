{
  programs.tmux = {
    enable = true;
    extraConfig = ''
      unbind C-b
      set -g prefix C-Space
      bind C-Space send-prefix

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      set -sg escape-time 0
      set -g history-limit 50000
      set -g base-index 1
      setw -g base-index 1

      set -g mouse on

      setw -g mode-keys vi

      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send -X copy-selection

      setw -g clock-mode-style 24
    '';
    plugins = [];
  };
}
