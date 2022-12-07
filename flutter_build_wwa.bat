call flutter clean
call flutter create .
call flutter build web
call flutter build windows
call flutter build apk --split-per-abi
@REM
set current_time=%date:~0,10%-%time:~0,8%
set current_time=%current_time:/=-%
set current_time=%current_time::=-%
set release_dir=.\release\release-%current_time%
@REM
call mkdir %release_dir%
@REM
call move build\app\outputs\apk\release\app-* %release_dir%\
call tar -cvf %release_dir%\windows.tar -C .\build\windows\runner\Release\ .
call tar -cvf %release_dir%\web.tar -C .\build\web\ .