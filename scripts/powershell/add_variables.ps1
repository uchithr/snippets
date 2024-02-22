# Add user variable
$envName = "<Variable_Name>"
$envValue = "<Variable_Value>"
$userScope = [EnvironmentVariableTarget]::User
[Environment]::SetEnvironmentVariable($envName, $envValue, $userScope)

# Add system variable
$envName = "<Variable_Name>"
$envValue = "<Variable_Value>"
$systemScope = [EnvironmentVariableTarget]::Machine
[Environment]::SetEnvironmentVariable($envName, $envValue, $systemScope)


###############

# Append directory to User environment variable
$envName = "<Variable_Name>"
$dir = "<Directory_Path>"
$userScope = [EnvironmentVariableTarget]::User
$existingValue = [Environment]::GetEnvironmentVariable($envName, $userScope)
$newValue = "$existingValue;$dir"
[Environment]::SetEnvironmentVariable($envName, $newValue, $userScope)

# Append directory to System environment variable
$envName = "<Variable_Name>"
$dir = "<Directory_Path>"
$systemScope = [EnvironmentVariableTarget]::Machine
$existingValue = [Environment]::GetEnvironmentVariable($envName, $systemScope)
$newValue = "$existingValue;$dir"
[Environment]::SetEnvironmentVariable($envName, $newValue, $systemScope)
