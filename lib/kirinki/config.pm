package kirinki::config;

use 5.006;
use strict;
use warnings;

=head1 NAME

kirinki::config - Manage the configurations of the kirinki command.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


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
	my $self = {
		location => $ENV{"HOME"} . '/.config/kirinki',
		filename => 'kirinkirc',
		data => {},
	};

	bless $self, $class;

	$self->load();

	return $self;
}

=head2 load

Load the configurations from the configuration file.

=cut

sub load {
	my $self = shift;

	unless ( -d $self->{'location'} ) {
		print 'Creating directory ' . $self->{'location'} . "...\n";
		mkdir $self->{'location'}, 0755;
	}

	my $configFile = $self->{'location'} . '/' . $self->{'filename'};
	unless ( -e $configFile ) {
		print "Generating config file ${configFile}...\n";
		open(my $fh, '>', $configFile)
			or die "Could not open file '$configFile' $!";
		print $fh "[general]\n";
		close $fh;
	}
}

=head2 save

Save the configurations to the configuration file.

=cut

sub save {
	my $self = shift;
}

=head2 get

Get a configuration value.

=cut

sub get {
	my $self = shift;
}

=head2 set

Set a configuration value.

=cut

sub set {
	my $self = shift;
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
