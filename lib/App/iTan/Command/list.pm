# ================================================================
package App::iTan::Command::list;
# ================================================================
use utf8;
use Moose;
use 5.0100;

our $VERSION = $App::iTan::VERSION;

use Text::Table;
use Moose::Util::TypeConstraints;

extends qw(MooseX::App::Cmd::Command);
with qw(App::iTan::Utils);

our @SORTFIELDS = qw(tindex imported used);

has 'sort' => (
    is            => 'ro',
    isa           => enum(\@SORTFIELDS),
    required      => 1,
    default       => $SORTFIELDS[0],
    documentation => q[Sort field (].(join ',',@SORTFIELDS).q[)],
);

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
    
    my $sort = $self->sort;
    $sort .= ','.$SORTFIELDS[0]
        unless $SORTFIELDS[0] ~~ $sort;
    my $sth = $self->dbh->prepare("SELECT tindex,imported,used,memo 
        FROM itan 
        WHERE valid = 1 OR used IS NOT NULL 
        ORDER BY $sort")
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
1;