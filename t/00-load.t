#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'kirinki' ) || print "Bail out!\n";
}

diag( "Testing kirinki $kirinki::VERSION, Perl $], $^X" );
