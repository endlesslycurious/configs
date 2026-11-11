# Shared shell theme, pinned to Catppuccin Latte.
# Light = Catppuccin Latte (#EFF1F5), dark = Catppuccin Frappe (#303446).
# The theme is static; change THEME_MODE to "dark" below (and the matching
# theme values in ghostty/config.ghostty, nvim, Zed and herdr/config.toml) to
# switch. Both palettes are kept so switching is a small edit.
#
# Sets:
#   LS_COLORS      fd/ls colours (mid-saturation accents at ~4.8:1 contrast)
#   DELTA_FEATURES Catppuccin delta feature (see delta/catppuccin.gitconfig)
#   BAT_THEME      matching bat syntax theme
#   K9S_SKIN       matching k9s skin
# Also points btop's stable "catppuccin" theme at the current flavour, since
# btop has no built-in light/dark theme switching.

THEME_MODE=light
export THEME_MODE

if [ "$THEME_MODE" = "dark" ]; then
    export LS_COLORS="\
di=38;2;140;170;238:\
ln=38;2;129;200;190:\
ex=38;2;166;209;137:\
pi=38;2;239;159;118:\
so=38;2;244;184;228:\
bd=38;2;234;153;156:\
cd=38;2;234;153;156:\
or=38;2;231;130;132:\
mi=38;2;231;130;132:"
    export DELTA_FEATURES="catppuccin-frappe"
    export BAT_THEME="Catppuccin Frappe"
    export K9S_SKIN="catppuccin-frappe"
else
    export LS_COLORS="\
di=38;2;62;103;186:\
ln=38;2;47;113;140:\
ex=38;2;54;120;40:\
pi=38;2;137;99;46:\
so=38;2;176;59;145:\
bd=38;2;186;62;73:\
cd=38;2;186;62;73:\
or=38;2;184;61;88:\
mi=38;2;184;61;88:"
    export DELTA_FEATURES="catppuccin-latte"
    export BAT_THEME="Catppuccin Latte"
    export K9S_SKIN="catppuccin-latte"
fi

# btop reads a single theme name, so keep a stable symlink for it to follow.
btop_theme_dir="$HOME/.config/btop/themes"
if [ -d "$btop_theme_dir" ]; then
    if [ "$THEME_MODE" = "dark" ]; then
        btop_flavour=frappe
    else
        btop_flavour=latte
    fi
    if [ -f "$btop_theme_dir/catppuccin_${btop_flavour}.theme" ]; then
        ln -sf "$btop_theme_dir/catppuccin_${btop_flavour}.theme" \
            "$btop_theme_dir/catppuccin.theme" 2>/dev/null
    fi
fi
