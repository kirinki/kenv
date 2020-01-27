use 5.006;
use strict;
use warnings;
use Module::Build;
Module::Build->VERSION('0.4004');

my $builder = Module::Build->new(
	module_name			=> 'kirinki',
	license				=> 'artistic_2',
	dist_author			=> q{Pablo Alvarez de Sotomayor Posadillo <palvarez@ritho.net>},
	dist_version_from	=> 'lib/kirinki.pm',
	release_status		=> 'stable',
	configure_requires => {
		'Module::Build' => '0.4004',
	},
	test_requires => {
		'Test::More' => '0',
	},
	requires => {
		'Config::Tiny' => '2.24',
		'Switch' => '2.17',
	},
	add_to_cleanup	   => [ 'kirinki-*' ],
	script_files => ['kenv'],
	);

$builder->create_build_script();
