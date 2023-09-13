@echo off

rem 根据实际情况修改以下值：AvZ安装目录、源码文件名、子单元数
set "avz_dir=C:\Path\To\AsmVsZombies"
set "source=.\PE-activate.cpp"
set "subunit_num=2"

set "PATH=%avz_dir%\MinGW\bin;%PATH%"

for /L %%N in (1, 1, %subunit_num%) do (
    start "Compilation Task (%%N/%subunit_num%)" "%avz_dir%\MinGW\bin\g++" -g %source% -std=c++1z -I "%avz_dir%\inc" -lavz -lgdi32 -L "%avz_dir%\bin" -shared -DP%%N -o "./bin/libavz_%%N.dll"
)

echo Please wait for all windows to close.
pause