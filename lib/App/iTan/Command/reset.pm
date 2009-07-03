# ================================================================
package App::iTan::Command::reset;
# ================================================================
use utf8;
use Moose;
use 5.0100;

extends qw(MooseX::App::Cmd::Command);
with qw(App::iTan::Utils);

has 'delete' => (
    is      => 'ro',
    isa     => 'Bool',
    documentation => q[Delete all unused iTans instead of just marking them as invalid],
);

sub run {
    my ($self) = @_;
    
    say 'All iTAN have been marked as invalid';
    
    if ($self->delete) {
        $self->dbh->do('DELETE FROM itan WHERE valid = 1 AND used IS NULL')
             or die "ERROR: Cannot execute: " . $self->dbh->errstr();
    } else {
        $self->dbh->do('UPDATE itan SET valid = 0')
             or die "ERROR: Cannot execute: " . $self->dbh->errstr();
    }
    
    return;
}

=head1 NAME 

App::iTan::Command::reset - Mark all unused tans as invalid

=head1 DESCRIPTION

=cut


1;