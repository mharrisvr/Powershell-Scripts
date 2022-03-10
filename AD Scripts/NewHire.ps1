import-module ActiveDirectory

$users = @('user1', 'user2', 'user3')

$password = foreach ($user in $users) {

    Get-ADUser $user -properties * | select name, employeeID, description, passwordlastset

    
} 

$password
