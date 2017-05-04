# --
# Copyright (C) 2001-2017 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::AdminSupport;

use strict;
use warnings;

use Kernel::System::Support;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );


    # create additional objects
    $Self->{LayoutObject} = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    $Self->{ConfigObject} =  $Kernel::OM->Get('Kernel::Config');
    $Self->{UserObject}    = $Kernel::OM->Get('Kernel::System::User');
    $Self->{SupportObject} = $Kernel::OM->Get('Kernel::System::Support');;
	$Self->{ParamObject} = $Kernel::OM->Get('Kernel::System::Web::Request');
    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # get user data
    my %User = $Self->{UserObject}->GetUserData(
        UserID => $Self->{UserID},
        Cached => 1,
    );

	$Self->{LayoutuObject} = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
	
    # get sender email adress
    my $SenderAdress = '';
    if ( $Self->{ConfigObject}->Get('Support::SenderEmail') ) {
        $SenderAdress = $Self->{ConfigObject}->Get('Support::SenderEmail');
    }
    elsif ( $User{UserEmail} && $User{UserEmail} !~ /root\@localhost/ ) {
        $SenderAdress = $User{UserEmail};
    }
    elsif (
        $Self->{ConfigObject}->Get('AdminEmail')
        && $Self->{ConfigObject}->Get('AdminEmail') !~ /root\@localhost/
        && $Self->{ConfigObject}->Get('AdminEmail') !~ /admin\@example.com/
        )
    {
        $SenderAdress = $Self->{ConfigObject}->Get('AdminEmail');
    }

    # ------------------------------------------------------------ #
    # Confidential
    # ------------------------------------------------------------ #

    if ( $Self->{Subaction} eq 'Confidential' ) {

        # create & return output
        my $Output = $Self->{LayoutObject}->Header();
        $Output .= $Self->{LayoutObject}->NavigationBar();

        $Self->{LayoutObject}->Block(
            Name => 'Confidential',
        );

        if ( $User{UserLanguage} && $User{UserLanguage} =~ /de/ ) {
            $Self->{LayoutObject}->Block(
                Name => 'ConfidentialContentDE',
            );
        }
        else {
            $Self->{LayoutObject}->Block(
                Name => 'ConfidentialContentEN',
            );
        }

        $Output .= $Self->{LayoutObject}->Output(
            TemplateFile => 'AdminSupport',
        );
        $Output .= $Self->{LayoutObject}->Footer();

        return $Output;
    }

    # ------------------------------------------------------------ #
    # Sender Information
    # ------------------------------------------------------------ #

    elsif ( $Self->{Subaction} eq 'SenderInformation' ) {

        # create & return output
        my $Output = $Self->{LayoutObject}->Header();
        $Output .= $Self->{LayoutObject}->NavigationBar();

        $Self->{LayoutObject}->Block(
            Name => 'SenderInformation',
            Data => {
                SenderAdress     => $SenderAdress,
                SenderSalutation => $User{UserSalutation},
                SenderName       => $User{UserFirstname} . ' ' . $User{UserLastname},
            },
        );

        $Output .= $Self->{LayoutObject}->Output(
            TemplateFile => 'AdminSupport',
        );
        $Output .= $Self->{LayoutObject}->Footer();

        return $Output;
    }

    # ------------------------------------------------------------ #
    # UploadSupportInfo
    # ------------------------------------------------------------ #

    elsif ( $Self->{Subaction} eq 'Submit' ) {

        # get params
        my %CustomerInfo;
        for my $Key (qw(Sender Company Salutation Name Street Zip City Phone SendInfo BugzillaID)) {
            $CustomerInfo{$Key} = $Self->{ParamObject}->GetParam( Param => $Key );
        }

        # if the button send becomes the submit
        if ( $Self->{ParamObject}->GetParam( Param => 'Send' ) ) {

            # create & return output
            my $Output = $Self->{LayoutObject}->Header();
            $Output .= $Self->{LayoutObject}->NavigationBar();

            $Self->{LayoutObject}->Block(
                Name => 'SenderInformation',
                Data => {
                    SenderAdress     => $SenderAdress,
                    SenderSalutation => $User{UserSalutation},
                    SenderName       => $User{UserFirstname} . ' ' . $User{UserLastname},
                },
            );

            my $SendMessage = $Self->{SupportObject}->SendInfo(
                CustomerInfo => \%CustomerInfo,
            );
            if ($SendMessage) {
                $Output .= $Self->{LayoutObject}->Notify(
                    Priority => 'warning',
                    Info     => 'Sent package to OTRS Group.',
                );
            }
            else {
                $Output .= $Self->{LayoutObject}->Notify(
                    Priority => 'warning',
                    Info     => 'Can not send email to OTRS Group!' . "\n\n"
                        . "You can download the support package and send it in manually if needed.\n"
                        . "If you would like to use OTRS services please send the package to support\@otrs.com or call\n"
                        . "our team by phone to review the next step.\n\n"
                        . "You can find more information about OTRS services as well as contact information at\n"
                        . 'http://www.otrs.com/' . "\n\n",
                );
            }

            $Output .= $Self->{LayoutObject}->Output(
                TemplateFile => 'AdminSupport',
            );
            $Output .= $Self->{LayoutObject}->Footer();

            return $Output;
        }

        # if the button download becomes the submit
        else {

            my ( $Content, $Filename ) = $Self->{SupportObject}->Download(
                %CustomerInfo,
            );

            # return file
            return $Self->{LayoutObject}->Attachment(
                ContentType => 'application/octet-stream',
                Content     => ${$Content},
                Filename    => $Filename,
                Type        => 'attached',
            );
        }
    }

    # ------------------------------------------------------------ #
    # SQL bench Init
    # ------------------------------------------------------------ #

    elsif ( $Self->{Subaction} eq 'BenchmarkSQLInit' ) {

        # selection data for benchmark dropdown list
        my %SelectionData = (
            Data => {
                1 => '1 * low',
                3 => '3 * very low',
                5 => '5 * normal',
                50 => 'high',
                150 => 'very high',
            },
            Name => 'Mode',
        );

        # check if Layout object knows the function BuildSelection
        # this is needed because older otrs versions use OptionStrgHashRef instead
        if ( $Self->{LayoutObject}->can('BuildSelection') ) {

            # build selection for benchmark test
            $Param{ModeStrg} = $Self->{LayoutObject}->BuildSelection(%SelectionData);
        }
        else {

            # build selection for benchmark test
            $Param{ModeStrg} = $Self->{LayoutObject}->OptionStrgHashRef(%SelectionData);
        }

        $Self->{LayoutObject}->Block(
            Name => 'BenchmarkResultInit',
            Data => {
                ModeStrg => $Param{ModeStrg},
            },
        );
        my $Output = $Self->{LayoutObject}->Header();
        $Output .= $Self->{LayoutObject}->NavigationBar();
        $Output .= $Self->{LayoutObject}->Output(
            TemplateFile => 'AdminSupport',
            Data         => \%Param,
        );
        $Output .= $Self->{LayoutObject}->Footer();

        return $Output;
    }

    # ------------------------------------------------------------ #
    # SQL bench
    # ------------------------------------------------------------ #

    elsif ( $Self->{Subaction} eq 'BenchmarkSQL' ) {

        my $Mode = $Self->{ParamObject}->GetParam( Param => 'Mode' );

        my %Mood = ( 'Fine', ':-)', 'Ok', ':-|', 'Wrong', ':-(' );

        my %BenchTest = $Self->{SupportObject}->Benchmark(
            Mode => $Mode,
        );

        $Self->{LayoutObject}->Block(
            Name => 'BenchmarkResult',
            Data => {
                %BenchTest,
                Head => 'SQL',
            },
        );

        # Insert
        $Self->{LayoutObject}->Block(
            Name => 'BenchmarkResultRow',
            Data => {
                Key   => 'Insert Time',
                Time  => $BenchTest{InsertTime},
                Mood  => $Mood{ $BenchTest{InsertResult} },
                Value => ( 1 * $Mode ),
            },
        );
        $Self->{LayoutObject}->Block(
            Name => 'BenchmarkResultRow' . $BenchTest{InsertResult},
            Data => {
                ShouldTake => $BenchTest{InsertShouldTake} || '',
            },
        );

        # Update
        $Self->{LayoutObject}->Block(
            Name => 'BenchmarkResultRow',
            Data => {
                Key   => 'Update Time',
                Time  => $BenchTest{UpdateTime},
                Mood  => $Mood{ $BenchTest{UpdateResult} },
                Value => ( 1 * $Mode ),
            },
        );
        $Self->{LayoutObject}->Block(
            Name => 'BenchmarkResultRow' . $BenchTest{UpdateResult},
            Data => {
                ShouldTake => $BenchTest{UpdateShouldTake} || '',
            },
        );

        # Time
        $Self->{LayoutObject}->Block(
            Name => 'BenchmarkResultRow',
            Data => {
                Key   => 'Select Time',
                Time  => $BenchTest{SelectTime},
                Mood  => $Mood{ $BenchTest{SelectResult} },
                Value => ( 1 * $Mode ),
            },
        );
        $Self->{LayoutObject}->Block(
            Name => 'BenchmarkResultRow' . $BenchTest{SelectResult},
            Data => {
                ShouldTake => $BenchTest{SelectShouldTake} || '',
            },
        );

        # Delete
        $Self->{LayoutObject}->Block(
            Name => 'BenchmarkResultRow',
            Data => {
                Key   => 'Delete Time',
                Time  => $BenchTest{DeleteTime},
                Mood  => $Mood{ $BenchTest{DeleteResult} },
                Value => ( 1 * $Mode ),
            },
        );
        $Self->{LayoutObject}->Block(
            Name => 'BenchmarkResultRow' . $BenchTest{DeleteResult},
            Data => {
                ShouldTake => $BenchTest{DeleteShouldTake} || '',
            },
        );

        $Self->{LayoutObject}->Block(
            Name => 'BenchmarkResultRow',
            Data => {
                Key   => 'Multiplier',
                Value => "* $Mode",
            },
        );

        my $Output = $Self->{LayoutObject}->Output(
            TemplateFile => 'AdminSupport',
            Data         => \%BenchTest,
        );

        return $Output;
    }

    # ------------------------------------------------------------ #
    # overview
    # ------------------------------------------------------------ #

    else {

        # create & return output
        my $Output = $Self->{LayoutObject}->Header();
        $Output .= $Self->{LayoutObject}->NavigationBar();

        $Self->{LayoutObject}->Block(
            Name => 'Overview',
            Data => \%Param,
        );

        # get result of all admin checks
        my $DataHash = $Self->{SupportObject}->AdminChecksGet() || {};

        for my $Module ( sort keys %{$DataHash} ) {

            $Self->{LayoutObject}->Block(
                Name => 'OverviewModule',
                Data => {
                    Module => $Module,
                },
            );

            ROWHASH:
            for my $RowHash ( @{ $DataHash->{$Module} } ) {

                next ROWHASH if !$RowHash;
                next ROWHASH if ref $RowHash ne 'HASH';
                next ROWHASH if !%{$RowHash};

                $RowHash->{BlockStyle} ||= '';

                if ( $RowHash->{BlockStyle} ne 'TableDataSimple' ) {

                    # create new block with rotatory css
                    $Self->{LayoutObject}->Block(
                        Name => 'OverviewModuleRow' . $RowHash->{BlockStyle},
                        Data => {
                            %{$RowHash},
                        },
                    );
                }
                else {

                    $Self->{LayoutObject}->Block(
                        Name => 'OverviewModuleRowTableDataSimple',
                        Data => {
                            %{$RowHash},
                        },
                    );

                    my %TableValues;

                    if ( ref $RowHash->{TableInfo} eq 'HASH' ) {
                        %TableValues = %{ $RowHash->{TableInfo} };
                    }
                    else {
                        %TableValues = split /[=;\n]/, $RowHash->{TableInfo};
                    }

                    for my $Item ( sort keys %TableValues ) {
                        $Self->{LayoutObject}->Block(
                            Name => 'OverviewModuleTableRow',
                            Data => {
                                ItemKey => $Item,
                                Value   => $TableValues{$Item},
                            },
                        );
                    }
                }
            }
        }

        $Output .= $Self->{LayoutObject}->Output(
            TemplateFile => 'AdminSupport',
        );
        $Output .= $Self->{LayoutObject}->Footer();

        return $Output;
    }
}

1;
