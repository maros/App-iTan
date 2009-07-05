# ================================================================
package App::iTan::Command::delete;
# ================================================================
use utf8;
use Moose;
use 5.0100;

extends qw(MooseX::App::Cmd::Command);
with qw(App::iTan::Utils);

sub run {
    my ($self) = @_;
    
    say 'All unused iTAN have been deleted';
    
    $self->dbh->do('DELETE FROM itan WHERE valid = 0 AND used IS NULL')
         or die "ERROR: Cannot execute: " . $self->dbh->errstr();
    
    return;
}

=head1 NAME 

App::iTan::Command::delete - Delete all invalid iTans

=head1 DESCRIPTION

=cut


1;