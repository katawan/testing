sub readini(){

        my $file = shift;
        my %hash;

        if (!(-e $file) || !(-r $file)){

                &print_message('ERROR', "No se puede leer el archivo de configuracion: '$file'.");
                $error_readini = 1;
                return undef;
        }

        open(FH, "< $file");
        while(<FH>){

                my $line = $_;
                next if ($line =~ /^\s*[#;]/); # Omite los comentarios

                if ($line =~ /^\s*\[\s*(.*)\s*\]\s*$/){

                        $head = $1;
                        $has_head = 1;
                }
                elsif ($has_head && ($line =~ /^\s*([a-z0-9-_]+)\s*=\s*(.*)\s*$/i)){

                        $hash{$head}{lc($1)} = $2;
                }
        }
        close(FH);

        return %hash;
}

sub print_message{
        print sprintf("%.4d-%.2d-%.2d %.2d:%.2d:%.2d ", Today_and_Now()).'[' . (shift) . '] ' . (shift) . "\n" if ($debug eq 'on');
}

1;
