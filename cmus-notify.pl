#!/usr/bin/perl

sub read_config {
	my $opts = shift;
	my $fh;
	open($fh, "<", "$ENV{HOME}/.config/cmus/notify.cfg")
		|| open($fh, "<", "/usr/share/cmus/notify.cfg")
		|| die "can't open config file\n";
	while (chomp(my $line = <$fh>)) { 
		@$opts = split(/ /, $line);
	}
	return $opts;
}

sub markup {
	my ($m, $val) = @_;
	return "<$m>$val</$m>" if (length($m) == 1);
	my @char = split(//, $m);
	my $str;
	foreach (@char) { $str .= "<" . $_ . ">" }
	foreach (reverse(@char)) { $str .= "</". $_ . ">" }
	$str =~ s/><\//>$val<\//;
	open (my $fh, ">>", "/tmp/cmus_err.log");
	print $fh $str;
	return $str;
}

sub escape_html {
	my $str = shift;
	$str =~ s/&(?!amp;)/&amp;/g;
	$str =~ s/(<|>)//g;
	return $str;
}

sub normalize_time {
	my $s = shift;
	my @u = ($s/3600, $s%3600/60, $s%60);
	my $time;
	open(my $fh, ">", \$time);
	$s/3600 >= 1 ? 
		printf $fh "%.2i:%.2i:%.2i", $u[0], $u[1], $u[2] 
		: printf $fh "%.2i:%.2i", $u[1], $u[2];
	return $time;
}

sub main {
	my %playing = (
		status => undef,
		file => undef,
		artist => undef,
		album => undef,
		title => undef,
		duration => undef,
		tracknumber => undef,
		date => undef,
	);
	my %fmtd = %playing;

	for my $key (sort keys %playing) {
		for my $i (0 .. $#ARGV) {
			if ($ARGV[$i] =~ m/$key/) {
				$playing{$key} = $ARGV[++$i];
#				simple string sanitization
				$fmtd{$key} = escape_html($playing{$key});
				last;
			}
		}
	}

#	some user-friendly formatting
	$fmtd{status} = ucfirst($playing{status});
	$fmtd{duration} = normalize_time($playing{duration})
		if $playing{duration};

#	read user config file and apply markup if needed
	my @opts;
	my $out;
	read_config(\@opts);

	foreach (@opts) {
		unless ($fmtd{$_}) {
			if ($_ =~ m/^[biu]{1,3}:/) {
				my ($m, $str) = split /:/;
				$out .= markup($m, $fmtd{$str}) . "\n"
					if $fmtd{$str};
			}
		}
		$out .= $fmtd{$_} . "\n" if $fmtd{$_};
	}

#	print filename if cmus sends no other values,
#	or if config options malformed
	$out = $fmtd{file} unless $out;

#	prepend status, which is always provided
	$out = $fmtd{status} . "\n" . $out;
	print $out;
}

main();
