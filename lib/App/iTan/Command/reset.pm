# ================================================================
package App::iTan::Command::reset;
# ================================================================
use utf8;
use Moose;
use 5.0100;

our $VERSION = $App::iTan::VERSION;

extends qw(MooseX::App::Cmd::Command);
with qw(App::iTan::Utils);

sub execute {
    my ( $self, $opts, $args ) = @_;
    
    say 'All unused iTAN have been marked as invalid';
    
    $self->dbh->do('UPDATE itan SET valid = 0')
         or die "ERROR: Cannot execute: " . $self->dbh->errstr();
    
    return;
}

__PACKAGE__->meta->make_immutable;

=head1 NAME 

App::iTan::Command::reset - Mark all unused tans as invalid

=head1 DESCRIPTION

See L<App::iTan> for detailed documentation

=cut


1;