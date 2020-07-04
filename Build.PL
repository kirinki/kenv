use 5.006;
use strict;
use warnings;
use Module::Build;
Module::Build->VERSION('0.4004');

my $class = Module::Build->subclass(
    class => "Module::Build::Custom",
    code => <<'SUBCLASS' );

sub ACTION_test {
    my $self = shift;
	open(FH, '>', 'MANIFEST.SKIP') or die $!;
	print FH "\\.github\n^MYMETA\\.yml\$\n^MYMETA\\.json\$\nMANIFEST\\.\nkirinki-\nblib\n_build\nBuild\n\\.git\n\\.gitignore\n";
	close(FH);
    $self->SUPER::ACTION_test;
}
SUBCLASS

my $builder = $class->new(
	module_name			=> 'kirinki::env',
	license				=> 'artistic_2',
	dist_author			=> q{Pablo Alvarez de Sotomayor Posadillo <palvarez@ritho.net>},
	dist_version_from	=> 'lib/kirinki/env.pm',
	release_status		=> 'stable',
	configure_requires => {
		'Module::Build' => '0.4004',
		'Module::Signature' => '0.83',
	},
	test_requires => {
		'Test::More' => '0',
		'Software::License' => '0',
		'Devel::Cover' => '1.36',
		'Test::Output' => '0',
	},
	requires => {
		'Config::Tiny' => '2.24',
		'Switch' => '2.17',
		'MIME::Base64' => '3.15',
	},
	add_to_cleanup	   => [ 'kirinki-*', '_build' ],
	script_files => ['kenv'],

	create_license => 1,
	);

$builder->add_build_element('SKIP');

$builder->create_build_script();
