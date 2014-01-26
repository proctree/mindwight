#!/usr/bin/perl
use warnings;
use strict;

use File::Basename;
use Cwd;

use lib dirname(cwd()).'/lib'; #pushes my lib directory into @INC
use Mind::Wight::Crypt; #i keep the encryption algorithm there to make the code less messy
use Getopt::Long;

sub usage(){
	#these options are pretty lazely done and described
	#I'll change the descriptions later
	print "Usage: perl $0 [--list|--remove name|--search search_term|--add <-n name -k key -p password>|--get -n name -k key]\n";
	print "--list or -l: lists all known passwords by their name\n";
	print "--remove or -r: removes a password from the password safe\n";
	print "--search or -s: searches for a password by it's name\n";
	print "--add or -a: adds a new password to the safe\n";
	print " 	--name or -n: the name of the password(eg. \"yahoo acc\")\n";
	print "		--key or -k: the key used for the encryption of the password\n";
	print "		--password or -p: the password itself\n";
	print "--get or -g: gets the password itself\n";
}

my @auxarg=@ARGV; #i copy the argv array into another array so i can still have access to it
		  #after getoptions is done with it
my $arghelp = ''; #-h or --help
my $argadd = ''; #-a or --add
my $argname = ''; #-n or --name
my $argkey = ''; #-k or --key
my $argpassword = ''; #-p or --password
my $arglist = '';
my $argget = '';

GetOptions('help' => \$arghelp,
	   'add' => \$argadd,
	   'name:s' => \$argname,
	   'key:s' => \$argkey,
	   'password:s' => \$argpassword,
	   'list' => \$arglist,
	   'get' => \$argget
);

if($arghelp eq 1 or @auxarg==0){ #--help
	usage();
	exit;
}
elsif($argadd eq 1){ #--add
	die "Not enough arguments for mode --add, stopped" unless $argname ne '' and $argkey ne '' and $argpassword ne ''; #check that all of the arguments are specified
	mindAdd($argname,$argkey,$argpassword); #mindAdd is in Mind::Wight::Crypt
	exit;
}
elsif($arglist eq 1){
	mindList();
	exit;
}
elsif($argget eq 1){
	die "Not enough arguments for mode --get, stopped" unless $argname ne '' and $argkey ne '';
	mindGet($argname,$argkey);
	exit;
}
