# Class: joindomain
#
# This module manages joindomain
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class joindomain (
  $domain    =  undef,
  $username  =  undef,
  $password  =  undef,
  #$oupath    =  undef,

  ) {
 
  # Validate variables
  validate_string($domain)
  validate_string($username)
 
  # Create powershell credential username
  exec { 'Create username':
    command  => "$pscredential_username = $domain\$username",
    provider => powershell,
  }   
  # Convert password to powershell secure string
  exec { 'Convert Password':
    command  => "$pscredential_password = ConvertTo-SecureString -String $password -AsPlainText -Force",
    provider => powershell,
  }
  # Create powershell credential object
  exec { 'Create powershell credential object:'
    command  => "$pscredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $pscredential_username, $pscredential_password",
    provider => powershell,
  }
  # Join the specified domain  
  exec { 'Join Domain':
    command  => "Add-Computer -domainname $domain -credential $pscredential",
    provider => powershell,

  }
  # Reboot the machine after the domain join operation
  reboot { 'Post Join Reboot':
    subscribe =>  Exec['Join Domain'],
  }
}