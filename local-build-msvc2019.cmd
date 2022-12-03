REM run as Administrator
@echo off
cd /d %~dp0
set DOWNLOAD_DIR=%USERPROFILE%\Downloads
set DOWNLOAD_DIR_LINUX=%DOWNLOAD_DIR:\=/%

@REM %DOWNLOAD_DIR%\mingw64-win32; ^
@REM %DOWNLOAD_DIR%\mingw64-win32\bin; ^

SET PATH=^
%DOWNLOAD_DIR%\PortableGit\bin;^
%DOWNLOAD_DIR%\cmake-3.22.2-windows-x86_64\bin;

@REM -Dtensorflow_ROOT="%DOWNLOAD_DIR_LINUX%/libtensorflow-gpu-windows-x86_64-2.6.0" ^
@REM gpu needs CUDA dlls
cmake -G "Visual Studio 16 2019" -A x64 ^
-Dtensorflow_ROOT="%DOWNLOAD_DIR_LINUX%/libtensorflow-cpu-windows-x86_64-2.6.0" ^
-B./build

cd build
cmake --build . --target ALL_BUILD --config Release -- /nologo /verbosity:minimal /maxcpucount

pause

