#!perl -T

use 5.006;
use strict;
use warnings;
use Test::More;

use kirinki::git;

plan tests => 2;

my $git = kirinki::git->new();

isnt($git, undef());
ok($git->init());

diag( "Testing kirinki::git $kirinki::git::VERSION, Perl $], $^X" );
