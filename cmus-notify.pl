#!/usr/bin/perl

use HTML::Entities qw(encode_entities);

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

#	read user config file and apply markup if needed
	my @opts;
	my $out;
	read_config(\@opts);

	my $nomarkup = 1 if join(" ", @opts) =~ m/nomarkup/;	

	for my $key (sort keys %playing) {
		for my $i (0 .. $#ARGV) {
			if ($ARGV[$i] =~ m/$key/) {
				$playing{$key} = $ARGV[++$i];
				$fmtd{$key} = $playing{$key};
				last;
			}
		}
	}

#	some user-friendly formatting
	$fmtd{status} = ucfirst($playing{status});
	$fmtd{duration} = normalize_time($playing{duration})
		if $playing{duration};

	foreach (@opts) {
		if ($nomarkup) {
			$_ =~ s/^.*://;
			$out .= $fmtd{$_} . "\n" if $fmtd{$_};
		}
		else {
			if ($_ =~ m/^[biu]{1,3}:/) {
				my ($m, $str) = split /:/;
				$out .= markup($m, encode_entities($fmtd{$str}, '<>&"\047'))
					. "\n" if $fmtd{$str};
			}
			else { 
				$out .= encode_entities($fmtd{$_}, '<>&"\047')
					. "\n" if $fmtd{$_};
			}
		}
	}

#	print filename if cmus sends no other values,
#	or if config options malformed
	$out = $fmtd{file} unless $out;

#	prepend status, which is always provided
	$out = $fmtd{status} . "\n" . $out;
	print $out;
}

main();
