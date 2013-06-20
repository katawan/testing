use Net::IP;
use strict;
#use warnings;
my $host;

foreach my $arg (@ARGV){
        $host = $2 if ($arg =~ /-(-host|h)=(.*)/);
}
#----------------------------------
#----------------------------------
if ($host eq ''){
        print "ERROR: Debe ingresar el Host!.\n" if $host eq '';
        exit;
}

# snmpwalk -c public -v 2c 172.31.30.53   1.3.6.1.4.1.789.1.3.1.3.1.1.1

print "| ";
my @netapp=`snmpwalk -c public -v 2c $host  1.3.6.1.4.1.789.1.3.1.3.1.1.1 | cut -d" " -f4`;
my $lineas=`snmpwalk -c public -v 2c $host  1.3.6.1.4.1.789.1.3.1.3.1.1.1  |  cut -d" " -f4 | wc -l`;
#print "\n";
#$lineas--;
#print $lineas;
for (my $i=1; $i<$lineas; $i++) {
	my $host2 = @netapp[$i];

#print "host:".@netapp[$i];
#print "<numero de I> ";
#print $i;
#print "  <n-->";
chop ($host2);

#print $host2;
#print "<n>";
		my @values = split('\.', $host2);
		my $valor0 = @values[0];
		chomp ($valor0);
		print $valor0;
#		print "_";
		my $valor1 = @values[1];
		chomp ($valor1);
		print $valor1;
#		print "_";
		my $valor2 = @values[2];
		chomp ($valor2);
		print $valor2;
#		print "_";
		my $valor3 = @values[3];
		chomp ($valor3);
		print $valor3;
	#chop ($host2);
	my $exec1  = `snmpwalk -c public -v 2c $host  1.3.6.1.4.1.789.1.3.1.3.1.1.49.$host2 | cut -d" " -f4`;
	chop  ($exec1);
	print "=".$exec1." ";
#print "\n";
}
