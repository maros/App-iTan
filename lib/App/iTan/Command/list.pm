# ================================================================
package App::iTan::Command::list;
# ================================================================
use utf8;
use Moose;
use 5.0100;

our $VERSION = $App::iTan::VERSION;

extends qw(MooseX::App::Cmd::Command);
with qw(App::iTan::Utils);

use Text::Table;

sub execute {
    my ( $self, $opts, $args ) = @_;
    
    my $tb = $self->get_table();
    
    print $tb->title;
    print $tb->rule('-','+');
    print $tb->body;
    
    return;
}

sub get_table {
    my ($self) = @_;
    
    my $sth = $self->dbh->prepare("SELECT tindex,imported,used,memo FROM itan WHERE valid = 1 OR used IS NOT NULL ORDER BY imported")
        or die "ERROR: Cannot prepare: " . $self->dbh->errstr();
    $sth->execute();
        
    my $tb = Text::Table->new(
        "Index",\"|","Imported",\"|","Used",\"|","Memo"
    );
  
    while (my @line = $sth->fetchrow_array) {
        $tb->add(@line);
    }
    
    return $tb;
}

__PACKAGE__->meta->make_immutable;

=head1 NAME 

App::iTan::Command::list - List all available and used itans

=head1 DESCRIPTION

See L<App::iTan> for detailed documentation

=cut

1;