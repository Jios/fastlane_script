### Introduction
Bash scripts use Fastlane and Apple (enterprise) account to
create iOS Bundle_ID with push notifications, pem file and upload to git.

```
# Apple enterprise account info
account: appleAccount@email.com
team ID: xxxxxxxxxx
SKU....: 0123456789
output.: output_pem

# git repo
git URL: ssh://git@github.com:Jios/fastlane_script.git
```


### Install ruby v2.3.1 and fastlane
```
# brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# ruby v2.3.1
brew install rbenv ruby-build

## Add rbenv to bash so that it loads every time you open a terminal
echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
source ~/.bash_profile

## Install Ruby
rbenv install 2.3.1
rbenv global 2.3.1
ruby -v

# fastlane
sudo gem install fastlane --verbose
# or without sudo if the above command does NOT work
gem install fastlane --verbose

gem cleanup
```


### Usages
```
# bundle ID: com.company.appname.jenkins
# app name.: AppName

# production
bash enterprise_bundle_ID.sh -b com.company.appname.jenkins -a AppName

# development
bash enterprise_bundle_ID.sh -b com.company.appname.jenkins -a AppName --development
```


### fastlane match Commands

```
## P.S. the '--readonly' option below means read ONLY

# enterprise
MATCH_FORCE_ENTERPRISE="1" fastlane match enterprise --git_url ssh://git@github.com:Jios/fastlane_script.git --readonly

# development
MATCH_FORCE_ENTERPRISE="1" fastlane match development --git_url ssh://git@github.com:Jios/fastlane_script.git --readonly

# bundle ID, e.g. com.company.metal.test
# add the '--app_identifier' option for a specific bundle ID
MATCH_FORCE_ENTERPRISE="1" fastlane match enterprise --git_url ssh://git@github.com:Jios/fastlane_script.git --readonly --app_identifier com.company.metal.test
```
