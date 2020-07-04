#!perl -T

use 5.006;
use strict;
use warnings;
use Test::More;
use Test::Output;

use kirinki::env;

plan tests => 18;

open(FH, '>', '/tmp/test');

print FH "/tmp/development\n";
print FH "n\n";
close(FH);

local *STDIN;
open(STDIN, '<', '/tmp/test');
my $env = kirinki::env->new('/tmp', 'test.env');

print "\n";

# Check the configurations.
ok($env->{'config'}->set('level1.level2', 1));
ok($env->{'config'}->get('level1.level2') == 1);
ok(length($env->{'config'}->str()) > 0);
ok($env->{'config'}->delete('level1.level2'));
ok($env->{'config'}->exists('level1.level2') == 0);

# Test the config function.
stdout_is(sub {$env->config('')}, "Unknown action .\nPossible actions:\n\t* list: List all the configurations.\n\t* set: Add/modify a configuration.\n\t* unset: Remove a configuration.\n\t* clean: Remove all the configurations.\n", 'ok');
stdout_is(sub {$env->config('list')}, "general.basedir = /tmp/development\n", 'ok');

is($env->config('set'), undef);
is($env->config('set', 'level2.level1'), undef);
$env->config('set', 'level2.level1', 1);
stdout_is(sub {$env->config('list')}, "general.basedir = /tmp/development\nlevel2.level1 = 1\n", 'ok');
$env->config('unset', 'level2.level1');
stdout_is(sub {$env->config('list')}, "general.basedir = /tmp/development\n", 'ok');
$env->config('clean');
stdout_is(sub {$env->config('list')}, "", 'ok');
stdout_is(sub {$env->config('unknown')}, "Unknown action unknown.\nPossible actions:\n\t* list: List all the configurations.\n\t* set: Add/modify a configuration.\n\t* unset: Remove a configuration.\n\t* clean: Remove all the configurations.\n", 'ok');
stdout_is(sub {$env->config()}, "Missing action.\nPossible actions:\n\t* list: List all the configurations.\n\t* set: Add/modify a configuration.\n\t* unset: Remove a configuration.\n\t* clean: Remove all the configurations.\n", 'ok');

close(STDIN);
open(STDIN, '<', '/tmp/test');

$env->config('init');
print "\n";
print "\n";
stdout_is(sub {$env->config('list')}, "general.basedir = /tmp/development\n", 'ok');

print "\n";

# Check the cmd function.
stdout_is(sub {$env->cmd('config', 'list')}, "general.basedir = /tmp/development\n", 'ok');
stdout_is(sub {$env->cmd('unknown')}, "Unknown argument unknown\n", 'ok');
stdout_is(sub {$env->cmd()}, "Show help", 'ok');
close(STDIN);

unlink '/tmp/test';
unlink '/tmp/test.env';

diag( "Testing kirinki::env $kirinki::env::VERSION, Perl $], $^X" );
