
#base ls  -lRas   | grep "\.\/" 
#
#
#
#
#

   print "\e[01;33mCli [main] >\e[00m ";
	$command = <STDIN>;



if ($command =~ /^ *\? *$/ ) {
        print "\e[00;31mStatus dominios Tie \e[00m \n";
        print "UTILIDADES \n";
        print "\e[00;31m validacion\e[00m  \t\t=> validacion de dominios segun archivo dominios/dominios.cvs\n";
        print "\e[00;31m validaciondns\e[00m  \t\t=> validacion de dns segun archivo  dominios/dominios.cvs \n";
        print "\e[00;31m dominios \e[00m  \t\t=> validacion de  un dominio \n";
}




 

elsif ($command =~ /^ *validacion *$/) {
print "hola";
system ("ls  -lRas  * | grep \"\.\/\" > registro.txt ");

print "chao" ;

}



