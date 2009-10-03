# ================================================================
package App::iTan;
# ================================================================
use utf8;
use Moose;
use 5.0100;

extends qw(MooseX::App::Cmd);
with qw(MooseX::Getopt);

use version;
our $VERSION = version->new('1.00');
our $AUTHORITY = 'cpan:MAROS';

__PACKAGE__->meta->make_immutable;

=head1 NAME 

App::iTan - Secure management of iTans for online banking from

=head1 SYNOPSIS

 # Import a list of itans
 console$ itan import --file itanlist.txt

 # Fetch an itan and mark it as used (after
 console$ itan get --index 15 --memo "paid rent 09/2009"

 # List all itans
 console$ itan list

=head1 DESCRIPTION

This command line application facilitates the secure handling of iTANs 
(indexed Transaction Numbers) as used by various online banking tools. 

iTANs are encrypted using L<Crypt::Twofish> and are by default stored 
in a SQLite database located at ~/.itan. (Patches for other database
vendors welcome)

=head1 COMMANDS

=head2 import

Imports a list of iTans into the database. 

 itan import --file IMPORT_FILE [--deletefile] [--overwrite]

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

Option to delete the import file after a successful import

=item * overwrite 

Index numbers must be unique. Default behaviour is to skip duplicate iTan
indices. When this flag is enabled the duplicate iTans will be overwritten.

=back

=head2 get

Fetches an iTan an mark it as used

 itan get [--next] OR [--index INDEX [--lowerinactive]]  [--memo MEMO]

You will be prompted a password to decrypt the selected iTan.

=over

=item * next

Fetches the next available iTan

=item * index

Fetches the iTan with the given index

=item * lowerinvalid

Marks all iTans lower than --index as invalid (Only in conjunction with
--index).

=item * memo

Optional memo on iTan usage

=back

=head2 info

Returns information on the given iTan.

 itan info --index INDEX

You will be promted a password to decrypt the selected iTan.

=over

=item * index

Fetches the iTan with the given index

=back

=head2 list

List of all either used or still available iTans

 itan list

=head2 reset

Mark all unused iTans as invalid

=head2 delete

Delete all invalid iTans

=head2 help

 itan help 
 itan help COMMAND

Display help text.

=head2 commands

 itan commands 

Display a list of all available commands

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

=head1 COPYRIGHT & LICENSE

App::iTan is Copyright (c) 2009, Maroš Kollár 
- L<http://www.k-1.com>

This program is free software; you can redistribute it and/or modify it under 
the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut

1;
