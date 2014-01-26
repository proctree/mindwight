#!/usr/bin/perl
use warnings;
use strict;

use File::Basename;
use Cwd;

use lib dirname(dirname(cwd()));
use Crypt::Tea;
use Exporter qw(import);

our @EXPORT_OK = qw(mindAdd);

sub mindAdd{
	die "Not enough arguments, stopped" unless @_>2;
	die "Too many arguments, stopped" unless @_<4;
	my ($name,$key,$pass) = @_;
	if(not(-e (cwd().'/db.mwc'))){
		system('touch '.cwd().'/db.mwc');
	}
	open my $mfo,">>",(cwd().'/db.mwc');
	print $mfo "$name\n".encrypt($pass,$key)."\n";
	close $mfo;
}

1;
