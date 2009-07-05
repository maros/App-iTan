# ================================================================
package App::iTan;
# ================================================================
use utf8;
use Moose;
use 5.0100;

extends qw(MooseX::App::Cmd);
with qw(MooseX::Getopt);

use version;
use vars qw($VERSION);
$VERSION = version->new('0.9000_01');

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

Imports a list of iTans into the database. 

 itan.pl import --file IMPORT_FILE [--deletefile] [--overwrite]

=over

=item * file

Path to a file containing the iTans to be imported. The file must contain
two columns (separated by any non numeric characters). The first 
column must be the index number. The second column must be the tan 
number. If your online banking appication does not use index numbers just set
the first column to zero.

 10 434167
 11 937102
 OR
 0 320791
 0 823602

=item * deletefile

Delete import file after a successful import

=item * overwrite 

Index numbers must be unique. Default behaviour is to skip duplicate iTan
indices. When this flag is enabled the duplicate iTans will be overwritten.

=back

=head2 get

Fetches an iTan an marks it as used

 itan.pl get [--next] OR [--index INDEX [--lowerinactive]]  [--memo MEMO]

=over

=item * next

Fetches the next available iTan

=item * index

Fetches the iTan with the given index

=item * lowerinvalid

Marks all iTans lower than --index as invalid (Only in conjunction with
--index).

=item * memo

Memo on iTan usage

=back

=head2 info

Returns information on the given iTan.

 itan.pl info --index INDEX
 
=over

=item * index

Fetches the iTan with the given index

=back

=head2 list

List of all either used or still available iTans

 itan.pl list

=head2 reset

Mark all unused iTans as invalid

=head2 delete

Delete all invalid iTans

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
