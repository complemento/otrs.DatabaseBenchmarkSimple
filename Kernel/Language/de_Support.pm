# --
# Copyright (C) 2001-2017 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Language::de_Support;

use strict;
use warnings;

sub Data {
    my $Self = shift;

    # Template: AdminSupport
    $Self->{Translation}->{'Support Assessment'} = '';
    $Self->{Translation}->{'Start support'} = '';
    $Self->{Translation}->{'SQL benchmark'} = '';
    $Self->{Translation}->{'For quick help please submit your system information and create a support ticket at the vendor\'s site.'} =
        '';
    $Self->{Translation}->{'For more info please check'} = '';
    $Self->{Translation}->{'Admin Support Info'} = '';
    $Self->{Translation}->{'Admin-Support Overview.'} = '';
    $Self->{Translation}->{'Confidential information'} = '';
    $Self->{Translation}->{'Vendor Support'} = '';
    $Self->{Translation}->{'Bugzilla ID'} = '';
    $Self->{Translation}->{'If you\'ve already added a Bugzilla report at bugs.otrs.org, please add your Bugzilla ID here.'} =
        '';
    $Self->{Translation}->{'Service Contract'} = 'Wartungsvertrag';
    $Self->{Translation}->{'Please recommend me a Service Contract to optimize my OTRS'} =
        'Bitte empfehlen Sie mir einen Servicevertrag zur Optimierung meines OTRS Systems';
    $Self->{Translation}->{'Can\'t create support package, because you work currently with the system user root@localhost and your admin email address is not yet configured. Please define the admin email setting in the SysConfig module and don\'t use the user root@localhost for working with OTRS.'} =
        '';
    $Self->{Translation}->{'Please confirm the confidential information to continue.'} = '';
    $Self->{Translation}->{'Looks fine!'} = '';
    $Self->{Translation}->{'Ok'} = '';
    $Self->{Translation}->{'Should not take more than'} = '';
    $Self->{Translation}->{'on an average system'} = '';
    $Self->{Translation}->{'Benchmark'} = '';
    $Self->{Translation}->{'Execute a SQL benchmark test on your database to find out how fast your database is (done on dedicated benchmark table).'} =
        '';
    $Self->{Translation}->{'This should not be done on production systems!'} = '';
    $Self->{Translation}->{'Multiplier'} = '';
    $Self->{Translation}->{'Please select a multiplier and press start button.'} = '';

    # Template: AdminSupportLicenseText

    # SysConfig

    $Self->{Translation}->{'The used sender mail address.'} = 'Die verwendete Absenderadresse.';
    $Self->{Translation}->{'Definition of the Cron checks.'} = 'Definition der Cron-Checks.';
    $Self->{Translation}->{'Definition of the OTRS checks.'} = 'Definition der OTRS-Checks.';
    $Self->{Translation}->{'Definition of the Operating System checks.'} = 'Definition der Betriebssystem-Checks.';
    $Self->{Translation}->{'Definition of the database checks for the MSSQL database.'} = 'Definition der Datenbank-Checks für die MSSQL Datenbank.';
    $Self->{Translation}->{'Definition of the database checks for the MySQL database.'} = 'Definition der Datenbank-Checks für die MySQL Datenbank.';
    $Self->{Translation}->{'Definition of the database checks for the Oracle database.'} = 'Definition der Datenbank-Checks für die Oracle Datenbank.';
    $Self->{Translation}->{'Definition of the database checks for the PostgreSQL database.'} = 'Definition der Datenbank-Checks für die PostgreSQL Datenbank.';
    $Self->{Translation}->{'Definition of the webserver checks for the Apache webserver.'} = 'Definition der Webserver-Checks für den Apache Webserver.';
    $Self->{Translation}->{'Definition of the webserver checks for the IIS webserver.'} = 'Definition der Webserver-Checks für den IIS Webserver.';
    $Self->{Translation}->{'Frontend module registration for the AdminSystemStatus object in the admin area.'} = 'Frontendmodul-Registration des AdminSystemStatus-Objekts im Admin-Bereich.';

    # Database
    $Self->{Translation}->{'Database'} = '';

    # mysql
    $Self->{Translation}->{'No MySQL version found.'} = '';
    $Self->{Translation}->{'MySQL version'} = '';
    $Self->{Translation}->{'you should use 5.0 or higher.'} = '';
    $Self->{Translation}->{'Unknown MySQL version'} = '';
    $Self->{Translation}->{'Database Version.'} = '';
    $Self->{Translation}->{'Check database version.'} = '';

    $Self->{Translation}->{'Database (utf8)'} = '';
    $Self->{Translation}->{'Check database utf8 support.'} = '';
    $Self->{Translation}->{'No database version found.'} = '';
    $Self->{Translation}->{'Your database version supports utf8.'} = '';
    $Self->{Translation}->{'utf8 is not supported'} = '';

    $Self->{Translation}->{'No character_set_client setting found.'} = '';
    $Self->{Translation}->{'Your client connection is'} = '';
    $Self->{Translation}->{"Found character_set_client, but it's set to"} = '';
    $Self->{Translation}->{'needs to be utf8'} = '';
    $Self->{Translation}->{'Client Connection (utf8)'} = '';
    $Self->{Translation}->{'Check if the client uses utf8 for the connection.'} = '';

    $Self->{Translation}->{'No character_set_database setting found.'} = '';
    $Self->{Translation}->{"Character_set_database setting found, but it's set to"} = '';
    $Self->{Translation}->{'needs to be utf8'} = '';
    $Self->{Translation}->{'Your database charset setting is'} = '';
    $Self->{Translation}->{'Database Charset (utf8)'} = '';
    $Self->{Translation}->{'Check if the database uses utf8 as charset.'} = '';

    $Self->{Translation}->{'Invalid charset collation for'} = '';
    $Self->{Translation}->{'Table Collation (utf8)'} = '';
    $Self->{Translation}->{'Check the utf8 table charset collation.'} = '';
    $Self->{Translation}->{'Your charset collation is set to'} = '';

    $Self->{Translation}->{'No "max_allowed_packet" configuration found.'} = '';
    $Self->{Translation}->{"should be higher than 20 MB (it's"} = '';
    $Self->{Translation}->{'Your configuration setting is'} = '';
    $Self->{Translation}->{'Max Package Size'} = '';
    $Self->{Translation}->{'Check "max_allowed_packet" setting.'} = '';

    $Self->{Translation}->{'No "query_cache_size" setting found.'} = '';
    $Self->{Translation}->{'The setting "query_cache_size" should be used.'} = '';
    $Self->{Translation}->{"The setting 'query_cache_size' should be higher than 10 MB (it's"} = '';
    $Self->{Translation}->{'Query Cache Size'} = '';
    $Self->{Translation}->{'Check "query_cache_size" setting.'} = '';

    $Self->{Translation}->{'There is no difference between application server time and database server time.'} = '';
    $Self->{Translation}->{'There is a material difference ('} = '';
    $Self->{Translation}->{' seconds) between application server ('} = '';
    $Self->{Translation}->{') and database server ('} = '';
    $Self->{Translation}->{') time.'} = '';
    $Self->{Translation}->{'Current Timestamp Check'} = '';
    $Self->{Translation}->{'Check "System Time" vs "Current Timestamp".'} = '';

    $Self->{Translation}->{'unable to check table'} = '';
    $Self->{Translation}->{'tables checked.'} = '';
    $Self->{Translation}->{'Table Check'} = '';
    $Self->{Translation}->{'Check existing framework tables.'} = '';
    $Self->{Translation}->{"Can't open file"} = '';
    $Self->{Translation}->{"Can't find file"} = '';

    $Self->{Translation}->{'Could not determine database size.'} = '';
    $Self->{Translation}->{'Database size is'} = '';
    $Self->{Translation}->{'Could not determine database name.'} = '';
    $Self->{Translation}->{'Database Size'} = '';
    $Self->{Translation}->{'Size of the current database.'} = '';

    # Postgresql
    $Self->{Translation}->{'nonexisting table(s)'} = '';

    $Self->{Translation}->{'Unknown DateStyle'} = '';
    $Self->{Translation}->{'need ISO.'} = '';
    $Self->{Translation}->{'DateStyle'} = '';
    $Self->{Translation}->{'Check DateStyle.'} = '';

    $Self->{Translation}->{'No server_encoding found.'} = '';
    $Self->{Translation}->{"Setting server_encoding found, but it's set to"} = '';
    $Self->{Translation}->{'(need to be UNICODE or UTF8).'} = '';
    $Self->{Translation}->{'Server Connection (utf8)'} = '';
    $Self->{Translation}->{'Check the utf8 server connection.'} = '';

    $Self->{Translation}->{'No client_encoding found.'} = '';
    $Self->{Translation}->{"Setting client_encoding found, but it's set to"} = '';
    $Self->{Translation}->{'Client Connection (utf8)'} = '';
    $Self->{Translation}->{'Check the utf8 client connection.'} = '';

    $Self->{Translation}->{'No PostgreSQL version found.'} = '';
    $Self->{Translation}->{'You use PostgreSQL version'} = '';
    $Self->{Translation}->{'you should use 8.x or higner.'} = '';
    $Self->{Translation}->{'Unknown PostgreSQL version'} = '';

    # MSSQL
    $Self->{Translation}->{'Could not determine Microsoft SQL Server version.'} = '';
    $Self->{Translation}->{'is'} = '';
    $Self->{Translation}->{'large, of which'} = '';
    $Self->{Translation}->{'is available.'} = '';
    $Self->{Translation}->{'Size'} = '';
    $Self->{Translation}->{'Check database size.'} = '';

    $Self->{Translation}->{'Could not determine database hostname.'} = '';
    $Self->{Translation}->{'DatabaseHost'} = '';
    $Self->{Translation}->{'Hostname'} = '';
    $Self->{Translation}->{'Check database hostname.'} = '';
    $Self->{Translation}->{"Table doesn't exist"} = '';
    $Self->{Translation}->{'tables'} = '';

    # Oracle
    $Self->{Translation}->{'No ORACLE_HOME setting found.'} = '';
    $Self->{Translation}->{"ORACLE_HOME don't exists"} = '';
    $Self->{Translation}->{'Your ORACLE_Home configuration is'} = '';
    $Self->{Translation}->{'ORACLE_HOME'} = '';
    $Self->{Translation}->{'Check ORACLE_HOME configuration.'} = '';

    $Self->{Translation}->{'No NLS_LANG configuration found.'} = '';
    $Self->{Translation}->{'need .utf8 in NLS_LANG (e. g. german_germany.utf8).'} = '';
    $Self->{Translation}->{'Your NLS_LANG configuration is'} = '';
    $Self->{Translation}->{'Check NLS_LANG.'} = '';

    $Self->{Translation}->{'No NLS_DATE_FORMAT setting found.'} = '';
    $Self->{Translation}->{"Need format 'YYYY-MM-DD HH24:MI:SS' for NLS_DATE_FORMAT (not"} = "Es necesario el formato 'YYYY-MM-DD HH24:MI:SS' para NLS_DATE_FORMAT (no";
    $Self->{Translation}->{'Your NLS_DATE_FORMAT setting is'} = '';
    $Self->{Translation}->{'Check NLS_DATE_FORMAT.'} = '';
    $Self->{Translation}->{'NLS_DATE_FORMAT seems to be wrong'} = '';
    $Self->{Translation}->{"is not the right format 'yyyy-mm-dd hh:mm::ss' (please check"} = "no es el formato correcto 'yyyy-mm-dd hh:mm::ss' (por favor verifique";
    $Self->{Translation}->{'NLS_DATE_Format has the right format'} = '';
    $Self->{Translation}->{'Check NLS_DATE_FORMAT by using SELECT statement.'} = '';
    $Self->{Translation}->{"Table don't exists"} = '';

    # webserver
    $Self->{Translation}->{'Webserver'} = '';

    # apache
    $Self->{Translation}->{'You are running'} = '';
    $Self->{Translation}->{'Could not determine Apache version.'} = '';
    $Self->{Translation}->{'Apache Version'} = '';
    $Self->{Translation}->{'Display web server version.'} = '';

    $Self->{Translation}->{'Apache::DBI should be used to get a better performance (pre-establish database connections).'} = '';
    $Self->{Translation}->{'Check if the system uses Apache::DBI.'} = '';

    $Self->{Translation}->{'Apache::Reload or Apache2::Reload should be used as PerlModule and PerlInitHandler to prevent web server restarts when installing and upgrading modules.'} = '';
    $Self->{Translation}->{'Check if the system uses Apache::Reload/Apache2::Reload.'} = '';

    $Self->{Translation}->{'You use a beta version of mod_perl'} = '';
    $Self->{Translation}->{'you should upgrade to a stable version.'} = '';
    $Self->{Translation}->{'You should update mod_perl to'} = '';
    $Self->{Translation}->{'You are using FastCGI.'} = '';
    $Self->{Translation}->{'You should use FastCGI or mod_perl to increase your performance.'} = '';
    $Self->{Translation}->{'CGI Accelerator'} = '';
    $Self->{Translation}->{'Check for CGI Accelerator.'} = '';

    # IIS
    $Self->{Translation}->{'PerlEx is in use'} = '';
    $Self->{Translation}->{'You should use PerlEx to increase your performance.'} = '';
    $Self->{Translation}->{'Check if PerlEx is used.'} = '';

    # os
    $Self->{Translation}->{'OS'} = '';

    $Self->{Translation}->{'Distribution'} = '';
    $Self->{Translation}->{'Shows the used distribution.'} = '';
    $Self->{Translation}->{'is used.'} = '';
    $Self->{Translation}->{'Distribution unknown.'} = '';
    $Self->{Translation}->{'Can\'t determine distribution.'} = '';

    $Self->{Translation}->{'Kernel Version'} = '';
    $Self->{Translation}->{'Shows the used Kernel version.'} = '';
    $Self->{Translation}->{'Can\'t execute uname -a...'} = '';

    $Self->{Translation}->{'PerlCheck'} = '';
    $Self->{Translation}->{'Check Perl version.'} = '';
    $Self->{Translation}->{'Your Perl'} = '';
    $Self->{Translation}->{'is too old, you should upgrade to Perl 5.8.8 or higher.'} = '';
    $Self->{Translation}->{'Unable to parse version string'} = '';

    $Self->{Translation}->{'PerlModulesCheck'} = '';
    $Self->{Translation}->{'Check Perl Modules installed.'} = '';
    $Self->{Translation}->{'There is an error in your installed perl modules configuration. Please contact your administrator.'} = '';
    $Self->{Translation}->{'All Perl modules needed are currently installed.'} = '';
    $Self->{Translation}->{'Unable to check Perl modules.'} = '';

    $Self->{Translation}->{'The Host System has'} = '';
    $Self->{Translation}->{'MB Memory total'} = '';
    $Self->{Translation}->{'MB Memory free'} = '';
    $Self->{Translation}->{'MB Swap total'} = '';
    $Self->{Translation}->{'MB Swap free'} = '';
    $Self->{Translation}->{'Memory Swap Check'} = '';
    $Self->{Translation}->{'A Memory Check. We try to find out if SwapFree : SwapTotal < 60 % or if more than 200 MB Swap is used.'} = '';
    $Self->{Translation}->{'No Swap enabled!'} = '';

    $Self->{Translation}->{'The Host System has a load'} = '';
    $Self->{Translation}->{'in the last 1 minute'} = '';
    $Self->{Translation}->{'in the last 5 minutes'} = '';
    $Self->{Translation}->{'in the last 15 minutes'} = '';
    $Self->{Translation}->{'CPU Load'} = '';
    $Self->{Translation}->{'A CPU load check. We try to find out if the system load in the last 15 minutes > 1.'} = '';
    $Self->{Translation}->{'A CPU load check. We try to find out if the system load in the last 15 minutes > 1.'} = '';

    $Self->{Translation}->{'Disk is full'} = '';
    $Self->{Translation}->{'Disk usage'} = '';
    $Self->{Translation}->{'Check disk usage.'} = '';

    # OTRS
    $Self->{Translation}->{'You have more error log entries: '} = '';
    $Self->{Translation}->{'There is one error log entry: '} = '';
    $Self->{Translation}->{'LogCheck'} = '';
    $Self->{Translation}->{'Check log for error log entries.'} = '';

    $Self->{Translation}->{'tickets in your system. You should use the StaticDB backend. See admin manual (Performance Tuning) for more information.'} =
        '';
    $Self->{Translation}->{'You are using'} = '';
    $Self->{Translation}->{"that's fine for"} = '';
    $Self->{Translation}->{'tickets in your system.'} = '';
    $Self->{Translation}->{'Check Ticket::IndexModule setting.'} = '';

    $Self->{Translation}->{'tickets in StaticDB lock_index but you are using the'} = '';
    $Self->{Translation}->{'index. Please run otrs/bin/otrs.CleanTicketIndex.pl to clean the StaticDB index.'} = '';
    $Self->{Translation}->{'tickets in StaticDB index but you are using the'} = '';
    $Self->{Translation}->{'Skipping test.'} = '';
    $Self->{Translation}->{'No orphaned records found.'} = '';
    $Self->{Translation}->{'TicketStaticDBOrphanedRecords'} = '';
    $Self->{Translation}->{'Check orphaned StaticDB records.'} = '';

    $Self->{Translation}->{'articles in your system. You should use the StaticDB backend for OTRS 2.3 and higher. See admin manual (Performance Tuning) for more information.'} =
        '';

    $Self->{Translation}->{'Install directory'} = '';
    $Self->{Translation}->{'articles in your system.'} = '';
    $Self->{Translation}->{'Check Ticket::SearchIndexModule setting.'} = '';

    $Self->{Translation}->{'You should not have more than 8000 open tickets in your system. You currently have over 89999! In case you want to improve your performance, close not needed open tickets.'} =
        '';
    $Self->{Translation}->{'You should not have over 8000 open tickets in your system. You currently have '} = '';
    $Self->{Translation}->{'In case you want to improve your performance, close not needed open tickets.'} = '';
    $Self->{Translation}->{'You should not have more than 8000 open tickets in your system. You currently have '} = '';
    $Self->{Translation}->{'You have '} = '';
    $Self->{Translation}->{' open tickets in your system.'} = '';
    $Self->{Translation}->{'OpenTicketCheck'} = '';
    $Self->{Translation}->{'Check open tickets in your system.'} = '';

    $Self->{Translation}->{'FQDNConfigCheck'} = '';
    $Self->{Translation}->{'Check if the configured FQDN is valid.'} = '';
    $Self->{Translation}->{'Please configure your FQDN inside the SysConfig module. (currently the default setting'} = '';
    $Self->{Translation}->{'is enabled).'} = '';
    $Self->{Translation}->{'Invalid FQDN'} = '';
    $Self->{Translation}->{'looks good.'} = '';

    $Self->{Translation}->{'SystemIDConfigCheck'} = '';
    $Self->{Translation}->{'Check if the configured SystemID contains only digits.'} = '';
    $Self->{Translation}->{'Your SystemID setting is'} = '';
    $Self->{Translation}->{'The SystemID'} = '';
    $Self->{Translation}->{'must consist of digits exclusively.'} = '';

    $Self->{Translation}->{'ResponseFormatCheck'} = '';
    $Self->{Translation}->{'Check if Ticket::Frontend::ResponseFormat contains no $Data{""}.'} = '';
    $Self->{Translation}->{'was not found.'} = '';
    $Self->{Translation}->{'Config option Ticket::Frontend::ResponseFormat cointains'} = '';
    $Self->{Translation}->{'should be used instand (see default setting).'} = '';

    $Self->{Translation}->{'FileSystemCheck'} = '';
    $Self->{Translation}->{'Check if file system is writable.'} = '';
    $Self->{Translation}->{'The file system is writable.'} = '';
    $Self->{Translation}->{'No such home directory'} = '';
    $Self->{Translation}->{"Can't write file"} = '';

    $Self->{Translation}->{'PackageDeployCheck'} = '';
    $Self->{Translation}->{'Check deployment of all packages.'} = '';
    $Self->{Translation}->{'All packages are correctly installed.'} = '';
    $Self->{Translation}->{'Packages not correctly installed'} = '';

    $Self->{Translation}->{'InvalidUserLockedTicketSearch'} = '';
    $Self->{Translation}->{'Search for invalid user with locked tickets.'} = '';
    $Self->{Translation}->{'There are no invalid users with locked tickets.'} = '';
    $Self->{Translation}->{'These invalid users have locked tickets'} = '';

    $Self->{Translation}->{'DefaultUserCheck'} = '';
    $Self->{Translation}->{'Check if root@localhost account has the default password.'} = '';
    $Self->{Translation}->{'There is no active root@localhost with default password.'} = '';
    $Self->{Translation}->{"Change the password or invalidate the account 'root\@localhost'."} = '';

    $Self->{Translation}->{'SOAPCheck'} = '';
    $Self->{Translation}->{'Check default SOAP credentials.'} = '';
    $Self->{Translation}->{'You have not enabled SOAP or have set your own password.'} = '';
    $Self->{Translation}->{'Please set a strong password for SOAP::Password in SysConfig.'} = '';

    $Self->{Translation}->{'Product'} = 'Produkt';
    $Self->{Translation}->{'Tickets'} = 'Tickets';
    $Self->{Translation}->{'Articles'} = 'Artikel';
    $Self->{Translation}->{'Agents'} = 'Agenten';
    $Self->{Translation}->{'Roles'} = 'Rollen';
    $Self->{Translation}->{'Groups'} = 'Gruppen';
    $Self->{Translation}->{'Articles per ticket (avg)'} = '';
    $Self->{Translation}->{'Operating system'} = '';
    $Self->{Translation}->{'Months between first and last ticket'} = '';
    $Self->{Translation}->{'Tickets per month (avg)'} = '';
    $Self->{Translation}->{'Attachments per ticket (avg)'} = '';
    $Self->{Translation}->{'Attachment size (avg)'} = '';
    $Self->{Translation}->{'GeneralSystemOverview'} = '';
    $Self->{Translation}->{'Display a general system overview'} = '';
    $Self->{Translation}->{'General information about your system.'} = '';

}

1;
