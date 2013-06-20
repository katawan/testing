#!/usr/bin/perl
use Time::Local;
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

my $pwd='pwd';

##############################
# Ignoramos trap




while (1) {

	##############################################
	##############################################
	# Shell Prompt 
	##############################################
	##############################################
	
	print "\npresione ? o help para comenzar\n";
	print "\e[01;33mCli [main] >\e[00m ";
	$command = <STDIN>;

	##############################################
	##############################################
	# List available commands
	##############################################
	##############################################

if ($command =~ /^ *\? *$/ ) {
	print "\ndirectorio > \t es el encargado de sacar la cantidad de directorios que tiene un determinado path\n";
	print "\ncantidad > \t es el encargado de sacar la cantidad de archivos en un directorio \n";
	print "\ntotaldirectorio > \t es el que saca la cantidad de direcotrios anteriormente obtenidos\n";
}
if ($command =~ /^ *help *$/ ) {
	print "\ndirectorio > \t es el encargado de sacar la cantidad de directorios que tiene un determinado path\n";
	print "\ncantidad > \t es el encargado de sacar la cantidad de archivos en un directorio \n";
	print "\ntotaldirectorio > \t es el que saca la cantidad de direcotrios anteriormente obtenidos\n";
        print "\n";
}


elsif ($command =~ /^ *directorio *$/) {
	print "\ingrese el directorio que necesita pesar ete valor tiene que ser absoluto\n";
		print "\e[01;33mCli [main] >\e[00m ";
	$path = <STDIN>;
		chomp ($path);
	print "\ninicio\n";
	my $grep; 
			$grep .= "ls -ltR ".$path;
            $grep .= "| grep \"\.\/\" | awk '\{ print \$1}' FS=:";
			$grep .= "> registro.txt";
print $grep."\n";
system ($grep);

print "\ntermino\n" ;

}


elsif ($command =~ /^ *cantidad *$/) {
	
my $peso;
	$peso = "cat registro.txt | xarg -i wc -l \{\} > peso.txt";
system ($peso);

           
}
elsif ($command =~ /^ *totaldirectorio *$/) {
	
my $directorio;
	$directorio = "wc -l registro.txt ";
system ($directorio);
           
}




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

##############################################
# SHOW 
##############################################
##############################################
else { print "Command not found\n"; }
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
