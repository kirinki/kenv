package kirinki::config;

use 5.006;
use strict;
use warnings;

use Config::Tiny;
use Scalar::Util qw/reftype/;

=head1 NAME

kirinki::config - Manage the configurations of the kirinki command.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.02';


=head1 SYNOPSIS

The module kirinki::config handles all the configurations for the kirinki
command, parsing the configuration file, serving the configurations and
saving the changes.

You can start using it with:

    use kirinki::config;

    my $foo = kirinki::config->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 new

Create a new configuration object.

=cut

sub new {
	my $class = shift;
	my $cfgDir = shift;
	my $cfgFile = shift;

	$cfgDir = $ENV{"HOME"} . '/.config/kirinki' unless defined $cfgDir;
	$cfgFile = 'kirinkirc' unless defined $cfgFile;

	my $self = {
		location => $cfgDir,
		filename => 'kirinkirc',
		filepath => $cfgDir . '/' . $cfgFile,
		data => Config::Tiny->new(),
	};

	bless $self, $class;

	$self->load();

	return $self;
}

=head2 init

Initialize all the configurations.

=cut

sub init {
	my $self = shift;

	my @mandatory = qw/general.basedir/;
	my @optional = qw/github.user github.password/;

	$self->load();
	for my $cfg (@mandatory) {
		$self->initConfig($cfg) unless ($self->exists($cfg));
	}

	my %ask;
	for my $cfg (@optional) {
		unless ($self->exists($cfg)) {
			my @keys = $self->getKeys($cfg);
			unless (exists($ask{$keys[0]})) {
				print 'Do you want to configure ' . $keys[0] . '? (Y/n) ';
				chomp(my $answer = <STDIN>);
				$ask{$keys[0]} = ($answer =~ /(^[nN])/)
			}

			$self->initConfig($cfg) unless ($ask{$keys[0]});
		}
	}
}

=head2 initConfig

Initialize a specific configuration.

=cut

sub initConfig {
	my $self = shift;
	my $cfg = shift;

	return $cfg unless defined $cfg;

	my $value = $self->configInput($cfg);
	die "Unable to save $cfg\n"
		unless $self->set($cfg, $value);
	$self->save();
}

=head2 configInput

Read a configuration value from the user input.

=cut

sub configInput {
	my $self = shift;
	my $cfg = shift;

	return $cfg unless defined $cfg;

	print "Please introduce $cfg: ";
	chomp(my $out = <STDIN>);

	return $out;
}

=head2 checkConfigFile

Checks that the config file is fine.

=cut

sub checkConfigFile {
	my $self = shift;

	unless ( -d $self->{'location'} ) {
		print 'Creating directory ' . $self->{'location'} . "...\n";
		mkdir $self->{'location'}, 0755;
	}

	unless ( -e $self->{'filepath'} ) {
		print 'Generating config file ' . $self->{'filepath'} . "...\n";
		open(my $fh, '>', $self->{'filepath'})
			or die 'Could not open file ' . $self->{'filepath'} . " $!";
		print $fh "[general]\n";
		close $fh;
	}
}

=head2 getKeys

Get a list of keys to look in the configuration.

=cut

sub getKeys {
	my $self = shift;
	my $config = shift;

	my @splitted = split /\./, $config;
	if (@splitted > 2) {
		my $last = @splitted - 2;
		@splitted = (join('.', @splitted[0..$last]), $splitted[-1]);
	}

	return @splitted;
}

=head2 load

Load the configurations from the configuration file.

=cut

sub load {
	my $self = shift;

	$self->checkConfigFile();
	$self->{'data'} = Config::Tiny->read($self->{'filepath'}, 'utf8');
	if (Config::Tiny->errstr) {
		die 'Unable to read from the config file: ' . Config::Tiny->errstr() .
			"\n";
	}
}

=head2 save

Save the configurations to the configuration file.

=cut

sub save {
	my $self = shift;

	my $written = $self->{'data'}->write($self->{'filepath'}, 'utf8');
	if (Config::Tiny->errstr) {
		die 'Unable to write the config file: ' . Config::Tiny->errstr() .
			"\n";
	}
}

=head2 get

Get a configuration value.

=cut

sub get {
	my $self = shift;
	my $config = shift;

	unless (defined $config) {
		return undef();
	}

	my $level = $self->{'data'};
	my @configs = $self->getKeys($config);
	foreach my $cfg (@configs) {
		if (defined $level->{$cfg}) {
			$level = $level->{$cfg};
		} else {
			return undef();
		}
	}

	if ($level =~ /;/) {
		return split(/;/, $level);
	}

	return $level;
}

=head2 set

Set a configuration value.

=cut

sub set {
	my $self = shift;
	my $config = shift;
	my $value = shift;

	unless (defined $config && defined $value) {
		return undef();
	}

	my $level = $self->{'data'};
	my @configs = $self->getKeys($config);
	if (@configs < 2) {
		return undef();
	}

	my $i = 0;
	foreach my $cfg (@configs) {
		if ($i == $#configs) {
			my $type = ref $value;
			if ($type && reftype $value eq reftype []) {
				$level->{$cfg} = join(';', @$value);
			} else {
				$level->{$cfg} = $value;
			}
		} else {
			unless (defined $level->{$cfg}) {
				if ($i == $#configs) {
					$level->{$cfg} = $value;
				} else {
					$level->{$cfg} = {};
				}
			}

			$level = $level->{$cfg};
		}

		$i++;
	}

	return 1;
}

=head2 exists

Checks if a configuration exists.

=cut

sub exists {
	my $self = shift;
	my $config = shift;

	unless (defined $config) {
		return 0;
	}

	my $level = $self->{'data'};
	my @configs = $self->getKeys($config);
	foreach my $cfg (@configs) {
		if (defined $level->{$cfg}) {
			$level = $level->{$cfg};
		} else {
			return 0;
		}
	}

	return 1;
}

=head2 delete

Deletes a configuration.

=cut

sub delete {
	my $self = shift;
	my $config = shift;

	unless (defined $config) {
		return 0;
	}

	my $level = $self->{'data'};
	my @configs = $self->getKeys($config);
	my $i = 0;
	foreach my $cfg (@configs) {
		unless (defined $level->{$cfg}) {
			return 0;
		}

		if ($i == $#configs) {
			delete $level->{$cfg};
		} else {
			$level = $level->{$cfg};
		}

		$i++;
	}

	return 1;
}

=head2 clean

Cleans all the config data.

=cut

sub clean {
	my $self = shift;

	$self->{'data'} = Config::Tiny->new();
}

=head2 str

Returns all the configurations in string.

=cut

sub str {
	my $self = shift;
	my $configs = shift;
	my $parent = shift;

	unless (defined $configs) {
		$configs = $self->{'data'};
	}

	unless (defined $parent) {
		$parent = '';
	}

	my $res = "";
	foreach my $cfg (keys %$configs) {
		my $type = ref $configs->{$cfg};
		if ($type && reftype $configs->{$cfg} eq reftype {}) {
			my $newParent = $parent;
			if ($newParent) {
				$newParent .= '.';
			}

			$newParent .= "$cfg";
			my $str = $self->str($configs->{$cfg}, $newParent);
			if (length($str) > 0) {
				$res .= $str;
			}
		} else {
			$res .= "$parent.$cfg = " . $configs->{$cfg} . "\n";
		}
	}

	return $res;
}

=head1 AUTHOR

Pablo Alvarez de Sotomayor Posadillo, C<< <palvarez at ritho.net> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-. at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/NoAuth/ReportBug.html?Queue=.>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc kirinki::config


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<https://rt.cpan.org/NoAuth/Bugs.html?Dist=.>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/.>

=item * CPAN Ratings

L<https://cpanratings.perl.org/d/.>

=item * Search CPAN

L<https://metacpan.org/release/.>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

This software is Copyright (c) 2020 by Pablo Alvarez de Sotomayor Posadillo.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)


=cut

1; # End of kirinki::config
