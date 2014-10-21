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
  #$oupath   =  undef,

  ) {

  # Validate variables
  validate_string($domain)
  validate_string($username)

  # Join Domain
  exec { 'Join Domain':
    command   => "\$pscredential_password = ConvertTo-SecureString -String ${password} -AsPlainText -Force;\$pscred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username@$domain,\$pscredential_password;Add-Computer -domainname $domain -credential \$pscred",
    unless    => "if((Get-WmiObject -Class Win32_ComputerSystem).domain -ne '${domain}'){ exit 1 }",
    provider  => powershell,
  }
  # Reboot the machine after the domain join operation
  reboot { 'Post Join Reboot':
    subscribe =>  Exec['Join Domain'],
  }
}