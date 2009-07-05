# ================================================================
package App::iTan::Command::get;
# ================================================================
use utf8;
use Moose;
use 5.0100;

extends qw(MooseX::App::Cmd::Command);
with qw(App::iTan::Utils);

has 'next' => (
    is      => 'ro',
    isa     => 'Bool',
    documentation => q[Get the next available iTan],
);

has 'index' => (
    is      => 'ro',
    isa     => 'Int',
    documentation => q[iTan index number that should be fetched],
);

has 'lowerinvalid' => (
    is      => 'ro',
    isa     => 'Bool',
    documentation => q[Mark all iTans with a lower index as invalid (only in combination with --index)],
);

has 'memo' => (
    is      => 'ro',
    isa     => 'Str',
    documentation => q[Optional memo for the iTan usage],
);

sub run {
    my ($self) = @_;
    
    if ($self->next) {
        my ($index) = $self->dbh->selectrow_array("SELECT tindex FROM itan WHERE used IS NULL AND valid = 1 ORDER BY tindex LIMIT 1");
       
        unless (defined $index) {
            say 'No more iTan left';
        } else {
            my $tan_data = $self->get($index);
            my $itan = $self->_decrypt_string($tan_data->{itan});
            say 'iTAN '.$index.' marked as used';
            say 'iTAN '.$itan;
            $self->mark($index,$self->memo);
        }
    } elsif ($self->index) {
        my $tan_data = $self->get($self->index);
        my $itan = $self->_decrypt_string($tan_data->{itan});
        say 'iTAN '.$self->index.' marked as used';
        say 'iTAN '.$itan;
        $self->mark($self->index,$self->memo);
        if ($self->lowerinvalid) {
            $self->dbh->do('UPDATE itan SET valid = 0 WHERE tindex < '.$self->index)
                 or die "ERROR: Cannot execute: " . $self->dbh->errstr();
        }
    } else {
        say 'Option --index or --next must be set';
    }
    return;
}

=head1 NAME 

App::iTan::Command::get - Fetch a single iTan and mark is as used

=head1 DESCRIPTION

=cut

1;