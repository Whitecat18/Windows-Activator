((Get-Content '.\gatherosstate.exe') -replace "`0" | Select-String -Pattern "(.....-){4}VMJWR" -AllMatches).Matches | Select-Object -ExpandProperty Value
