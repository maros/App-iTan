# ================================================================
package App::iTan::Command::info;
# ================================================================
use utf8;
use Moose;
use 5.0100;

our $VERSION = $App::iTan::VERSION;

extends qw(MooseX::App::Cmd::Command);
with qw(App::iTan::Utils);

has 'index' => (
    is            => 'ro',
    isa           => 'Int',
    required      => 1,
    documentation => q[iTan index number that should be fetched],
);

use Text::Table;

sub execute {
    my ( $self, $opts, $args ) = @_;

    my $sth
        = $self->dbh->prepare(
        'SELECT tindex,valid,itan,imported,used,memo FROM itan WHERE tindex = ?'
        ) or die "ERROR: Cannot prepare: " . $self->dbh->errstr();
    $sth->execute( $self->index )
        or die "ERROR: Cannot execute: " . $sth->errstr();

    my $tb = Text::Table->new(
        "Index",    \"|", "Valid", \"|", "Tan", \"|",
        "Imported", \"|", "Used",  \"|", "Memo"
    );

    while ( my $tan_data = $sth->fetchrow_hashref() ) {

        $tb->add(
            $tan_data->{tindex},
            $tan_data->{valid},
            $self->decrypt_string( $tan_data->{itan} ),
            $tan_data->{imported},
            $tan_data->{used},
            $tan_data->{memo} );
    }

    print $tb->title;
    print $tb->rule( '-', '+' );
    print $tb->body;
    
    return;
}

__PACKAGE__->meta->make_immutable;
1;
