@echo OFF
@title MultiMesh Scripting
cls

echo.
echo MultiMesh Scripting - Run a MLX Script on a Folder v1.0
echo June 18, 2014 - 2.54pm
echo Script by Andrew Hazelden
echo ----------------------------------------------------------------
echo This bat script will process a series of meshes from the 
echo input folder, run them through a meshlabserver script 
echo and save the resulting meshes to the output folder
echo ----------------------------------------------------------------
echo.

rem Switch to the MultiMesh program's working directory
C:
cd C:\multiMeshScripting

rem Process a single mesh variable
rem If the filename was (granite_boulder.ply) you would write in:
rem (granite_boulder)
rem @set singleMeshNamePrefix=granite_boulder

rem Input Mesh File variables
@set inputFolder=input
rem Note: You can choose a specific mesh format for input or
rem use an asterix (*) for all files in the input meshes folder
rem @set inputMeshFormat=obj
@set inputMeshFormat=ply
rem @set inputMeshFormat=*


rem Output Mesh File variables
@set outputFolder=output
@set outputMeshFormat=obj
rem @set outputMeshFormat=ply
rem Note: If you use the PLY output format it is saved as a BINARY PLY file
rem @set outputMeshFormat=u3d

rem MLX script file variables
rem the MLX scripts are stored in the C:\multiMeshScripting\scripts folder
@set mlxScriptFile=simple_script.mlx
@set mlxScriptFolder=scripts

rem OM Output Mesh Options
rem These options specify what data types are exported by meshlabserver
@set outputMeshOptions=-om vc fq wn
rem The standard om options are "-om vc fq wn" which give vertex colors, face colors, and wedge normals

rem The available OM options are:
rem vc -> vertex colors
rem vf -> vertex flags
rem vq -> vertex quality
rem vn-> vertex normals
rem vt -> vertex texture coords
rem fc -> face colors
rem ff -> face flags
rem fq -> face quality
rem fn-> face normals
rem wc -> wedge colors
rem wn-> wedge normals
rem wt -> wedge texture coords

rem The meshlabserver program location:
@set meshlabserverPath="C:\Program Files\VCG\MeshLab\meshlabserver.exe"


rem ------------------------------------------------------
rem       List the Current Input Mesh Format
rem ------------------------------------------------------
echo ----------------------------------------------------------------
echo.
echo Processing meshes with the format:
echo %inputMeshFormat%
echo.

rem ------------------------------------------------------
rem            List the input Meshes
rem ------------------------------------------------------
echo.
echo ----------------------------------------------------------------
echo.
echo Input Folder Mesh List:
for %%X in (%inputFolder%\*.%inputMeshFormat%) do (echo "%%X")
rem To get help on the "for" syntax use: for /?
echo.

rem ------------------------------------------------------
rem   Do a simple mesh conversion on a single file
rem ------------------------------------------------------

rem Example Syntax: 
rem "C:\Program Files\VCG\MeshLab\meshlabserver.exe" -i input\boulder-mini1.ply -o output\boulder-mini1.ply -om vc fq wn

rem Do a simple mesh conversion
rem %meshlabserverPath% -i %inputFolder%\%singleMeshNamePrefix%.%inputMeshFormat% -o %outputFolder%\%singleMeshNamePrefix%.%outputMeshFormat% %outputMeshOptions%

rem ------------------------------------------------------
rem    Do a simple mesh conversion on a folder
rem ------------------------------------------------------

rem Run the "for" loop from inside the input folder
rem cd %inputFolder%

rem for %%I in (*.%inputMeshFormat%) do (%meshlabserverPath% -i %%I -o ..\%outputFolder%\%%~nI.%outputMeshFormat% %outputMeshOptions%)
rem To get help on the "for" syntax use: for /?

rem Go back down a directory
rem cd ..

rem ------------------------------------------------------
rem Run a meshlabserver MLX script on a single file
rem ------------------------------------------------------

rem Example Syntax: 
rem "C:\Program Files\VCG\MeshLab\meshlabserver.exe" -i input\boulder-mini1.ply -o output\boulder-mini1.ply -s scripts\simple_script.mlx -om vc fq wn

rem %meshlabserverPath% -i %inputFolder%\%singleMeshNamePrefix%.%inputMeshFormat% -o %outputFolder%\%singleMeshNamePrefix%.%outputMeshFormat% -s %mlxScriptFolder%\%mlxScriptFile% %outputMeshOptions%

rem ------------------------------------------------------
rem   Run a meshlabserver MLX script on a folder
rem ------------------------------------------------------
echo.
echo ----------------------------------------------------------------
echo.

rem Example syntax that is used inside the for loop: 
rem "C:\Program Files\VCG\MeshLab\meshlabserver.exe" -i input\boulder-mini1.ply -o output\boulder-mini1.ply -s scripts\simple_script.mlx -om vc fq wn

rem Run the "for" loop from inside the input folder
cd %inputFolder%

for %%I in (*.%inputMeshFormat%) do (%meshlabserverPath% -i %%I -o ..\%outputFolder%\%%~nI.%outputMeshFormat% -s ..\%mlxScriptFolder%\%mlxScriptFile% %outputMeshOptions%)
rem To get help on the "for" syntax use: for /?

rem Go back down a directory
cd ..

rem ------------------------------------------------------
rem            List the Output Meshes
rem ------------------------------------------------------
echo.
echo ----------------------------------------------------------------

echo.
echo Output Folder Mesh List:
for %%X in (%outputFolder%\*.*) do (echo "%%X")
rem To get help on the "for" syntax use: for /?
echo.

rem ------------------------------------------------------
rem            Done Processing
rem ------------------------------------------------------

echo. 
echo Script Complete
echo.
PAUSE
