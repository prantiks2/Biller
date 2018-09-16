for /F "tokens=3 delims=: " %%H in ('sc query MySQL57 ^| findstr "        STATE"') do (
  if /I "%%H" NEQ "RUNNING" (
   REM Put your code you want to execute here
   REM For example, the following line
   net start MySQL57
echo "mysql started"
))
cd C:\Program Files\MySQL\MySQL Server 5.7\bin
java doscmd