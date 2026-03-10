# Gem deploy.ps1 i master først
git add deploy.ps1
git add ponyoclicker/wwwroot/css/ponyostyle.css
git add ponyoclicker/Pages/Home.razor
git commit -m "Opdater kode og deploy script"
git push origin master

# Byg projektet
cd ponyoclicker
dotnet publish -c Release
cd ..

# Skift til gh-pages
git checkout -f gh-pages

# Kopier filer
xcopy /E /Y ponyoclicker\bin\Release\net9.0\publish\wwwroot\* .

# Opret 404.html hvis den ikke findes
if (-not (Test-Path "404.html")) {
    Copy-Item index.html 404.html
}

# Ret base href i begge filer
(Get-Content index.html) -replace '<base href="/" />', '<base href="/ponyoclicker/" />' | Set-Content index.html
(Get-Content 404.html) -replace '<base href="/" />', '<base href="/ponyoclicker/" />' | Set-Content 404.html

# Push
git add _framework css images index.html 404.html ponyoclicker.styles.css
git commit -m "Deploy"
git push origin gh-pages

# Tilbage til master
git checkout -f master