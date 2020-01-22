#!perl -T

use 5.006;
use strict;
use warnings;
use Test::More;

use kirinki::config;

plan tests => 15;

my $config = kirinki::config->new();

ok($config->set('Test', 1));
ok($config->get('Test') == 1);
ok(length($config->str) > 0);
ok($config->delete('Test'));
ok($config->exists('Test') == 0);

ok($config->set('level1.level2', 1));
ok($config->get('level1.level2') == 1);
ok(length($config->str) > 0);
ok($config->delete('level1.level2'));
ok($config->exists('level1.level2') == 0);

ok($config->set('level1.level2.level3', 1));
ok($config->get('level1.level2.level3') == 1);
ok(length($config->str) > 0);
ok($config->delete('level1.level2.level3'));
ok($config->exists('level1.level2.level3') == 0);

# ok($config->load());
# ok($config->set('level1.level2.level3', 1));
# ok($config->get('level1.level2.level3') == 1);
# ok($config->save());
# ok($config->delete('level1.level2.level3'));
# ok($config->exists('level1.level2.level3') == 0);
# ok($config->save());
# ok($config->load());
# ok($config->exists('level1.level2.level3') == 0);

diag( "Testing kirinki config" );
