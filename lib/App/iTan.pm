# ================================================================
package App::iTan;
# ================================================================
use utf8;
use Moose;
use 5.0100;

extends qw(MooseX::App::Cmd);
with qw(MooseX::Getopt);

use vars qw($VERSION);
$VERSION = '1.00';

=head1 NAME 

App::iTan - Manage iTans for online banking

=head1 SYNOPSIS

 # Import a list of itans
 itan.pl import --file itanlist.txt
 # Fetch an itan and mark it as used
 itan.pl get --index 15 --memo "Electricity bill 07/2009"
 # List all itans
 itan.pl list

=head1 DESCRIPTION

This command line application facilitates the handling of iTANs (indexed
Transaction Numbers) as used by various online banking tools.

=head1 COMMANDS

=head2 import

TODO

=head2 get

TODO

=head2 info

TODO

=head2 list

TODO

=head2 reset

TODO

=head1 SUPPORT

Please report any bugs or feature requests to 
C<app-itan@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/Public/Bug/Report.html?Queue=App::iTan>.
I will be notified and then you'll automatically be notified of the progress 
on your report as I make changes.

=head1 AUTHOR

    Maroš Kollár
    CPAN ID: MAROS
    maros [at] k-1.com
    
    L<http://www.k-1.com>

=head1 COPYRIGHT

App::iTan is Copyright (c) 2009, Maroš Kollár 
- L<http://www.k-1.com>

This program is free software; you can redistribute it and/or modify it under 
the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut

1;
