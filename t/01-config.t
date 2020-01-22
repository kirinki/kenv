#!perl -T

use 5.006;
use strict;
use warnings;
use Test::More;

use kirinki::config;

plan tests => 20;

my $config = kirinki::config->new();
$config->{'filepath'} = '/tmp/test.ini';
$config->load();

is($config->set('Test', 0), undef);
is($config->get('Test'), undef);
ok(length($config->str()) == 0);
ok($config->exists('Test') == 0);

ok($config->set('level1.level2', 1));
ok($config->get('level1.level2') == 1);
ok(length($config->str()) > 0);
ok($config->delete('level1.level2'));
ok($config->exists('level1.level2') == 0);

ok($config->set('level1.level2.level3', 1));
ok($config->get('level1.level2.level3') == 1);
ok(length($config->str()) > 0);
ok($config->delete('level1.level2.level3'));
ok($config->exists('level1.level2.level3') == 0);

$config->load();
ok($config->set('level1.level2.level3', 1));
ok($config->get('level1.level2.level3') == 1);
$config->save();
$config->load();
ok($config->exists('level1.level2.level3') == 1);
ok($config->delete('level1.level2.level3'));
ok($config->exists('level1.level2.level3') == 0);
$config->save();
$config->load();
ok($config->exists('level1.level2.level3') == 0);

diag( "Testing kirinki config" );
