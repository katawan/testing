#!/usr/bin/perl
use Time::Local;
use DBI;
#use Net::SSH::Expect;
#use MIME::Base64;
use Class::Date qw( now );
require 'shared_resource/readini.pm';
my $configFile = 'config/settings.ini'; #Archivo de configuracion .INI
my %config = readini($configFile);


# Copyright (c)
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
# 

if (!($dbh = DBI->connect('DBI:'.$config{database}{type}.':'.$config{database}{db_name}.':'.$config{database}{host}.':'.$config{database}{port},$config{database}{user},$config{database}{password}))){
#if (!($dbh = DBI->connect('DBI:'.$config{database}{type}.':'.$config{database}{port},$config{database}{user},$config{database}{password}))){
        print "No se pudo conectar a la base de datos: $! $@\n";
        exit;
}

my $pwd='pwd';
my $command2;
my $bbdd;
##############################
# Ignoramos trap


$SIG{INT} = 'IGNORE';
$SIG{HUP} = 'IGNORE';
$SIG{TSTP} = 'IGNORE';
$SIG{ALRM} = 'IGNORE';
##############################

&title;
while (1) {
	##############################################
	##############################################
	# Shell Prompt 
	##############################################
	##############################################

	print "\e[01;33mCli [main] >\e[00m ";
	$command = <STDIN>;

	##############################################
	##############################################
	# List available commands
	##############################################
	##############################################

if ($command =~ /^ *\? *$/ ) {
	print "\e[00;31mBabkup de bbdd  \e[00m \n";
	print "UTILIDADES \n";
	print "\e[00;31m backup\e[00m  \t\t=> Opcion para ver las  bbdd que tienen en su sistema \n";
	print "\e[00;31m List backup\e[00m  \t\t=> Opcion para ver las  bbdd que tienen en su sistema \n";
	print "\e[00;31m status \e[00m  \t\t=> Opcion para ver las  bbdd que tienen en su sistema \n";
}

#'.$config{database}{host}.'
elsif ($command =~ /^ *start *\? *$/) {
	print "Start options:\n";
	print "\n";
}


##############################################
#  Exit temp commands 
##############################################

elsif ($command =~ /^ *(exit|quit|q) *$/) {
	exit 1;
}
elsif ($command =~ /^ *(clear) *$/) {
	&title;
}
# comando para enter
elsif ($command =~ /^ *(\n) *$/) {
	# print "\n";
}
	elsif ($command =~ /^ *list *$/) {
	$SIG{INT} = ''; # Habilita CTRL+C
	my $ary = $dbh->selectall_arrayref('show databases');
	print "="x30,"\n";
		for ( @$ary ) {
			my ( $base )= @$_;
			print "   $base\n";
			#               system ( "nohup perl instalar.pl --host=".$host_ip." > instalar.out & ".$enter);
		}
	print "="x30,"\n";
	$SIG{INT} = 'IGNORE'; # Deshabilita CTRL+C
}
elsif ($command =~ /^ *restore *$/) {
	$SIG{INT} = ''; # Habilita CTRL+C
	print "listado de backups";
	system("ls -las ".$config{path}{prefix_ftp}." | grep mysql_ | awk '{print \$10}' ");
	print "bbdd del sistema ";
	my $ary = $dbh->selectall_arrayref('show databases');
	print "="x30,"\n";
		for ( @$ary ) {
			my ( $base )= @$_;
			print "	 $base\n";
		}
	print "="x30,"\n";
	print "\e[01;33m Restore de la bbdd  de BBDD \e[00m \n";
	print "\e[01;33m INGRESE EL BACKUP QUE NECESITA \e[00m \n";
	print "\e[01;33mCli [backup] >\e[00m ";
	$command2 = <STDIN>;
	print "\e[01;33m Restore de la bbdd  de BBDD \e[00m \n";
	print "\e[01;33m INGRESE LA BBDD QUE NECESITA RESTAURAR \e[00m \n";
	print "\e[01;33mCli [backup] >\e[00m ";
	$basedatos = <STDIN>;
 		if ($command2 =~ /^ *+([a-zA-Z\_\-0-9\:\.]+) *$/ ) {
			chomp ($command2);
			chomp ($basedatos);
    			system ( "mysql -h ".$config{database}{host}." -u ".$config{database}{user}." -p".$config{database}{password}." ".$basedatos." \< ".$config{path}{prefix_ftp},$command2);
			print "LA CARGA DE LA BBDD HA FINALIZADO ";
			$bbdd=$command2;
		}
}

elsif ($command =~ /^ *list +backup *$/) {
	print "\e[01;33m List backup: \e[00m\n";
	print $command2;
	system("ls -las ".$config{path}{prefix_ftp}." | grep mysql_ | awk '{print \$10}' ");
	#system("echo ls -las ".$config{path}{prefix_ftp}." \| grep mysql_".$command2."_dump_");
}
elsif ($command =~ /^ *status *$/) {
	my $ary = $dbh->selectall_arrayref('SHOW FULL PROCESSLIST');
	print "="x30,"\n";
		for ( @$ary ) {
			my ( $base )= @$_;
			print "   $base\n";
		}
			print "="x30,"\n";
}
##############################################
# SHOW 
##############################################
##############################################
# show network established
#	elsif ($command =~ /^ *show +network +established *$/) {
#	&logs;
#                system("netstat -nt");
#	
#        }

	# comando para arrancar los MS telefonica
        # 
#	# zenoss	
else { print "Command not found\n"; }
}


sub title {
	system("clear");
	print "\n";
	print "Command Line Interface \n";
	print "\n";
}

#sub logs {
#	open(FILEHANDLE, ">>/var/log/cli/main.log") or die 'cannot open file!';  
#	#print FILEHANDLE "$time: $command";
#	print FILEHANDLE &local_ymd.&minutos.": $command";
#	close(FILEHANDLE);
#}
sub local_ymd {
	my ($year,$month,$day) = (localtime(time))[5,4,3];
	my $ymd = sprintf("%04d:%02d:%02d",$year+1900,$month+1,$day);
	return $ymd;
}
sub minutos {

	my $time = time;	# or any other epoch timestamp 
	my @months = ("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
	my ($sec, $min, $hour, $day,$month,$year) = (localtime($time))[0,1,2,3,4,5]; 
	# You can use 'gmtime' for GMT/UTC dates instead of 'localtime'
	my $hora = sprintf(" ".$hour.":".$min.":".$sec." ");
	return $hora;
}
sub user {
	my $perfil ; 
	$perfil =  system("$USER");
	return $perfil; 
}

sub ping {
	my $host; 
	my $return = system ("fping".$host);

}


print "resultado: ";
foreach my $res (@{$ref_resultado})
{ 
	print "$res\t"; 
}
print "\n";
sub log_syslog {
 setlogsock("udp");

}
