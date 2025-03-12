Param(
[bool]$SetProxy
)

if ($SetProxy) {
  [System.Environment]::SetEnvironmentVariable('HTTP_PROXY','http://proxy.cat.com:80','User')
  [System.Environment]::SetEnvironmentVariable('HTTPS_PROXY','http://proxy.cat.com:80','User')

} else {
  [System.Environment]::SetEnvironmentVariable('HTTP_PROXY','','User')
  [System.Environment]::SetEnvironmentVariable('HTTPS_PROXY','','User')

}
