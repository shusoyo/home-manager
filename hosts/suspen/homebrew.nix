{ config, lib, ... }:

let
  taps = [
    "homebrew/bundle"
    "homebrew/services"
  ];

  brews = [
    "bitwarden-cli"
  ];

  casks = [
    "appcleaner"
    "wechat"
    "bitwarden"
    "baidunetdisk"
    "telegram-a"

    # Fonts
    "font-fira-code"
    "font-fira-code-nerd-font"
    "font-noto-sans-cjk"
    "font-noto-serif-cjk"

    # Web Browser
    "arc"
    "zen-browser"

    "ghostty"
    "utm"
    "kitty"
    "zed"
    "visual-studio-code"

    "syncthing"
    "mos"
    "raycast"
    "clash-verge-rev"
    "sfm"
  ];
in {
  home.sessionVariables = {
    HOMEBREW_API_DOMAIN      = "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api";
    HOMEBREW_BOTTLE_DOMAIN   = "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles";
    HOMEBREW_BREW_GIT_REMOTE = "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git";
    HOMEBREW_CORE_GIT_REMOTE = "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git";
    HOMEBREW_PIP_INDEX_URL   = "https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple";
  };

  xdg.configFile."Brewfile" = with lib; {
    text =
      (concatMapStrings (tap: "tap \"${tap}\"\n") taps)
        +
      (concatMapStrings (brew: "brew \"${brew}\"\n") brews)
        +
      (concatMapStrings (cask: "cask \"${cask}\"\n") casks);
    onChange = ''
      /usr/local/bin/brew bundle install --file=${config.xdg.configHome}/Brewfile --cleanup --no-upgrade --force --no-lock -v
    '';
  };
}
