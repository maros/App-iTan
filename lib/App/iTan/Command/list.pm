# ================================================================
package App::iTan::Command::list;
# ================================================================
use utf8;
use Moose;
use 5.0100;

extends qw(MooseX::App::Cmd::Command);
with qw(App::iTan::Utils);

use Text::Table;

sub run {
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

    print $tb->title;
    print $tb->rule('-','+');
    print $tb->body;
    
    return;
}

=head1 NAME 

App::iTan::Command::list - List all available and used itans

=head1 DESCRIPTION

=cut

1;