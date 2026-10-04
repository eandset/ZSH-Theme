
./check-space.sh || exit 1

./ohz-install.sh \
    && ./zsh-plugins-install.sh \
    && ./ohz-theme-install.sh \
    && ./jetbrains-mono-install.sh