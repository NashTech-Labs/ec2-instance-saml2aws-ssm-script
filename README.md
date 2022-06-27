# saml2aws

CLI tool which enables you to login and retrieve AWS temporary credentials and use AWS API commands

# Prerequisites
 
- Install [awscli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- Install [saml2aws](https://github.com/Versent/saml2aws)
- Install SSM Plugin (you might need temporary admin access for this)
  - [MacOS](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html#install-plugin-macos)
  - [Windows](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html#install-plugin-windows)
  - [Linux](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html#install-plugin-linux)

# Configuration

- After installing awscli and saml2aws create the file `./saml2aws` in the root directory and fill wiht the following details
```
[default]
name                    = default
app_id                  = 
url                     = <aws organisation login url>
username                = <username>
provider                = ADFS
mfa                     = Auto
skip_verify             = false
timeout                 = 0
aws_urn                 = urn:amazon:webservices
aws_session_duration    = 3600
aws_profile             = saml
resource_id             = 
subdomain               = 
role_arn                = 
region                  = 
http_attempts_count     = 
http_retry_delay        = 
credentials_file        = 
saml_cache              = false
saml_cache_file         = 
target_url              = 
disable_remember_device = false
disable_sessions        = false
prompter                = 

``` 
- Set up default region either by running `aws configure set region <region> --profile saml` or add in `~/.aws/config` file.
```
[profile saml]
region = us-east-1
```
- Enter `saml2aws login --force` and enter your email and password to get temporary credentials

# Using Different Profiles for Different Accounts

Using AWS credential process we can use profiles for different accounts so we don't have to logout
- To use credential edit `~/.aws/config` to add differnt profiles and use saml2aws as the credential process
```
[profile testing]
region = us-east-1
credential_process = saml2aws login --skip-prompt --quiet --credential-process --role <ROLE> --profile testing

[profile dev]
region = us-east-1
credential_process = saml2aws login --skip-prompt --quiet --credential-process --role <ROLE> --profile dev

[profile staging]
region = us-east-1
credential_process = saml2aws login --skip-prompt --quiet --credential-process --role <ROLE> --profile staging

[profile production]
region = us-east-1
credential_process = saml2aws login --skip-prompt --quiet --credential-process --role <ROLE> --profile prod
```
- the `<ROLE>` would be the PowerAdmin role for each account

> **_NOTE:_** When the saml2aws profile expires the profiles won't work as the cached tokens from previous login are stored in `~/.aws/credentials`, in that case they need to be cleared manually

- To use aws commands prefix with `--profile` to use temporary credentials eg. `aws --profile <profile> ssm start-session --target <instance_id>`

- You can connect to the controller node using the shell script as well: ./connect.sh <hostname>.
Update th shell script as required with the correct instance id and profiles.


