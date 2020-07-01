package kirinki::env;

use 5.006;
use strict;
use warnings;
use Switch;

use kirinki::env::config;

=head1 NAME

kirinki::env - Kirinki environment manager.

=head1 VERSION

Version 0.03

=cut

our $VERSION = '0.03';


=head1 SYNOPSIS

This module implements several commands to manage the kirinki environment,
including creating a new repository, cloning a repo from a server, do commits
on one or several projects, build, run and test one or several projects, ...

You can start using it with:

    use kirinki::env;

    my $foo = env->new();
    ...

=head1 SUBROUTINES/METHODS

=head2 new

Create a new env object.

=cut

sub new {
	my $class = shift;
	my $self = {
		config => kirinki::env::config->new()
	};

	bless $self, $class;

	$self->{'config'}->init();

	return $self;
}

=head2 config

Handle the config command.

=cut

sub config {
	my $self = shift;
	my $action = shift;
	my @params = @_;

	switch($action) {
		case "init" {
			$self->{'config'}->init();
			$self->{'config'}->initOptionals();
		}
		case "list" {
			print $self->{'config'}->str();
		}
		case "set" {
			my $key = shift @params;
			my $value = shift @params;
			unless (defined($key) && defined($value)) {
				die "Missing parameters\n";
			}

			if (@params > 0) {
				print "Ignoring the parameters @params\n";
			}

			die "Unable to save $key\n"
				unless $self->{'config'}->set($key, $value);
			$self->{'config'}->save();
		}
		case "unset" {
			my $key = shift @params;
			unless (defined($key)) {
				die "Missing parameters\n";
			}

			if (@params > 0) {
				print "Ignoring the parameters @params\n";
			}

			die "Unable to delete $key\n"
				unless $self->{'config'}->delete($key);
			$self->{'config'}->save();
		}
		case "clean" {
			$self->{'config'}->clean();
			$self->{'config'}->save();
		}
		else {
			if (defined $action) {
				print "Unknown action $action.\n";
			} else {
				print "Missing action.\n";
			}

			print "Possible actions:
\t* list: List all the configurations.
\t* set: Add/modify a configuration.
\t* unset: Remove a configuration.
\t* clean: Remove all the configurations.\n";
		}
	}
}

=head2 cmd

Handle the kirinki env commands

=cut

sub cmd {
	my $self = shift;
	my $cmd = shift;
	my @arguments = @_;

	switch($cmd) {
		case "config" {
			$self->config(@arguments);
		}
		else {
			if (defined $cmd) {
				print "Unknown argument $cmd\n";
			} else {
				print "Show help";
			}
		}
	}
}

=head1 AUTHOR

Pablo Alvarez de Sotomayor Posadillo, C<< <palvarez at ritho.net> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-kirinki at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/NoAuth/ReportBug.html?Queue=kirinki>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc kirinki::env


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

1; # End of kirinki::env
