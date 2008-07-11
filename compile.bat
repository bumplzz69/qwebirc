rem @echo off
mkdir compiled
del /q compiled\*.js

cd js
copy version.js + jslib.js + irc\ircconnection.js + irc\irclib.js + irc\baseircclient.js + irc\irctracker.js + irc\commandparser.js + irc\ircclient.js + ui\baseui.js + ui\baseuiwindow.js + ui\colour.js + ui\theme.js + qwebircinterface.js ..\compiled\qwebirc-concat.js /b
copy ui\swmlayout.js + ui\swmui.js ..\compiled\swmui-concat.js /b
cd ..\compiled

java -jar ..\bin\yuicompressor-2.3.5.jar qwebirc-concat.js > qwebirc-compiled.js
if not %errorlevel% == 0 goto error

java -jar ..\bin\yuicompressor-2.3.5.jar ..\js\ui\uglyui.js > uglyui-compiled.js
if not %errorlevel% == 0 goto error

java -jar ..\bin\yuicompressor-2.3.5.jar swmui-concat.js > swmui-compiled.js
if not %errorlevel% == 0 goto error
goto ok

:error
cd ..
del /q compiled\*-compiled.js
pause
goto end

:ok
cd ..
copy js\copyright.js + compiled\qwebirc-compiled.js /b static\js\qwebirc.js
copy js\copyright.js + compiled\uglyui-compiled.js /b static\js\uglyui.js
copy js\copyright.js + compiled\swmui-compiled.js /b static\js\swmui.js
del /q compiled\*.js
rmdir compiled

goto end

:end