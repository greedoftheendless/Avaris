{
  programs.cava = {
    enable = true;
  };

  xdg.configFile."cava/config".text = ''
    [general]
    framerate = 60
    autosens = 1
    sensitivity = 100
    bars = 0
    bar_width = 2
    bar_spacing = 1
    lower_cutoff_freq = 50
    higher_cutoff_freq = 10000
    sleep_timer = 0

    [input]
    method = pipewire
    source = auto

    [output]
    method = noncurses
    orientation = bottom
    channels = stereo
    mono_option = average
    reverse = 0
    xaxis = none
    show_idle_bar_heads = 1
    waveform = 0

    [color]
    background = default
    foreground = default

    gradient = 1
    gradient_count = 2
    gradient_color_1 = '#625a70'
    gradient_color_2 = '#9b8db3'
    gradient_color_3 = '#414E58'
    gradient_color_4 = '#617180'
    gradient_color_5 = '#B8C3CC'
    gradient_color_6 = '#5A6B79'
    gradient_color_7 = '#8197AB'
    gradient_color_8 = '#B8C3CC'

    [smoothing]
    noise_reduction = 77
  '';

  xdg.configFile."cava/shaders".source = ./shaders;
  xdg.configFile."cava/themes".source = ./themes;
}
