@echo off
REM ========================================
REM Script .bat : push automatique Paul Birthday
REM ========================================

REM --- CONFIGURATION ---
SET "GitHubUser=<ton-compte>"
SET "RepoName=paul-birthday-2025"
SET "ProjectPath=%CD%"
SET "LispFile=paul-birthday-ascii-2025.lisp"

REM --- Vérifier que le fichier Lisp existe ---
IF NOT EXIST "%ProjectPath%\%LispFile%" (
    echo Le fichier %LispFile% est introuvable dans %ProjectPath%
    pause
    exit /b
)

REM --- Créer dépôt distant via API GitHub ---
powershell -Command ^
$Body = @{name="%RepoName%"} | ConvertTo-Json; ^
Invoke-RestMethod -Method POST -Uri "https://api.github.com/user/repos" -Body $Body -Headers @{Authorization = "token <ton-token-personnel-GitHub>"; "User-Agent" = "%GitHubUser%"}

REM --- Initialiser Git local ---
git init
git add "%LispFile%"
git commit -m "?? Premier commit: Paul Birthday 2025"
git branch -M main
git remote add origin https://github.com/%GitHubUser%/%RepoName%.git
git push -u origin main

echo Dépôt créé et pushé avec succès : https://github.com/%GitHubUser%/%RepoName%
pause
