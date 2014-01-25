#!/usr/bin/perl
use warnings;
use strict;

use File::Basename;
use Cwd;

use lib dirname(cwd()).'/lib'; #pushes my lib directory into @INC
use Mind::Wight::Crypt; #i keep the encryption algorithm there to make the code less messy
use Getopt::Long;
