# --
# Copyright (C) 2001-2017 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Support::Database::oracle;
## nofilter(TidyAll::Plugin::OTRS::Perl::LayoutObject)

use strict;
use warnings;

use Kernel::System::XML;
use Kernel::System::Time;

use vars qw(@ISA $VERSION);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    # check needed objects
    #for (qw(ConfigObject LogObject MainObject DBObject EncodeObject LayoutObject)) {
        #$Self->{$_} = $Param{$_} || die "Got no $_!";
    #}

    # create additional objects
	$Self->{DBObject} 		= $Kernel::OM->Get('Kernel::System::DB');
    $Self->{XMLObject}      = $Kernel::OM->Get('Kernel::System::XML');
    $Self->{TimeObject}     = $Kernel::OM->Get('Kernel::System::Time');
    $Self->{LanguageObject} = $Kernel::OM->Get('Kernel::Output::HTML::Layout')->{LanguageObject};
	$Self->{ConfigObject} 	= $Kernel::OM->Get('Kernel::Config');
	$Self->{EncodeObject} 	= $Kernel::OM->Get('Kernel::System::Encode');

    return $Self;
}

sub AdminChecksGet {
    my ( $Self, %Param ) = @_;

    # get names of available checks from sysconfig
    my $Checks = $Self->{ConfigObject}->Get('Support::Database::Oracle');

    # find out which checks should are enabled in sysconfig
    my @EnabledCheckFunctions;
    if ( $Checks && ref $Checks eq 'HASH' ) {

        # get all enabled check function names
        @EnabledCheckFunctions = sort grep { $Checks->{$_} } keys %{$Checks};
    }

    # to store the result
    my @DataArray;

    FUNCTIONNAME:
    for my $FunctionName (@EnabledCheckFunctions) {

        # prepend an underscore
        $FunctionName = '_' . $FunctionName;

        # run function and get check data
        my $Check = $Self->$FunctionName();

        next FUNCTIONNAME if !$Check;

        # attach check data if valid
        push @DataArray, $Check;
    }

    return \@DataArray;
}

sub _OracleHomeCheck {
    my ( $Self, %Param ) = @_;

    my $Data = {};

    # check ORACLE_HOME
    my $Check   = 'Failed';
    my $Message = $Self->{LanguageObject}->Get('No ORACLE_HOME setting found.');
    if ( $ENV{ORACLE_HOME} ) {
        if ( !-e $ENV{ORACLE_HOME} ) {
            $Message = $Self->{LanguageObject}->Get("ORACLE_HOME does not exist.")
                . " ($ENV{ORACLE_HOME}).";
            $Check = 'Failed';
        }
        else {
            $Message = $Self->{LanguageObject}->Get('Your ORACLE_Home configuration is')
                . " $ENV{ORACLE_HOME}.";
            $Check = 'OK';
        }
    }
    $Data = {
        Name        => $Self->{LanguageObject}->Get('ORACLE_HOME'),
        Description => $Self->{LanguageObject}->Get('Check ORACLE_HOME configuration.'),
        Comment     => $Message,
        Check       => $Check,
    };
    return $Data;
}

sub _NLSLangCheck {
    my ( $Self, %Param ) = @_;

    # check NLS_LANG
    my $Check   = 'Failed';
    my $Message = $Self->{LanguageObject}->Get('No NLS_LANG configuration found.');
    if ( $ENV{NLS_LANG} ) {
        if ( $Self->{ConfigObject}->Get('DefaultCharset') =~ /utf(\-8|8)/i ) {
            if ( $ENV{NLS_LANG} !~ /utf(\-8|8)/i ) {
                $Message = "$ENV{NLS_LANG}, "
                    . $Self->{LanguageObject}->Get('need .utf8 in NLS_LANG (e. g. german_germany.utf8).');
                $Check = 'Failed';
            }
            else {
                $Message = $Self->{LanguageObject}->Get('Your NLS_LANG configuration is')
                    . " $ENV{NLS_LANG}.";
                $Check = 'OK';
            }
        }
        else {
            $Message = $Self->{LanguageObject}->Get('Your NLS_LANG configuration is')
                . " $ENV{NLS_LANG}";
            $Check = 'OK';
        }
    }
    my $Data = {
        Name        => 'NLS_LANG',
        Description => $Self->{LanguageObject}->Get("Check NLS_LANG."),
        Comment     => $Message,
        Check       => $Check,
    };
    return $Data;
}

sub _NLSDateFormatCheck {
    my ( $Self, %Param ) = @_;

    # check NLS_DATE_FORMAT
    my $Check   = 'Failed';
    my $Message = $Self->{LanguageObject}->Get('No NLS_DATE_FORMAT setting found.');
    if ( $ENV{NLS_DATE_FORMAT} ) {
        if ( $ENV{NLS_DATE_FORMAT} ne "YYYY-MM-DD HH24:MI:SS" ) {
            $Message = $Self->{LanguageObject}->Get("Need format 'YYYY-MM-DD HH24:MI:SS' for NLS_DATE_FORMAT (not")
                . " $ENV{NLS_DATE_FORMAT}).";
            $Check = 'Failed';
        }
        else {
            $Message = $Self->{LanguageObject}->Get("Your NLS_DATE_FORMAT setting is")
                . " $ENV{NLS_DATE_FORMAT}.";
            $Check = 'OK';
        }
    }
    my $Data = {
        Name        => 'NLS_DATE_FORMAT',
        Description => $Self->{LanguageObject}->Get('Check NLS_DATE_FORMAT.'),
        Comment     => $Message,
        Check       => $Check,
    };
    return $Data;
}

sub _NLSDateFormatSelectCheck {
    my ( $Self, %Param ) = @_;

    # check NLS_DATE_FORMAT
    my $Check   = 'Failed';
    my $Message = $Self->{LanguageObject}->Get('NLS_DATE_FORMAT seems to be wrong');
    my $CreateTime;

    $Self->{DBObject}->Prepare(
        SQL   => "SELECT create_time FROM valid",
        Limit => 1
    );
    while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {
        $CreateTime = $Row[0];
    }

    if ($CreateTime) {
        if ( $CreateTime !~ /^\d\d\d\d-(\d|\d\d)-(\d|\d\d)\s(\d|\d\d):(\d|\d\d):(\d|\d\d)/ ) {
            $Message = "$CreateTime "
                . $Self->{LanguageObject}->Get("is not the right format 'yyyy-mm-dd hh:mm::ss' (please check")
                . " \$ENV{NLS_DATE_FORMAT}).";
            $Check = 'Failed';
        }
        else {
            $Message = $Self->{LanguageObject}->Get('NLS_DATE_Format has the right format')
                . " ($CreateTime).";
            $Check = 'OK';
        }
    }
    my $Data = {
        Name => 'NLS_DATE_SELECT_FORMAT',
        Description =>
            $Self->{LanguageObject}->Get('Check NLS_DATE_FORMAT by using SELECT statement.'),
        Comment => $Message,
        Check   => $Check,
    };
    return $Data;
}

sub _TableCheck {
    my ( $Self, %Param ) = @_;

    my $Data = {};

    # table check
    my $File = $Self->{ConfigObject}->Get('Home') . "/scripts/database/otrs-schema.xml";
    if ( -f $File ) {
        my $Count   = 0;
        my $Check   = 'Failed';
        my $Message = '';
        my $Content = '';
        my $In;
        if ( open( $In, '<', "$File" ) ) {    ## no critic
            while (<$In>) {
                $Content .= $_;
            }
            close($In);
            my @XMLHash = $Self->{XMLObject}->XMLParse2XMLHash( String => $Content );
            for my $Table ( @{ $XMLHash[1]->{database}->[1]->{Table} } ) {
                if ($Table) {
                    $Count++;
                    if (
                        $Self->{DBObject}->Prepare(
                            SQL   => "select * from $Table->{Name}",
                            Limit => 1
                        )
                        )
                    {
                        while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {
                        }
                    }
                    else {
                        $Message .= "$Table->{Name}, ";
                    }
                }
            }
            if ($Message) {
                $Message = $Self->{LanguageObject}->Get("Table don't exists") . ": $Message.";
            }
            else {
                $Check   = 'OK';
                $Message = "$Count " . $Self->{LanguageObject}->Get('tables checked.');
            }
            $Data = {
                Name        => $Self->{LanguageObject}->Get('Table Check'),
                Description => $Self->{LanguageObject}->Get('Check existing framework tables.'),
                Comment     => $Message,
                Check       => $Check,
            };
        }
        else {
            $Data = {
                Name        => $Self->{LanguageObject}->Get('Table Check'),
                Description => $Self->{LanguageObject}->Get('Check existing framework tables.'),
                Comment     => $Self->{LanguageObject}->Get("Can't open file") . " $File: $!",
                Check       => 'Critical',
            };
        }
    }
    else {
        $Data = {
            Name        => $Self->{LanguageObject}->Get('Table Check'),
            Description => $Self->{LanguageObject}->Get('Check existing framework tables.'),
            Comment     => $Self->{LanguageObject}->Get("Can't find file") . " $File!",
            Check       => 'Critical',
        };
    }
    return $Data;
}

sub _CurrentTimestampCheck {
    my ( $Self, %Param ) = @_;
    my $Data   = {};
    my $DbTime = '';

    # Current Timestamp check
    my $Check   = '';
    my $Message = '';
    $Self->{DBObject}->Prepare(
        SQL => "SELECT to_char(current_timestamp,'YYYY-MM-DD HH24:MI:SS') FROM DUAL"
    );
    while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {
        $DbTime = $Row[0];
    }
    my $TimeApplicationServer = $Self->{TimeObject}->SystemTime();
    my $TimeDatabaseServer    = $Self->{TimeObject}->TimeStamp2SystemTime(
        String => $DbTime,
    );

    my $TimeDifference = 0;
    my $Range          = 10;
    $TimeDifference = $TimeApplicationServer - $TimeDatabaseServer;
    if ( ( $TimeDifference >= ( $Range * -1 ) ) && ( $TimeDifference <= $Range ) ) {
        $Check   = 'OK';
        $Message = $Self->{LanguageObject}->Get(
            'There is no difference between application server time and database server time.'
        );
    }
    else {
        $Check   = 'Failed';
        $Message = $Self->{LanguageObject}->Get('There is a material difference (')
            . $TimeDifference
            . $Self->{LanguageObject}->Get(' seconds) between application server (')
            . $TimeApplicationServer . $Self->{LanguageObject}->Get(') and database server (')
            . $TimeDatabaseServer . $Self->{LanguageObject}->Get(') time.');
    }

    $Data = {
        Name        => $Self->{LanguageObject}->Get('Current Timestamp Check'),
        Description => $Self->{LanguageObject}->Get('Check "System Time" vs "Current Timestamp".'),
        Comment     => $Message,
        Check       => $Check,
    };
    return $Data;
}

1;
