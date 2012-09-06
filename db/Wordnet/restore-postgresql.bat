@echo off
rem bbou@ac-toulouse.fr
rem 17.04.2009 
set DB=wordnet30
set DBTYPE=postgresql
set DBUSER=postgres
set /P PGPASSWORD="Enter %DBUSER% password:"
set MODULES=wn legacy vn xwn bnc sumo

call :dbexists
if not %DBEXISTS%==0 call :createdb
for %%M in (%MODULES%) do call :process %DBTYPE%-%%M-schema.sql schema %DB%
for %%M in (%MODULES%) do call :process %DBTYPE%-%%M-data.sql data %DB%
for %%M in (%MODULES%) do call :process %DBTYPE%-%%M-constraints.sql constraints %DB%
for %%M in (%MODULES%) do call :process %DBTYPE%-%%M-views.sql views %DB%
goto :eof

:process
setlocal
if not exist %1 goto :endprocess
echo %2
psql -h localhost -U %DBUSER% -f %1 %3
:endprocess
endlocal
goto :eof

:dbexists
setlocal
psql -h localhost -U %DBUSER% -c "\q" %DB% > NUL 2> NUL
endlocal & set DBEXISTS=%ERRORLEVEL% 
goto :eof

:deletedb
setlocal
echo delete %DB%
psql -h localhost -U %DBUSER% -c "DROP DATABASE %DB%;" template1
endlocal
goto :eof

:createdb
setlocal
echo create %DB%
psql -h localhost -U %DBUSER% -c "CREATE DATABASE %DB% WITH TEMPLATE = template0 ENCODING = 'UTF8';" template1
endlocal
goto :eof

:eof

