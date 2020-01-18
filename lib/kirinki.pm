package kirinki;

use 5.006;
use strict;
use warnings;

use kirinki::config;

=head1 NAME

kirinki - Kirinki environment manager.

=head1 VERSION

Version 0.02

=cut

our $VERSION = '0.02';


=head1 SYNOPSIS

This module implements several commands to manage the kirinki environment,
including creating a new repository in a github organization, cloning a repo
from github, do commits on one or several projects, build, run and test one
or several projects, ...

You can start using it with:

    use kirinki;

    my $foo = kirinki->new();
    ...

=head1 EXPORT

A list of functions that can be exported. You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 new

Create a new Kirinki object.

=cut

sub new {
	my $class = shift;
	my $self = {
		config => kirinki::config->new()
	};

	bless $self, $class;

	return $self;
}

=head2 init

The init function initialize the kirinki environment configuration, guessing
the values as much as possible.

=cut

sub init {
}

=head1 AUTHOR

Pablo Alvarez de Sotomayor Posadillo, C<< <palvarez at ritho.net> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-kirinki at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/NoAuth/ReportBug.html?Queue=kirinki>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc kirinki


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<https://rt.cpan.org/NoAuth/Bugs.html?Dist=kirinki>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/kirinki>

=item * CPAN Ratings

L<https://cpanratings.perl.org/d/kirinki>

=item * Search CPAN

L<https://metacpan.org/release/kirinki>

=back


=head1 LICENSE AND COPYRIGHT

This software is Copyright (c) 2020 by Pablo Alvarez de Sotomayor Posadillo.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)


=cut

1; # End of kirinki
