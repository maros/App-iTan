# ================================================================
package App::iTan::Command::get;
# ================================================================
use utf8;
use Moose;
use 5.0100;

our $VERSION = $App::iTan::VERSION;

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

sub execute {
    my ( $self, $opts, $args ) = @_;
    
    my $index;
    if ($self->next) {
        ($index) = $self->dbh->selectrow_array("SELECT tindex FROM itan WHERE used IS NULL AND valid = 1 ORDER BY tindex LIMIT 1");
       
        unless (defined $index) {
            say 'No more iTan left';
            return;
        }
    } else {
        $index = $self->index;
    }
    
    unless ($index) {
        say 'Option --index or --next must be set';
    } else {
        my $tan_data = $self->get($index);
        my $itan = $self->_decrypt_string($tan_data->{itan});
        say 'iTAN '.$index.' marked as used';
        say 'iTAN '.$itan;
        
        eval {
            if ($^O eq 'darwin') {
                Class::MOP::load_class('Mac::Pasteboard');
                my $pb = Mac::Pasteboard->new();
                $pb->clear;
                $pb->copy($itan);
            } else {
                Class::MOP::load_class('Clipboard');
                Clipboard->copy($itan);
            }
            say 'iTan has been coppied to the clipboard';
        };
        
        $self->mark($index,$self->memo);
        if ($self->lowerinvalid) {
            $self->dbh->do('UPDATE itan SET valid = 0 WHERE tindex < '.$index)
                 or die "ERROR: Cannot execute: " . $self->dbh->errstr();
        }
    }
    
    return;
}

__PACKAGE__->meta->make_immutable;

=head1 NAME 

App::iTan::Command::get - Fetch a single iTan and mark is as used

=head1 DESCRIPTION

See L<App::iTan> for detailed documentation

=cut

1;