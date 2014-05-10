@ECHO OFF
::========================================
SET GITHUB_ACCOUNT=Nixer
SET WS_DIR=Nixer_Workspace
SET REPO_NAME=Title_Validation_E2E
SET APP_VERSION=1.1
SET MAIN_CLASS=core.Title_Validation_E2E.Selenium
SET ARGS_01=
::========================================

::========================================
::SET GITHUB_ACCOUNT=%1
::SET WS_DIR=%2
::SET REPO_NAME=%3
::SET APP_VERSION=%4
::SET MAIN_CLASS=%5
::SET ARGS_01=%6
::========================================

IF "%JAVA_HOME%" == "" GOTO EXIT_JAVA
ECHO Java installed
IF "%M2%" == "" GOTO EXIT_MVN
ECHO Maven installed
CALL git --version > nul 2>&1
IF NOT %ERRORLEVEL% == 0 GOTO EXIT_GIT
ECHO Git installed

GOTO NEXT

:NEXT
IF NOT EXIST C:\%WS_DIR% GOTO NO_WORKSPACE
IF EXIST C:\%WS_DIR%\%REPO_NAME% RMDIR /S /Q C:\%WS_DIR%\%REPO_NAME%
CD C:\%WS_DIR%
git clone https://github.com/%GITHUB_ACCOUNT%/%REPO_NAME%.git
CD %REPO_NAME%
SLEEP 2
CALL mvn clean site test -Dtest=AllTests -D bversion="1.1"
ECHO.
::ECHO Executing Java programm ...
::CD C:\%WS_DIR%\%REPO_NAME%\target
::java -cp %REPO_NAME%-%APP_VERSION%-jar-with-dependencies.jar %MAIN_CLASS% %ARG_01% >d:\test_results.txt
GOTO END

:EXIT_JAVA
ECHO No Java installed
GOTO END
:EXIT_MVN
ECHO No Maven installed
GOTO END
:EXIT_GIT
ECHO No Git installed
GOTO END
:NO_WORKSPACE
ECHO %WS_DIR% is not exists
GOTO END
:END
::CD\