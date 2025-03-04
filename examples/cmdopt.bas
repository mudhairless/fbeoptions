#include once "options.bi"

var myOpts = options.Parser

var vopt = myOpts.addBool( _
    "v", _ ' short option
    "verbose", _ 'long option
    "Sets program to verbose mode." _ ' help text
)

var copt = myOpts.addOption( _
    "c", _ 'short option
    "commit", _ 'long option
    true, _ 'has argument
    , _ ' arg required = false
    , _ ' can repeat = false
    , _ ' repeat seperator (unused)
    "Commits changes.", _ ' help text
    "filespec" _ ' arg help text
)

var dopt = myOpts.addOption( _
    "d", _ 'short option
    "delete",  _ 'long option
    true,  _ 'has argument
    true,  _ ' arg required
    true, _ ' can repeat
    , _ ' repeat seperator (defualt = ;)
    "Deletes temporary files.",  _ ' help text
    "path" _ ' arg help text
) 

var eopt = myOpts.addOption( _
    "e", _ ' short option
    "erase", _ 'long option
    true, _ ' has argument
    true, _ ' arg required
    , _ ' can repeat = false
    , _ ' repeat separator (unused)
    "Erases changes.", _ ' help text
    "path" _ ' arg help text
) 

myOpts.setHelpHeader(!"This is an example program provided with the FBE Options Library.\n" & _
						!"This program does not make any changes to your computer.\n" & _
						!"\nCommand options recognized:")

myOpts.setHelpFooter(!"Copyright (c) 2025 FBE Options Library Team\n")

myOpts.parse(__FB_ARGC__, __FB_ARGV__)

if myOpts.hasError then
	print myOpts.getError()
    print
    myOpts.showHelp()
	end 42
else
	print "No Errors processing commandline, presenting results..."
end if

if myOpts.isSet( vopt ) then
	print "opt v set "
else
	print "opt v not set"
end if

if myOpts.isSet( copt ) then
	print "opt c set: ";
	var x = myOpts.getArg(copt)
	if len(x) > 0 then
		print x
	else
		print "argument not supplied"
	end if
else
	print "opt c not set"
end if

if myOpts.isSet( dopt ) then
	print "opt d set: ";
	print myOpts.getArg( dopt )
else
	print "opt d not set"
end if

if myOpts.isSet( eopt ) then
	print "opt e set: ";
	print myOpts.getArg( eopt )
else
	print "opt e not set"
end if

print "Non options:"
print myOpts.getRemainder()



