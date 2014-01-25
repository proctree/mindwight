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
	print "Usage: perl $0 [--list|--remove name|--search search_term|--add <-n name -s salt -p password>|--get -n name -s salt]\n";
	print "--list or -l: lists all known passwords by their name\n";
	print "--remove or -r: removes a password from the password safe\n";
	print "--search or -s: searches for a password by it's name\n";
	print "--add or -a: adds a new password to the safe\n";
	print " 	--name or -n: the name of the password(eg. \"yahoo acc\")\n";
	print "		--salt or -s: the salt used for the encryption of the password\n";
	print "		--password or -p: the password itself\n";
	print "--get or -g: gets the password itself\n";
}

my @auxarg=@ARGV; #i copy the argv array into another array so i can still have access to it
		  #after getoptions is done with it
my $arghelp = ''; #-h or --help
GetOptions('h|help' => \$arghelp);

if($arghelp eq 1 or @auxarg==0){
	usage();
	exit;
}
