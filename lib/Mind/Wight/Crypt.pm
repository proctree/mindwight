#!/usr/bin/perl
use warnings;
use strict;

use File::Basename;
use Cwd;

use lib dirname(dirname(cwd()));
use Crypt::Tea;
use Exporter qw(import);

our @EXPORT_OK = qw(mindAdd);

my @mina=();
my %mint=();

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

sub loadMind{
	if(-e(cwd().'/db.mwc')){
		open my $mfi,"<",(cwd().'/db.mwc');
		while(<$mfi>){
			chomp;
			my $hname=$_;
			my $hhash=<$mfi>;
			chomp $hhash;
			$mint{$hname}=$hhash;
			push @mina,$hname;
		}
		close $mfi;
	}
	else{
		system('touch '.cwd().'/db.mwc');
	}
}

sub mindGet{
	die "Not enough arguments, stopped" unless @_>1;
	die "Too many arguments, stopped" unless @_<3;
	loadMind();
	my ($name,$key) = @_;
	my $rpass = decrypt($mint{$name},$key) or die "Name not found, stopped";
	print "$rpass\n";
}

sub mindSearch{
	die "Not enough arguments, stopped" unless @_>0;
	die "Too many arguments, stopped", unless @_<2;
	loadMind();
	my ($sterm)=@_;
	for(my $i=0;$i<@mina;$i++){
		if($mina[$i]=~m/\Q$sterm/){
			print "$mina[$i]\n";
		}
	}
}

sub mindList{
	loadMind();
	for(my $i=0;$i<@mina;$i++){
		print "$mina[$i]\n";
	}
}

1;
