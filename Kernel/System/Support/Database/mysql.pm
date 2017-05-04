# --
# Copyright (C) 2001-2017 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Support::Database::mysql;
## nofilter(TidyAll::Plugin::OTRS::Perl::LayoutObject)

use strict;
use warnings;

use Kernel::System::Time;
use Kernel::System::XML;

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
    my $Checks = $Self->{ConfigObject}->Get('Support::Database::MySQL');

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

sub _VersionCheck {
    my ( $Self, %Param ) = @_;

    # version check
    my $Check   = 'Failed';
    my $Message = $Self->{LanguageObject}->Get('No MySQL version found.');

    my $Version = $Self->{DBObject}->Version();

    if ( $Version =~ /^(MySQL|MariaDB) (\d{1,3})\.(\d{1,3}).*/ ) {
        if ( $2 >= 5 ) {
            $Check   = 'OK';
            $Message = $Version;
        }
        else {
            $Check   = 'Failed';
            $Message = $Self->{LanguageObject}->Get('MySQL version') .
                " $Version, " .
                $Self->{LanguageObject}->Get('you should use 5.0 or higher.');
        }
    }
    else {
        $Check   = 'Critical';
        $Message = $Self->{LanguageObject}->Get('Unknown MySQL version') . " '$Version'.";
    }

    my $Data = {
        Name        => $Self->{LanguageObject}->Get('Database Version.'),
        Description => $Self->{LanguageObject}->Get('Check database version.'),
        Comment     => $Message,
        Check       => $Check,
    };
    return $Data;
}

sub _UTF8ClientCheck {
    my ( $Self, %Param ) = @_;
    my $Data = {};

    my $Check   = 'Failed';
    my $Message = $Self->{LanguageObject}->Get('No character_set_client setting found.');

    # utf-8 client check
    if ( $Self->{ConfigObject}->Get('DefaultCharset') !~ /utf(\-8|8)/i ) {
        return;
    }

    # ask the database
    $Self->{DBObject}->Prepare( SQL => 'show variables' );
    while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {

        #next if row not character_set_client
        next if $Row[0] !~ /^character_set_client/i;

        if ( $Row[1] =~ /utf8/ ) {
            $Check   = 'OK';
            $Message = $Self->{LanguageObject}->Get('Your client connection is') . " $Row[1].";

            next;
        }
        $Message = $Self->{LanguageObject}->Get("Found character_set_client, but it's set to") .
            " $Row[1] (" . $Self->{LanguageObject}->Get('needs to be utf8') . ').';
    }

    $Data = {
        Name => $Self->{LanguageObject}->Get('Client Connection (utf8)'),
        Description =>
            $Self->{LanguageObject}->Get('Check if the client uses utf8 for the connection.'),
        Check   => $Check,
        Comment => $Message,
    };

    return $Data;
}

sub _UTF8DatabaseCheck {
    my ( $Self, %Param ) = @_;

    # utf-8 database check
    if ( $Self->{ConfigObject}->Get('DefaultCharset') !~ /utf(\-8|8)/i ) {
        return;
    }
    my $Check   = 'Failed';
    my $Message = $Self->{LanguageObject}->Get('No character_set_database setting found.');
    $Self->{DBObject}->Prepare( SQL => 'show variables' );
    while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {
        if ( $Row[0] =~ /^character_set_database/i ) {
            $Message = $Self->{LanguageObject}->Get("Character_set_database setting found, but it's set to") .
                " $Row[1] (" . $Self->{LanguageObject}->Get('needs to be utf8') . ').';
            if ( $Row[1] =~ /utf8/ ) {
                $Check   = 'OK';
                $Message = $Self->{LanguageObject}->Get('Your database charset setting is') . " $Row[1]";
            }
        }
    }

    my $Data = {
        Name        => $Self->{LanguageObject}->Get('Database Charset (utf8)'),
        Description => $Self->{LanguageObject}->Get('Check if the database uses utf8 as charset.'),
        Comment     => $Message,
        Check       => $Check,
    };

    return $Data;
}

sub _UTF8TableCheck {
    my ( $Self, %Param ) = @_;
    my $Data = {};

    # utf-8 table check
    if ( $Self->{ConfigObject}->Get('DefaultCharset') =~ /utf(\-8|8)/i ) {
        my $Check    = 'Failed';
        my $Message  = '';
        my $Message2 = '';
        $Self->{DBObject}->Prepare( SQL => 'show table status' );
        while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {
            if ( $Row[14] !~ /^utf8/i ) {
                if ($Message) {
                    $Message .= ', ';
                }
                $Message .= "$Row[0]\[$Row[14]\]";
            }
            else {
                $Message2 = $Row[14];
            }
        }
        if ($Message) {
            $Check   = 'Failed';
            $Message = $Self->{LanguageObject}->Get('Invalid charset collation for') . ": $Message";
        }
        else {
            $Check   = 'OK';
            $Message = $Message2;
        }
        $Data = {
            Name        => $Self->{LanguageObject}->Get('Table Collation (utf8)'),
            Description => $Self->{LanguageObject}->Get('Check the utf8 table charset collation.'),
            Comment     => $Self->{LanguageObject}->Get('Your charset collation is set to')
                . " $Message.",
            Check => $Check,
        };
        return $Data;
    }
    return;
}

sub _MaxAllowedPackageCheck {
    my ( $Self, %Param ) = @_;
    my $Data = {};

    # max_allowed_packet check
    my $Check   = 'Failed';
    my $Message = $Self->{LanguageObject}->Get('No "max_allowed_packet" configuration found.');
    $Self->{DBObject}->Prepare( SQL => 'show variables' );
    while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {
        if ( $Row[0] =~ /^max_allowed_packet/i ) {
            if ( $Row[1] < 1024 * 1024 * 20 ) {
                $Row[1]  = int( $Row[1] / 1024 / 1024 );
                $Check   = 'Failed';
                $Message = '"max_allowed_packet" ' .
                    $Self->{LanguageObject}->Get("should be higher than 20 MB (it's")
                    . " $Row[1] MB).";
            }
            else {
                $Row[1]  = int( $Row[1] / 1024 / 1024 );
                $Check   = 'OK';
                $Message = $Self->{LanguageObject}->Get('Your configuration setting is')
                    . " $Row[1] MB.";
            }
        }
    }
    $Data = {
        Name        => $Self->{LanguageObject}->Get('Max Package Size'),
        Description => $Self->{LanguageObject}->Get('Check "max_allowed_packet" setting.'),
        Comment     => $Message,
        Check       => $Check,
    };
    return $Data;
}

sub _QueryCacheSizeCheck {
    my ( $Self, %Param ) = @_;
    my $Data = {};

    # query_cache_size check
    my $Check   = 'Failed';
    my $Message = $Self->{LanguageObject}->Get('No "query_cache_size" setting found.');
    $Self->{DBObject}->Prepare( SQL => 'show variables' );
    while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {
        if ( $Row[0] =~ /^query_cache_size/i ) {
            if ( !$Row[1] ) {
                $Check   = 'Critical';
                $Message = $Self->{LanguageObject}->Get('The setting "query_cache_size" should be used.');
            }
            elsif ( $Row[1] < 1024 * 1024 * 10 ) {
                $Row[1] = int( $Row[1] / 1024 / 1024 );
                $Check = 'Critical';
                $Message
                    = $Self->{LanguageObject}->Get("The setting 'query_cache_size' should be higher than 10 MB (it's")
                    . " $Row[1] MB).";
            }
            else {
                $Row[1]  = int( $Row[1] / 1024 / 1024 );
                $Check   = 'OK';
                $Message = "$Row[1] MB";
            }
        }
    }
    $Data = {
        Name        => $Self->{LanguageObject}->Get('Query Cache Size'),
        Description => $Self->{LanguageObject}->Get('Check "query_cache_size" setting.'),
        Comment     => $Message,
        Check       => $Check,
    };
    return $Data;
}

sub _StorageEngineCheck {
    my ( $Self, %Param ) = @_;

    $Self->{DBObject}->Prepare( SQL => "show variables where variable_name = 'storage_engine'" );
    my $StorageEngine;
    while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {
        $StorageEngine = $Row[1];
    }
    my $Data = {
        Name        => $Self->{LanguageObject}->Get('Default Storage Engine'),
        Description => $Self->{LanguageObject}->Get('Check Default Storage Engine.'),
        Comment     => $Self->{LanguageObject}->Get('The default storage engine is')
            . " $StorageEngine.",
        Check => 'OK',
    };
    return $Data;
}

sub _TablesWithDifferentStorageEngineCheck {
    my ( $Self, %Param ) = @_;

    my $Check   = 'OK';
    my $Comment = $Self->{LanguageObject}->Get('No tables found with different storage engine.');
    $Self->{DBObject}->Prepare( SQL => "show variables where variable_name = 'storage_engine'" );
    my $StorageEngine;
    while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {
        $StorageEngine = $Row[1];
    }

    $Self->{DBObject}->Prepare(
        SQL  => "show table status where engine != ?",
        Bind => [ \$StorageEngine ],
    );
    my @Tables;
    while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {
        push @Tables, $Row[0];
    }

    if (@Tables) {
        $Check   = 'Failed';
        $Comment = $Self->{LanguageObject}->Get('These tables use a different storage engine');
        $Comment .= ': ' . join( ', ', @Tables );
    }

    my $Data = {
        Name        => $Self->{LanguageObject}->Get('Tables with different storage engine'),
        Description => $Self->{LanguageObject}->Get('Test if there are tables with a different storage engine.'),
        Comment     => $Comment,
        Check       => $Check,
    };
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

            my @Problems;
            for my $Table ( @{ $XMLHash[1]->{database}->[1]->{Table} } ) {
                if ($Table) {
                    $Count++;

                    # use 'CHECK TABLE'-statement to determine state of each table
                    # (which may yield several lines per table, the last of which will
                    # contain the overall state of that table)
                    # Do quick checks on tables, other way it takes over 420 sec
                    # or longer to check it.
                    if (
                        $Self->{DBObject}->Prepare( SQL => "CHECK TABLE $Table->{Name} FAST QUICK" )
                        )
                    {
                        my $Status;
                        while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {
                            $Status = $Row[3];    # look at field 'Msg_text'
                        }
                        next if $Status =~ /^(OK|Table\sis\salready\sup\sto\sdate)/i;
                        push @Problems, "$Table->{Name}\[$Status\]";
                    }
                    else {
                        push @Problems, "$Table->{Name}\["
                            . $Self->{LanguageObject}->Get('unable to check table') . "\]";
                    }
                }
            }
            if (@Problems) {
                $Message = join "\n", @Problems;
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

sub _DatabaseSizeCheck {
    my ( $Self, %Param ) = @_;
    my $Data = {};

    # calculate and display database size
    my $Check   = 'Failed';
    my $Message = $Self->{LanguageObject}->Get('Could not determine database size.');
    my $DBName;

    $Self->{DBObject}->Prepare(
        SQL   => "SELECT DATABASE()",
        Limit => 1,
    );

    while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {
        if ( $Row[0] ) {
            $DBName = $Row[0];
        }
    }

    if ($DBName) {
        $Self->{DBObject}->Prepare(
            SQL => "SELECT ROUND((SUM(data_length + index_length) / 1024 / 1024 / 1024),3) "
                . "FROM information_schema.TABLES WHERE table_schema = ? GROUP BY table_schema",
            Bind  => [ \$DBName ],
            Limit => 1,
        );

        while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {
            if ( $Row[0] ) {
                $Message = $Self->{LanguageObject}->Get('Database size is') . " $Row[0] GB.";
                $Check   = 'OK';
            }
        }
    }
    else {
        $Message = $Self->{LanguageObject}->Get('Could not determine database name.');
    }

    $Data = {
        Name        => $Self->{LanguageObject}->Get('Database Size'),
        Description => $Self->{LanguageObject}->Get('Size of the current database.'),
        Comment     => $Message,
        Check       => $Check,
    };
    return $Data;
}

1;
