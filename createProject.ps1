function createProject() {
  # Check for GitHub token
  if (-not (Test-Path env:githubToken)) {
    $token = Read-Host -Prompt "Github personal access token:"
    Write-Host "Saving token to environment variable"
    [System.Environment]::SetEnvironmentVariable('githubToken', $token, [System.EnvironmentVariableTarget]::User)
  } 


  $headers = @{
    "accept"        = "application/vnd.github.v3+json"
    "Authorization" = "Bearer $env:githubToken"
    "Content-Type"  = "text/plain"
  }
  $projectName = Read-Host 'Project Name: '
  $privateAnswer = Read-Host 'Private Repo? (Y / N)'
  Switch ($privateAnswer) {
    Y {
      Write-Host 'Creating new private repo'; $body = "{
      `n    `"name`":`"$projectName`",
      `n    `"private`":true
      `n}"
    }
    N {
      Write-Host 'Creating new public repo'; $body = "{
      `n    `"name`":`"$projectName`",
      `n    `"private`":false
      `n}"
    }
    Default {
      Write-Host 'Default, creating new private repo'; $body = "{
      `n    `"name`":`"$projectName`",
      `n    `"private`":true
      `n}"
    }
  }

  # Create local project folder
  Set-Location -Path "D:\Git Repos\"
  mkdir $projectName
  Set-Location $projectName

  # create remote Github Repo
  $response = Invoke-RestMethod 'https://api.github.com/user/repos' -Method 'POST' -Headers $headers -Body $body
  $response | ConvertTo-Json

  # create local repo
  Write-Output "# testProject" >> README.md
  git init
  git add README.md
  git commit -m "first commit"
  git remote add origin https://github.com/nikkelly/$projectName
  git push -u origin master

  # open visual studio
  code .
}