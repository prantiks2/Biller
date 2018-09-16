for /F "tokens=3 delims=: " %%H in ('sc query Tomcat8 ^| findstr "        STATE"') do (
  if /I "%%H" NEQ "RUNNING" (
   REM Put your code you want to execute here
   REM For example, the following line
   net start Tomcat8
echo "tomcat started"
))
for /F "tokens=3 delims=: " %%H in ('sc query MySQL57 ^| findstr "        STATE"') do (
  if /I "%%H" NEQ "RUNNING" (
   REM Put your code you want to execute here
   REM For example, the following line
   net start MySQL57
echo "mysql started"
))
start "" http://localhost:8080/biller