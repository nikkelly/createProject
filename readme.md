# createProject
Create a local project, remote GitHub repository and intial commit with a single command. 

## Installation
Create a [GitHub Personal Access Token](https://docs.github.com/en/enterprise/2.15/user/articles/creating-a-personal-access-token-for-the-command-line) 

`git clone https://github.com/nikkelly/microsoftServicesProfile.git`

Use `notepad $profile` to add this to your PowerShell profile

`Import-module '<path to file>/createProject.ps1' -Force`

*During first run the GitHub token will be saved to a local environment variable `$env:githubToken` as plain text*

## Usage
Type 'createProject' to setup project on local machine, create remote GitHub repo and initial commit

###### Inspired by [Kalle Hallden](https://youtu.be/7Y8Ppin12r4)
