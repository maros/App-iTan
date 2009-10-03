# ================================================================
package App::iTan::Command::delete;
# ================================================================
use utf8;
use Moose;
use 5.0100;

our $VERSION = $App::iTan::VERSION;

extends qw(MooseX::App::Cmd::Command);
with qw(App::iTan::Utils);

sub execute {
    my ( $self, $opts, $args ) = @_;
    
    say 'All unused iTAN have been deleted';
    
    $self->dbh->do('DELETE FROM itan WHERE valid = 0 AND used IS NULL')
         or die "ERROR: Cannot execute: " . $self->dbh->errstr();
    
    return;
}

__PACKAGE__->meta->make_immutable;

=head1 NAME 

App::iTan::Command::delete - Delete all invalid iTans

=head1 DESCRIPTION

See L<App::iTan> for detailed documentation

=cut


1;