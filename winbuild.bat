@IF "%fbc%"=="" (
    @echo Please run SET FBC=fbc32 or your preferred compiler first
    @goto :eof
)
@echo Clearing Old Build Files
@del src\*.o
@del lib\*.a
@del tests\*.exe
@del examples\*.exe

@echo Building Components
%fbc% -c -i inc -w all -g -exx src/option.bas
%fbc% -c -i inc -w all -g -exx src/parser.bas

@echo Building Libraries
%fbc% -lib src/option.o src/parser.o -x lib/libfbeoptions.a

@echo Building Examples
%fbc% -i inc -p lib -w all -g -exx examples/cmdopt.bas

::@echo Running Tests
