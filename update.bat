echo --- List outdated packages ---
choco outdated

echo --- Upgrading outdated packages ---
choco upgrade all -y

echo --- Installing from manifest ---
choco install Chocolatey.config -y

echo --- Done! ---
