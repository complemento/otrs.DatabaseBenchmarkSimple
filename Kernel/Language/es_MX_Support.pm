# --
# Copyright (C) 2001-2017 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Language::es_MX_Support;

use strict;
use warnings;

sub Data {
    my $Self = shift;

    # Template: AdminSupport
    $Self->{Translation}->{'Support Assessment'} = 'Valoraciones de soporte';
    $Self->{Translation}->{'Start support'} = 'Comenzar soporte';
    $Self->{Translation}->{'SQL benchmark'} = 'Comparativa SQL';
    $Self->{Translation}->{'For quick help please submit your system information and create a support ticket at the vendor\'s site.'} =
        'Para ayuda rápida por favor suministre su información y cree un ticket de soporte en el sitio del proveedor';
    $Self->{Translation}->{'For more info please check'} = 'Para mas información por favor visite';
    $Self->{Translation}->{'Admin Support Info'} = 'Información de soporte para administración';
    $Self->{Translation}->{'Admin-Support Overview.'} = 'Resumen de información de soporte para administración.';
    $Self->{Translation}->{'Confidential information'} = 'Información confidencial';
    $Self->{Translation}->{'Vendor Support'} = 'Soporte de proveedor';
    $Self->{Translation}->{'Bugzilla ID'} = 'Identificador Bugzilla';
    $Self->{Translation}->{'If you\'ve already added a Bugzilla report at bugs.otrs.org, please add your Bugzilla ID here.'} =
        'Si ya ha agregado un reporte de error en bugs.otrs.org, por favor agregue su identificador de Bugzilla aqui.';
    $Self->{Translation}->{'Service Contract'} = '';
    $Self->{Translation}->{'Please recommend me a Service Contract to optimize my OTRS'} =
        '';
    $Self->{Translation}->{'Can\'t create support package, because you work currently with the system user root@localhost and your admin email address is not yet configured. Please define the admin email setting in the SysConfig module and don\'t use the user root@localhost for working with OTRS.'} =
        'No es posible crear un paquete de soporte, debido a que se encuentra actualmente utilizando el usuario de sistema root@localhost, y su cuenta de correo electrónico para administración no se encuentra configurada, por favor defina las configuraciones pertinentes para dicho correo electrónico en el modulo de Configuración del sistema y no utilize el usuario root@localhost para trabajar con OTRS.';
    $Self->{Translation}->{'Please confirm the confidential information to continue.'} = 'Por favor confirme su información confidencial para continuar.';
    $Self->{Translation}->{'Looks fine!'} = 'Se ve bien';
    $Self->{Translation}->{'Ok'} = 'Ok';
    $Self->{Translation}->{'Should not take more than'} = 'No debería tardar mas de ';
    $Self->{Translation}->{'on an average system'} = 'en un sistema promedio';
    $Self->{Translation}->{'Benchmark'} = 'Comparativa';
    $Self->{Translation}->{'Execute a SQL benchmark test on your database to find out how fast your database is (done on dedicated benchmark table).'} =
        'Ejecuta una comparativa SQL para conocer que tan rápida es su base de datos (Se realiza en una tabla dedicada para dicha comparativa).';
    $Self->{Translation}->{'This should not be done on production systems!'} = 'No deberá ser ejecutada en un sistema en producción!';
    $Self->{Translation}->{'Multiplier'} = 'Multiplicador';
    $Self->{Translation}->{'Please select a multiplier and press start button.'} = 'Por favor seleccione un multiplicador y presione el botón de iniciar.';

    # Template: AdminSupportLicenseText

    # SysConfig

    $Self->{Translation}->{'The used sender mail address.'} = 'Dirección de correo para enviar paquetes de soporte.';
    $Self->{Translation}->{'Definition of the Cron checks.'} = 'Definición de las verificaciones para Cron';
    $Self->{Translation}->{'Definition of the OTRS checks.'} = 'Definición de las verificaciones para OTRS';
    $Self->{Translation}->{'Definition of the Operating System checks.'} = 'Definición de las verificaciones para el Sistema Operativo';
    $Self->{Translation}->{'Definition of the database checks for the MSSQL database.'} = 'Definición de las verificaciones para la base de datos MSSQL';
    $Self->{Translation}->{'Definition of the database checks for the MySQL database.'} = 'Definición de las verificaciones para la base de datos MySQL';
    $Self->{Translation}->{'Definition of the database checks for the Oracle database.'} = 'Definición de las verificaciones para la base de datos Oracle';
    $Self->{Translation}->{'Definition of the database checks for the PostgreSQL database.'} = 'Definición de las verificaciones para la base de datos PostgreSQL';
    $Self->{Translation}->{'Definition of the webserver checks for the Apache webserver.'} = 'Definición de las verificaciones para el servidor web Apache';
    $Self->{Translation}->{'Definition of the webserver checks for the IIS webserver.'} = 'Definición de las verificaciones para el servidor web IIS';
    $Self->{Translation}->{'Frontend module registration for the AdminSystemStatus object in the admin area.'} = 'Registro en el sistema del modulo de soporte.';

    # Database

    # mysql
    $Self->{Translation}->{'Database'} = 'Base de datos';
    $Self->{Translation}->{'No MySQL version found.'} = 'No fue encontrada ninguna versión de MySQL';
    $Self->{Translation}->{'MySQL version'} = 'Versión de MySQL';
    $Self->{Translation}->{'you should use 5.0 or higher.'} = 'debería de usar la versión 5.0 o superior.';
    $Self->{Translation}->{'Unknown MySQL version'} = 'Versión de base de datos MySQL desconocida';
    $Self->{Translation}->{'Database Version.'} = 'Versión de base de datos';
    $Self->{Translation}->{'Check database version.'} = 'Verifica la versión de base de datos';

    $Self->{Translation}->{'Database (utf8)'} = 'Base de datos (utf8)';
    $Self->{Translation}->{'Check database utf8 support.'} = 'Verifica soporte para utf8 en la base de datos.';
    $Self->{Translation}->{'No database version found.'} = 'No fue encontrada versión para la base de datos';
    $Self->{Translation}->{'Your database version supports utf8.'} = 'La versión de base de datos soporta utf8';
    $Self->{Translation}->{'utf8 is not supported'} = 'utf8 no es soportado';

    $Self->{Translation}->{'No character_set_client setting found.'} = 'No fue encontrada la configuración character_set_client';
    $Self->{Translation}->{'Your client connection is'} = 'Tu conexion de cliente es';
    $Self->{Translation}->{"Found character_set_client, but it's set to"} = 'Se encontró character_set_client, pero tiene un valor de';
    $Self->{Translation}->{'needs to be utf8'} = 'necesita ser utf8';
    $Self->{Translation}->{'Client Connection (utf8)'} = 'Conexion de cliente (utf8)';
    $Self->{Translation}->{'Check if the client uses utf8 for the connection.'} = 'Verifica si el cliente utiliza utf8 para la conexión';

    $Self->{Translation}->{'No character_set_database setting found.'} = 'No se ha encontrado la configuración "character_set_database"';
    $Self->{Translation}->{"Character_set_database setting found, but it's set to"} = 'Se ha encontrado la configuración "character_set_database", pero con un valor de';
    $Self->{Translation}->{'needs to be utf8'} = 'necesita ser utf8';
    $Self->{Translation}->{'Your database charset setting is'} = 'La configuración de juego de caracteres para tu base de datos es';
    $Self->{Translation}->{'Database Charset (utf8)'} = 'Juego de caracteres de la base de datos (utf8)';
    $Self->{Translation}->{'Check if the database uses utf8 as charset.'} = 'Verifica si la base de datos utiliza utf8 como juego de caracteres.';

    $Self->{Translation}->{'Invalid charset collation for'} = 'Cotejado de juego de caracteres invalido para';
    $Self->{Translation}->{'Table Collation (utf8)'} = 'Cotejado de tabla (utf8)';
    $Self->{Translation}->{'Check the utf8 table charset collation.'} = 'Verifica el cotejado de juego de caracteres utf8 de las tablas';
    $Self->{Translation}->{'Your charset collation is set to'} = 'El cotejado de juego de caracteres se encuentra colocado a';

    $Self->{Translation}->{'No "max_allowed_packet" configuration found.'} = 'No se ha encontrado la configuración "max_allowed_packet"';
    $Self->{Translation}->{"should be higher than 20 MB (it's"} = 'Debería ser mayor a 20 MB (es';
    $Self->{Translation}->{'Your configuration setting is'} = 'La opción de configuración es';
    $Self->{Translation}->{'Max Package Size'} = 'Tamaño máximo de paquete';
    $Self->{Translation}->{'Check "max_allowed_packet" setting.'} = 'Verifica la configuración "max_allowed_packet"';

    $Self->{Translation}->{'No "query_cache_size" setting found.'} = 'No se ha encontrado la configuración "query_cache_size".';
    $Self->{Translation}->{'The setting "query_cache_size" should be used.'} = 'La configuración "query_cache_size" debe ser usada';
    $Self->{Translation}->{"The setting 'query_cache_size' should be higher than 10 MB (it's"} = 'La configuración "query_cache_size" debe ser mayor a 10 MB (es';
    $Self->{Translation}->{'Query Cache Size'} = 'tamaño del cache para consulta';
    $Self->{Translation}->{'Check "query_cache_size" setting.'} = 'Verifica la configuración "query_cache_size"';

    $Self->{Translation}->{'There is no difference between application server time and database server time.'} = 'No existe diferencia entre el tiempo del servidor y el de la base de datos';
    $Self->{Translation}->{'There is a material difference ('} = 'Existe una diferencia notable (';
    $Self->{Translation}->{' seconds) between application server ('} = ' segundos) entre el servidor de aplicación (';
    $Self->{Translation}->{') and database server ('} = ') y el servidor de base de datos (';
    $Self->{Translation}->{') time.'} = ') tiempo';
    $Self->{Translation}->{'Current Timestamp Check'} = 'Verificación de la marca de tiempo actual';
    $Self->{Translation}->{'Check "System Time" vs "Current Timestamp".'} = 'Verifica las variables de tiempo "System Time" contra "Current Timestamp".';

    $Self->{Translation}->{'unable to check table'} = 'No es posible verificar la tabla';
    $Self->{Translation}->{'tables checked.'} = 'tablas verificadas.';
    $Self->{Translation}->{'Table Check'} = 'Verificación de tabla';
    $Self->{Translation}->{'Check existing framework tables.'} = 'Verifica las tablas existentes para el sistema base';
    $Self->{Translation}->{"Can't open file"} = 'No se puede abrir el archivo';
    $Self->{Translation}->{"Can't find file"} = 'No se puede encontrar el archivo';

    $Self->{Translation}->{'Could not determine database size.'} = 'No se ha podido determinar el tamaño de la base de datos';
    $Self->{Translation}->{'Database size is'} = 'El tamaño de base de datos es';
    $Self->{Translation}->{'Could not determine database name.'} = 'No ha sido posible determinar el nombre de la base de datos.';
    $Self->{Translation}->{'Database Size'} = 'Tamaño de la base de datos';
    $Self->{Translation}->{'Size of the current database.'} = 'Tamaño actual de la base de datos.';

    # Postgresql
    $Self->{Translation}->{'nonexisting table(s)'} = 'tabla(s) inexistente(s)';

    $Self->{Translation}->{'Unknown DateStyle'} = 'Estilo de fecha desconocido';
    $Self->{Translation}->{'need ISO.'} = 'ISO es necesario';
    $Self->{Translation}->{'DateStyle'} = 'Estilo de fecha';
    $Self->{Translation}->{'Check DateStyle.'} = 'Verifica el estilo de fecha';

    $Self->{Translation}->{'No server_encoding found.'} = 'server_encoding no fue encontrado.';
    $Self->{Translation}->{"Setting server_encoding found, but it's set to"} = 'Configuración server_encoding, pero colocada con valor de ';
    $Self->{Translation}->{'(need to be UNICODE or UTF8).'} = '(necesita ser UNICODE o UTF8).';
    $Self->{Translation}->{'Server Connection (utf8)'} = 'Conexion del servidor (utf8)';
    $Self->{Translation}->{'Check the utf8 server connection.'} = 'Verifica la conexion utf8 del servidor';

    $Self->{Translation}->{'No client_encoding found.'} = 'No se encontro client_encoding';
    $Self->{Translation}->{"Setting client_encoding found, but it's set to"} = 'Se encontro client_encoding, pero con valor de';
    $Self->{Translation}->{'Client Connection (utf8)'} = 'Conexión del cliente (utf8)';
    $Self->{Translation}->{'Check the utf8 client connection.'} = 'Verifica la conexion utf8 del cliente.';

    $Self->{Translation}->{'No PostgreSQL version found.'} = 'No se encontro version de PostgreSQL';
    $Self->{Translation}->{'You use PostgreSQL version'} = 'Se esta utilizando PostgreSQL version';
    $Self->{Translation}->{'you should use 8.x or higner.'} = 'debe usar 8.x o superior';
    $Self->{Translation}->{'Unknown PostgreSQL version'} = 'Versión desconocida de PostgreSQL';

    # MSSQL
    $Self->{Translation}->{'Could not determine Microsoft SQL Server version.'} = 'No ha sido posible determinar una versión para Microsoft SQL Server';
    $Self->{Translation}->{'is'} = 'es';
    $Self->{Translation}->{'large, of which'} = 'de tamaño, del cual';
    $Self->{Translation}->{'is available.'} = 'se encuentra disponible.';
    $Self->{Translation}->{'Size'} = 'Tamaño';
    $Self->{Translation}->{'Check database size.'} = 'Verifica el tamaño de la base de datos.';

    $Self->{Translation}->{'Could not determine database hostname.'} = 'No fue posible determinar nombre del anfitrión para la base de datos.';
    $Self->{Translation}->{'DatabaseHost'} = 'Anfitrión para la base de datos';
    $Self->{Translation}->{'Hostname'} = 'Nombre del anfitrión';
    $Self->{Translation}->{'Check database hostname.'} = 'Verifica el nombre del anfitrión para la base de datos';
    $Self->{Translation}->{"Table doesn't exist"} = 'No existe la tabla';
    $Self->{Translation}->{'tables'} = 'tablas';

    # Oracle
    $Self->{Translation}->{'No ORACLE_HOME setting found.'} = 'La configuración ORACLE_HOME no fue encontrada';
    $Self->{Translation}->{"ORACLE_HOME don't exists"} = 'No existe ORACLE_HOME';
    $Self->{Translation}->{'Your ORACLE_Home configuration is'} = 'La configuración para ORACLE_HOME es';
    $Self->{Translation}->{'ORACLE_HOME'} = 'ORACLE_HOME';
    $Self->{Translation}->{'Check ORACLE_HOME configuration.'} = 'Verifica la configuración para ORACLE_HOME.';

    $Self->{Translation}->{'No NLS_LANG configuration found.'} = 'La configuración NLS_LANG no fue encontrada';
    $Self->{Translation}->{'need .utf8 in NLS_LANG (e. g. german_germany.utf8).'} = 'necesita .utf8 en NLS_LANG (ej. german_germany.utf8).';
    $Self->{Translation}->{'Your NLS_LANG configuration is'} = 'La configuración para NLS_LANG es';
    $Self->{Translation}->{'Check NLS_LANG.'} = 'Verifica NLS_LANG';

    $Self->{Translation}->{'No NLS_DATE_FORMAT setting found.'} = 'La configuración NLS_DATE_FORMAT no fue encontrada.';
    $Self->{Translation}->{"Need format 'YYYY-MM-DD HH24:MI:SS' for NLS_DATE_FORMAT (not"} = "Es necesario el formato 'YYYY-MM-DD HH24:MI:SS' para NLS_DATE_FORMAT (no";
    $Self->{Translation}->{'Your NLS_DATE_FORMAT setting is'} = 'La configuración para NLS_DATE_FORMAT es';
    $Self->{Translation}->{'Check NLS_DATE_FORMAT.'} = 'Verifica NLS_DATE_FORMAT';
    $Self->{Translation}->{'NLS_DATE_FORMAT seems to be wrong'} = 'El valor para NLS_DATE_FORMAT parece ser incorrecto';
    $Self->{Translation}->{"is not the right format 'yyyy-mm-dd hh:mm::ss' (please check"} = "no es el formato correcto 'yyyy-mm-dd hh:mm::ss' (por favor verifique";
    $Self->{Translation}->{'NLS_DATE_Format has the right format'} = 'NLS_DATE_Format tiene el formato correcto';
    $Self->{Translation}->{'Check NLS_DATE_FORMAT by using SELECT statement.'} = 'Verifica NLS_DATE_Format meidante el uso de una consulta SELECT';
    $Self->{Translation}->{"Table don't exists"} = 'La tabla no existe';

    # webserver
    $Self->{Translation}->{'Webserver'} = 'Servidor web';

    # apache
    $Self->{Translation}->{'You are running'} = 'Se encuentra ejecutando';
    $Self->{Translation}->{'Could not determine Apache version.'} = 'No ha sido posible determinar la versión de Apache';
    $Self->{Translation}->{'Apache Version'} = 'Versión de Apache';
    $Self->{Translation}->{'Display web server version.'} = 'Muestra la versión del servidor web';

    $Self->{Translation}->{'Apache::DBI should be used to get a better performance (pre-establish database connections).'} = 'Apache::DBI debe ser usado para obtener un mejor rendimiento (conexiones pre-establecidas a base de datos)';
    $Self->{Translation}->{'Check if the system uses Apache::DBI.'} = 'Verifica si el sistema utiliza Apache::DBI';

    $Self->{Translation}->{'Apache::Reload or Apache2::Reload should be used as PerlModule and PerlInitHandler to prevent web server restarts when installing and upgrading modules.'} = 'Apache::Reload or Apache2::Reload deben ser usados como PerlModule y PerlInitHandler para prevenir el reinicio del servidor al momento de instalar o actualizar modulos';
    $Self->{Translation}->{'Check if the system uses Apache::Reload/Apache2::Reload.'} = 'Verifica si el sistema utliza Apache::Reload/Apache2::Reload.';

    $Self->{Translation}->{'You use a beta version of mod_perl'} = 'Se encuentra utilizando una version preeliminar de mod_perl';
    $Self->{Translation}->{'you should upgrade to a stable version.'} = 'Debe actualizar a una versión estable';
    $Self->{Translation}->{'You should update mod_perl to'} = 'Debe actualizar mod_perl a';
    $Self->{Translation}->{'You are using FastCGI.'} = 'FastCGI se está utilizando';
    $Self->{Translation}->{'You should use FastCGI or mod_perl to increase your performance.'} = 'Debe usar FastCGI o mod_perl para incrementar el rendimiento.';
    $Self->{Translation}->{'CGI Accelerator'} = 'Acelerador CGI';
    $Self->{Translation}->{'Check for CGI Accelerator.'} = 'Verifica un acelerador CGI';

    # IIS
    $Self->{Translation}->{'PerlEx is in use'} = 'PerlEx se encuentra en uso';
    $Self->{Translation}->{'You should use PerlEx to increase your performance.'} = 'Debe usar PerlEx para incrementar el desempeño';
    $Self->{Translation}->{'Check if PerlEx is used.'} = 'Verifica si PerlEx esta en uso';

    # os
    $Self->{Translation}->{'OS'} = 'Sistema operativo';

    $Self->{Translation}->{'Distribution'} = 'Distribución';
    $Self->{Translation}->{'Shows the used distribution.'} = 'Muestra la distribución usada';
    $Self->{Translation}->{'is used.'} = 'esta en uso.';
    $Self->{Translation}->{'Distribution unknown.'} = 'Distribución desconocida';
    $Self->{Translation}->{'Can\'t determine distribution.'} = 'No es posible determinar la distribución';

    $Self->{Translation}->{'Kernel Version'} = 'Versión de Kernel';
    $Self->{Translation}->{'Shows the used Kernel version.'} = 'Muestra la versión del Kernel en uso';
    $Self->{Translation}->{'Can\'t execute uname -a...'} = 'No es posible ejecutar uname -a...';

    $Self->{Translation}->{'PerlCheck'} = 'Verificación Perl';
    $Self->{Translation}->{'Check Perl version.'} = 'Verifica la versión de Perl';
    $Self->{Translation}->{'Your Perl'} = 'La versión de Perl';
    $Self->{Translation}->{'is too old, you should upgrade to Perl 5.8.8 or higher.'} = 'es muy antigüa, debe actualizar a Perl 5.8.8 o superior';
    $Self->{Translation}->{'Unable to parse version string'} = 'No es posible analizar la cadena de versión';

    $Self->{Translation}->{'PerlModulesCheck'} = 'Verificación de los módulos Perl';
    $Self->{Translation}->{'Check Perl Modules installed.'} = 'Verificación módulos Perl instalados.';
    $Self->{Translation}->{'There is an error in your installed perl modules configuration. Please contact your administrator.'} = 'Existe un error en la configuración de los módulos Perl instalados. Por favor contacte a su administrador.';
    $Self->{Translation}->{'All Perl modules needed are currently installed.'} = 'Todos los modulos Perl necesarios se encuentran instalados.';
    $Self->{Translation}->{'Unable to check Perl modules.'} = 'No es posible verificar modulos Perl';

    $Self->{Translation}->{'The Host System has'} = 'El sistema anfitrión tiene';
    $Self->{Translation}->{'MB Memory total'} = 'MB memoria total';
    $Self->{Translation}->{'MB Memory free'} = 'MB memoria libre';
    $Self->{Translation}->{'MB Swap total'} = 'MB swap total';
    $Self->{Translation}->{'MB Swap free'} = 'MB swap libre';
    $Self->{Translation}->{'Memory Swap Check'} = 'Verifica la memoria de intercambio';
    $Self->{Translation}->{'A Memory Check. We try to find out if SwapFree : SwapTotal < 60 % or if more than 200 MB Swap is used.'} = 'Una verificación de memoria. Se trata de encontrar si la memoria de intercamibo libre es menor al 60% del total o si mas de 200 MB de memoria de intercambio estan en uso.';
    $Self->{Translation}->{'No Swap enabled!'} = '!No hay memoria de intercambio habilitada!';

    $Self->{Translation}->{'The Host System has a load'} = 'El sistema anfitrión ha cargado';
    $Self->{Translation}->{'in the last 1 minute'} = 'en el ultimo minuto';
    $Self->{Translation}->{'in the last 5 minutes'} = 'en los últimos 5 minutos';
    $Self->{Translation}->{'in the last 15 minutes'} = 'en los últimos 15 minutos';
    $Self->{Translation}->{'CPU Load'} = 'Carga de la UCP';
    $Self->{Translation}->{'A CPU load check. We try to find out if the system load in the last 15 minutes > 1.'} = 'Verificación de la carga de UCP. Se intenta verificar si el sistema ha cargado en los ultimos 15 minutos mas de 1 vez';
    $Self->{Translation}->{'A CPU load check. We try to find out if the system load in the last 15 minutes > 1.'} = 'Verificación de la carga de UCP. Se intenta verificar si el sistema ha cargado en los ultimos 15 minutos menos de 1 vez';

    $Self->{Translation}->{'Disk is full'} = 'Disco lleno';
    $Self->{Translation}->{'Disk usage'} = 'Uso de disco';
    $Self->{Translation}->{'Check disk usage.'} = 'Verifica uso de disco';

    # OTRS
    $Self->{Translation}->{'You have more error log entries: '} = 'Se tienen mas entradas de error';
    $Self->{Translation}->{'There is one error log entry: '} = 'Hay una entrada de error';
    $Self->{Translation}->{'LogCheck'} = 'Verificación de bitacora';
    $Self->{Translation}->{'Check log for error log entries.'} = 'Verifica la bitacora para entradas de error.';

    $Self->{Translation}->{'tickets in your system. You should use the StaticDB backend. See admin manual (Performance Tuning) for more information.'} =
        'ticket en el sistema. Se debe usar el modulo StaticDB. Vea el manual de administración (Ajustes de rendimiento) para mas información';
    $Self->{Translation}->{'You are using'} = 'Se esta usando';
    $Self->{Translation}->{"that's fine for"} = 'es correcto para';
    $Self->{Translation}->{'tickets in your system.'} = 'tickets en el sistema';
    $Self->{Translation}->{'Check Ticket::IndexModule setting.'} = 'Verifica la configuración Ticket::IndexModule.';

    $Self->{Translation}->{'tickets in StaticDB lock_index but you are using the'} = 'tickets en StaticDB lock_index pero se esta usando';
    $Self->{Translation}->{'index. Please run otrs/bin/otrs.CleanTicketIndex.pl to clean the StaticDB index.'} = 'indice. Por favor ejecute otrs/bin/otrs.CleanTicketIndex.pl para limpiar el indice StaticDB';
    $Self->{Translation}->{'tickets in StaticDB index but you are using the'} = 'tickets en el indice StaticDB pero se esta usando';
    $Self->{Translation}->{'Skipping test.'} = 'Omitiendo revisión';
    $Self->{Translation}->{'No orphaned records found.'} = 'No se encontraron entradas huerfanas';
    $Self->{Translation}->{'TicketStaticDBOrphanedRecords'} = 'TicketStaticDBOrphanedRecords';
    $Self->{Translation}->{'Check orphaned StaticDB records.'} = 'Verifica entradas huerfanas en StaticDB';

    $Self->{Translation}->{'articles in your system. You should use the StaticDB backend for OTRS 2.3 and higher. See admin manual (Performance Tuning) for more information.'} =
        'articulos en el sistema. Debe utilizar el modulo StaticDB para OTRS 2.3 y superior. Vea el manual de administración (Ajustes de rendimiento) para mas información.';
    $Self->{Translation}->{'articles in your system.'} = 'articulos en el sistema.';
    $Self->{Translation}->{'Check Ticket::SearchIndexModule setting.'} = 'Verifica la configuración Ticket::SearchIndexModule.';

    $Self->{Translation}->{'You should not have more than 8000 open tickets in your system. You currently have over 89999! In case you want to improve your performance, close not needed open tickets.'} =
        'No debe tener mas de 8000 tickets abiertos en el sistema. Se cuenta actualmente con mas de 89999! En caso de que quiera mejorar el rendimiento del sistema, cierre los tickets que no se necesiten.';
    $Self->{Translation}->{'You should not have over 8000 open tickets in your system. You currently have '} = 'No debe tener arriba de 8000 tickets abiertos en el sistema. Usted actualmente tiene';
    $Self->{Translation}->{'In case you want to improve your performance, close not needed open tickets.'} = 'En caso de que quiera mejorar el rendimiento, cierre los tickets que no se necesiten.';
    $Self->{Translation}->{'You should not have more than 8000 open tickets in your system. You currently have '} = 'No debe tener mas de 8000 tickets abiertos en el sistema. Usted actualmente tiene';
    $Self->{Translation}->{'You have '} = 'Se tienen';
    $Self->{Translation}->{' open tickets in your system.'} = ' tickets abiertos en el sistema.';
    $Self->{Translation}->{'OpenTicketCheck'} = 'OpenTicketCheck';
    $Self->{Translation}->{'Check open tickets in your system.'} = 'Verifica tickets abiertos en el sistema.';

    $Self->{Translation}->{'FQDNConfigCheck'} = 'FQDNConfigCheck';
    $Self->{Translation}->{'Check if the configured FQDN is valid.'} = 'Verifica si el FQDN configurado es valido.';
    $Self->{Translation}->{'Please configure your FQDN inside the SysConfig module. (currently the default setting'} = 'Por favor configure su FQDN dentro del modulo de configuración. (actualmente el valor por omision es';
    $Self->{Translation}->{'is enabled).'} = 'se encuentra habilitado.';
    $Self->{Translation}->{'Invalid FQDN'} = 'FQDN invalido.';
    $Self->{Translation}->{'looks good.'} = 'luce bien.';

    $Self->{Translation}->{'SystemIDConfigCheck'} = 'SystemIDConfigCheck';
    $Self->{Translation}->{'Check if the configured SystemID contains only digits.'} = 'Verifica si el SystemID configurado en el sistema contiene solo digitos.';
    $Self->{Translation}->{'Your SystemID setting is'} = 'El SystemID es';
    $Self->{Translation}->{'The SystemID'} = 'El SystemID';
    $Self->{Translation}->{'must consist of digits exclusively.'} = 'debe consistir de digitos exclusivamente.';

    $Self->{Translation}->{'ResponseFormatCheck'} = 'ResponseFormatCheck';
    $Self->{Translation}->{'Check if Ticket::Frontend::ResponseFormat contains no $Data{""}.'} = 'Verifica si Ticket::Frontend::ResponseFormat no contiene $Data{""}.';
    $Self->{Translation}->{'was not found.'} = 'no fue encontrado.';
    $Self->{Translation}->{'Config option Ticket::Frontend::ResponseFormat cointains'} = 'La opción de configuración Ticket::Frontend::ResponseFormat contiene';
    $Self->{Translation}->{'should be used instand (see default setting).'} = 'debe ser usado en su lugar (ver las opciones de configuración).';

    $Self->{Translation}->{'FileSystemCheck'} = 'FileSystemCheck';
    $Self->{Translation}->{'Check if file system is writable.'} = 'Verifica si el sistema de archivos tiene permisos de escritura';
    $Self->{Translation}->{'The file system is writable.'} = 'El sistema de archivos tiene permisos de escritura.';
    $Self->{Translation}->{'No such home directory'} = 'No es el directorio inicial';
    $Self->{Translation}->{"Can't write file"} = 'No se puede escribir en archivo';

    $Self->{Translation}->{'PackageDeployCheck'} = 'PackageDeployCheck';
    $Self->{Translation}->{'Check deployment of all packages.'} = 'Verifica la consistencia de todos los paquetes.';
    $Self->{Translation}->{'All packages are correctly installed.'} = 'Todos los paquetes estan correctamente instalados.';
    $Self->{Translation}->{'Packages not correctly installed'} = 'Paquetes incorrectamente instalados';

    $Self->{Translation}->{'InvalidUserLockedTicketSearch'} = 'InvalidUserLockedTicketSearch';
    $Self->{Translation}->{'Search for invalid user with locked tickets.'} = 'Busca usuarios invalidos con tickets bloqueados.';
    $Self->{Translation}->{'There are no invalid users with locked tickets.'} = 'No hay usuarios invalidos con tickets bloqueados.';
    $Self->{Translation}->{'These invalid users have locked tickets'} = 'Estos usuarios invalidos tienen ticket bloqueados';

    $Self->{Translation}->{'DefaultUserCheck'} = 'DefaultUserCheck';
    $Self->{Translation}->{'Check if root@localhost account has the default password.'} = 'Verifica si la cuenta root@localhost tiene la clave por omisión';
    $Self->{Translation}->{'There is no active root@localhost with default password.'} = 'La cuenta root@localhost on esta activa con la clave por omisión';
    $Self->{Translation}->{"Change the password or invalidate the account 'root\@localhost'."} = 'Modifique la clave o invalide la cuenta root\@localhost';

    $Self->{Translation}->{'SOAPCheck'} = 'SOAPCheck';
    $Self->{Translation}->{'Check default SOAP credentials.'} = 'Verifica los datos de  autentificación para SOAP.';
    $Self->{Translation}->{'You have not enabled SOAP or have set your own password.'} = 'No se encuentra habilitado SOAP o ha puesto su propia clave.';
    $Self->{Translation}->{'Please set a strong password for SOAP::Password in SysConfig.'} = 'Por favor ingrese una clave segura para SOAP::Password en la configuración.';

    $Self->{Translation}->{'Install directory'} = '';
    $Self->{Translation}->{'Product'} = 'Producto';
    $Self->{Translation}->{'Tickets'} = 'Ticket';
    $Self->{Translation}->{'Articles'} = 'Articulos';
    $Self->{Translation}->{'Agents'} = 'Agentes';
    $Self->{Translation}->{'Roles'} = 'Roles';
    $Self->{Translation}->{'Groups'} = 'Grupos';
    $Self->{Translation}->{'Articles per ticket (avg)'} = 'Articulos por ticket (promedio)';
    $Self->{Translation}->{'Operating system'} = 'Sistema Operativo';
    $Self->{Translation}->{'Months between first and last ticket'} = 'Meses entre el primer y ultimo ticket';
    $Self->{Translation}->{'Tickets per month (avg)'} = 'Ticket por mes (promedio)';
    $Self->{Translation}->{'Attachments per ticket (avg)'} = 'Promedio de archivos adjuntos por ticket (promedio)';
    $Self->{Translation}->{'Attachment size (avg)'} = 'Tamaño de archivo adjunto (promedio)';
    $Self->{Translation}->{'GeneralSystemOverview'} = 'GeneralSystemOverview';
    $Self->{Translation}->{'Display a general system overview'} = 'Muestra una vista general de sistema';
    $Self->{Translation}->{'General information about your system.'} = 'Información general del sistema.';

}

1;
