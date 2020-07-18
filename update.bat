echo --- Upgrading installed packages ---
choco upgrade all -y

echo --- Installing from manifest ---
choco install Chocolatey.config -y

echo --- Done! ---
