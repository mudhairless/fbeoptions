''Title: options.bi
''
''About: License
''Copyright (c) 2025 Ebben Feagan
''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
''
''Contains code contributed and Copyright (c) 2007, mr_cha0s: ruben.coder@gmail.com
''
''Distributed under the Modified BSD License, see LICENSE for details

# pragma once
#ifndef FB_OPTIONS_BI__
#define FB_OPTIONS_BI__

#ifndef null
const null = cast(any ptr, 0)
#endif

#inclib "fbeoptions"

''Namespace: options
namespace options

type Option
	declare constructor( byref short_opt as string, _
						byref long_opt as string = "", _
						byval has_arg as boolean = false, _
						byval arg_required as boolean = false, _
						byval can_repeat as boolean = false, _
						byref rep_seperator as string = ";", _
						byref help_string as string = "", _ 
                        byref arg_help_string as string = "" _
                        )

	declare constructor( byref cpy as Option )
	declare destructor()

	''Private
	as string m_short_opt, m_long_opt, m_arg, m_rep_seperator, m_help, m_arg_help
	as boolean m_has_arg, m_arg_required, m_processed, m_can_repeat, m_set

end type

type OptionList
	as OptionList ptr NextNode
	as Option ptr d
	declare destructor()
end type

''Class: Parser
''Provides an easy way to process command line arguments.
''Supports short (-c) and long (--command) style arguments with
''optional and required parameters.
''
type Parser

	declare constructor()

	declare function addOption( byref opt as Option ) as integer

	''Function: addBool
	''Adds a boolean option to the parser.
	''
	''Parameters:
	''short_opt - Single letter version of the option, e.g. c for -c
	''long_opt - (optional) long form version of the option, e.g. copy for --copy
	''help_string - (optional) String to print for this command when the -h or --help options are passed.
	''
	''Returns:
	''Integer identifier for this option used in <isSet> and <getArg>
	''
	declare function addBool( byref short_opt as string, _
						byref long_opt as string = "", _
						byref help_string as string = "" ) as integer

	''Function: addOption
	''Adds an option to the parser.
	''
	''Parameters:
	''short_opt - Single letter version of the option, e.g. c for -c
	''long_opt - (optional) long form version of the option, e.g. copy for --copy
	''has_arg - (optional) option has argument, defaults to false, e.g. --copy filename where filename is the argument
	''arg_required - (optional) is the argument required, defaults to false
	''can_repeat - (optional) can the argument repeat, defaults to false, e.g. --copy file1 --copy file2
	''rep_seperator - (optional) if the argument can repeat what should the results be seperated by, defaults to ";"
	''help_string - (optional) String to print for this command when the -h or --help options are passed.
    ''arg_help_string - (optional) String to print for argument, --option <arg_help_string> where the < and > are printed by the system
	''
	''Returns:
	''Integer identifier for this option used in <isSet> and <getArg>
	''
	declare function addOption( byref short_opt as string, _
							byref long_opt as string = "", _
							byval has_arg as boolean = false, _
							byval arg_required as boolean = false, _
							byval can_repeat as boolean = false, _
							byref rep_seperator as string = ";", _
							byref help_string as string = "", _ 
                            byref arg_help_string as string = "" _
                            ) as integer

	''Sub: parse
	''Parses the command line and prepares the results.
	''
	''Usage:
	''(begin code)
	''myOptions.parse( __FB_ARGC__, __FB_ARGV__ )
	''(end code)
	''
	declare sub parse( byval argc as integer, byval argv as zstring ptr ptr )

	''Function: hasError
	''Returns true if there was an error parsing the command line.
	''
	declare function hasError() as boolean

	''Function: getError
	''Returns a string describing the error.
	''
	declare function getError() as string

	''Sub: setHelpHeader
	''Sets the text to show before the options list when <showHelp> is called.
	''When printing the help this message is displayed first, then a blank line and then the options.
	declare sub setHelpHeader( byref s as string )

	''Sub: setHelpFooter
	''Sets the text to show after the options list when <showHelp> is called.
	''When printing the help this message is displayed after the options preceded by a blank line.
	declare sub setHelpFooter( byref s as string )

	''Sub: showHelp
	''Shows the built-in help for all known options. Called automatically
	''by <parse> if -h or --help is passed.
	declare sub showHelp()

	''Function: isSet
	''Was the option passed on the command line?
	''
	''Parameters:
	''index - Identifier returned from <addOption> for an option.
	''
	''Returns:
	''True if the option was passed on the command line.
	''
	declare function isSet( byval index as integer ) as boolean

	''Function: getArg
	''
	''Parameters:
	''index - Identifier returned from <addOption> for an option.
	''
	''Returns:
	''String containing the argument passed to this option optionally seperated by the seperator if there is more than one result.
	''
	declare function getArg( byval index as integer ) as string

	''Function: getRemainder
	''
	''Returns:
	''All unparsed content from the command line.
	''
	declare function getRemainder() as string

	declare destructor()

	private:
	declare sub addnode( byval x as Option ptr )
	as string m_error
	as string m_remainder
	as string h_head, h_foot
	as OptionList ptr m_opt
	as integer last_index

	end type

end namespace

#endif
