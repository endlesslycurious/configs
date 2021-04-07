echo --- Choco: List outdated packages ---
choco outdated

echo --- Choco: Installing from manifest ---
choco install Chocolatey.config -y

echo --- Choco: Pinning Python versions ---
choco pin add -n=python
choco pin add -n=python3

echo --- Choco: Upgrading outdated packages ---
choco upgrade all -y

echo --- Choco: Delete temp install files ---
rmdir /Q /S C:\Users\dpbrown\AppData\Local\Temp\chocolatey

echo --- Python: Update PIP ---
python.exe -m pip install --upgrade pip

echo --- Python: Install modules ---
pip install -r python-modules.txt

echo --- Done! ---
