# Byg projektet
cd ponyoclicker
dotnet publish -c Release
cd ..

# Skift til gh-pages
git checkout gh-pages

# Kopier filer
xcopy /E /Y ponyoclicker\bin\Release\net9.0\publish\wwwroot\* .

# Ret base href
(Get-Content index.html) -replace '<base href="/" />', '<base href="/ponyoclicker/" />' | Set-Content index.html
(Get-Content 404.html) -replace '<base href="/" />', '<base href="/ponyoclicker/" />' | Set-Content 404.html

# Push
git add -A
git commit -m "Deploy"
git push origin gh-pages

# Tilbage til master
git checkout -f master