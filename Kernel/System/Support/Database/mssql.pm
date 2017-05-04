# --
# Copyright (C) 2001-2017 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Support::Database::mssql;
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
    my $Checks = $Self->{ConfigObject}->Get('Support::Database::MSSQL');

    # find out which checks are enabled in sysconfig
    my @EnabledCheckFunctions;
    if ( $Checks && ref $Checks eq 'HASH' ) {

        # get all enabled check function names
        @EnabledCheckFunctions = grep { $Checks->{$_} } keys %{$Checks};
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

sub _VersionCheck {
    my ( $Self, %Param ) = @_;

    my $Data = {};

    # version check
    my $Check   = 'Failed';
    my $Message = $Self->{LanguageObject}->Get('Could not determine Microsoft SQL Server version.');
    $Self->{DBObject}->Prepare(
        SQL   => 'SELECT @@version',
        Limit => 1,
    );

    while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {
        $Message = $Row[0];
        $Check   = 'OK';
    }

    $Data = {
        Name        => $Self->{LanguageObject}->Get('Version'),
        Description => $Self->{LanguageObject}->Get('Check database version.'),
        Comment     => $Message,
        Check       => $Check,
    };
    return $Data;
}

sub _DatabaseSizeCheck {
    my ( $Self, %Param ) = @_;

    my $Data = {};

    # Database size check
    my $Check   = 'Failed';
    my $Message = $Self->{LanguageObject}->Get('Could not determine database size.');
    $Self->{DBObject}->Prepare(
        SQL   => 'exec sp_spaceused',
        Limit => 1,
    );

    while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {
        $Message =
            $Self->{LanguageObject}->Get('Database')
            . " $Row[0] " . $Self->{LanguageObject}->Get('is') . " $Row[1] "
            . $Self->{LanguageObject}->Get('large, of which')
            . " $Row[2] " . $Self->{LanguageObject}->Get('is available.');
        $Check = 'OK';
    }

    $Data = {
        Name        => $Self->{LanguageObject}->Get('Size'),
        Description => $Self->{LanguageObject}->Get('Check database size.'),
        Comment     => $Message,
        Check       => $Check,
    };
    return $Data;
}

sub _DatabaseHostnameCheck {
    my ( $Self, %Param ) = @_;

    my $Data = {};

    # Database size check
    my $Check   = 'Failed';
    my $Message = $Self->{LanguageObject}->Get('Could not determine database hostname.');

    if ( my $DatabaseHost = $Self->{ConfigObject}->Get('DatabaseHost') ) {
        $Message = $DatabaseHost;
        $Check   = 'OK';
    }

    $Data = {
        Name        => $Self->{LanguageObject}->Get('Hostname'),
        Description => $Self->{LanguageObject}->Get('Check database hostname.'),
        Comment     => $Message,
        Check       => $Check,
    };
    return $Data;
}

sub _TableCheck {
    my ( $Self, %Param ) = @_;

    my $Data = {};

    # table check
    my $File = $Self->{ConfigObject}->Get('Home') . '/scripts/database/otrs-schema.xml';
    if ( -f $File ) {
        my $Count   = 0;
        my $Check   = 'Failed';
        my $Message = '';
        my $Content = '';
        my $In;
        if ( open( $In, '<', $File ) ) {    ## no critic
            while (<$In>) {
                $Content .= $_;
            }
            close($In);
            my @XMLHash = $Self->{XMLObject}->XMLParse2XMLHash( String => $Content );
            for my $Table ( @{ $XMLHash[1]->{database}->[1]->{Table} } ) {
                if ($Table) {
                    if ( $Table->{Name} eq 'system_user' ) {
                        $Table->{Name} = 'system_user2';
                    }
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
                $Message = $Self->{LanguageObject}->Get("Table doesn't exist") . ": $Message";
            }
            else {
                $Check   = 'OK';
                $Message = "$Count " . $Self->{LanguageObject}->Get('tables.');
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
            Check       => 'Failed',
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
    $Self->{DBObject}->Prepare( SQL => "SELECT current_timestamp" );
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
