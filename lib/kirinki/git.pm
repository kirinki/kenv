package kirinki::git;

use 5.006;
use strict;
use warnings;

=head1 NAME

kirinki::git - Git interface for the kirinki command line.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

This module is an interface to run the git related commands for the kirinki
environment.

You can start using it with:

    use kirinki::git;

    my $foo = kirinki::git->new();
    ...

=head1 SUBROUTINES/METHODS

=head2 new

=cut

sub new {
	my $class = shift;
	my $self = {
	};

	bless $self, $class;

	return $self;
}

=head2 init

=cut

sub init {
	return 1;
}

=head1 AUTHOR

Pablo Alvarez de Sotomayor Posadillo, C<< <palvarez at ritho.net> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-. at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/NoAuth/ReportBug.html?Queue=.>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc kirinki::git


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

=head1 LICENSE AND COPYRIGHT

This software is Copyright (c) 2020 by Pablo Alvarez de Sotomayor Posadillo.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut

1; # End of kirinki::git
