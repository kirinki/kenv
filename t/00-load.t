#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 2;

BEGIN {
	use_ok( 'kirinki' ) || print "Kirinki bailed out!\n";
	use_ok( 'kirinki::config' ) || print "Kirinki::config bailed out!\n";
}

diag( "Testing kirinki $kirinki::VERSION, Perl $], $^X" );
