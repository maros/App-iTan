# ================================================================
package App::iTan::Command::import;
# ================================================================
use utf8;
use Moose;
use 5.0100;

our $VERSION = $App::iTan::VERSION;

extends qw(MooseX::App::Cmd::Command);
with qw(App::iTan::Utils);

has 'file' => (
    is            => 'ro',
    isa           => 'File',
    required      => 1,
    coerce        => 1,
    documentation => q[File with one iTan per line that should be imported],
);

has 'deletefile' => (
    is      => 'ro',
    isa     => 'Bool',
    default => 0,
    documentation => q[Delete import file after a successfull import],
);

has 'overwrite' => (
    is      => 'ro',
    isa     => 'Bool',
    default => 0,
    documentation => q[Overwrite duplicate index numbers],
);


sub execute {
    my ( $self, $opts, $args ) = @_;
    
    my @itans = $self->file->slurp(chomp => 1)
        or die ('Cannot read file '.$self->file->stringify);

    my $date = $self->_date();

    say "Start importing iTan ...";

    my $sth = $self->dbh->prepare("INSERT INTO itan (tindex,itan,imported,valid,used,memo) VALUES (?,?,'$date',1,NULL,NULL)")
        or die "ERROR: Cannot prepare: " . $self->dbh->errstr();
    
    foreach my $line (@itans) {
        my ($index,$tan);
        unless ($line =~ m/^(?<index>\d{1,4})\D+(?<tan>\d{4,8})$/) {
            say "... did not import '$line' (could not parse)";
        } else {
            $index = $+{index};
            $tan   = $self->_crypt_string( $+{tan} );
            if ($index eq '0') {
                my $nextindex = $self->dbh->selectrow_array("SELECT MAX(tindex) FROM itan WHERE valid = 1");
                $nextindex ++;
                $index = $nextindex;
            }
            eval {
                $self->get($index);
            };
            if ($@) {
                say "... import $index";
                $sth->execute($index,$tan)
                     or die "Cannot execute: " . $sth->errstr();
            } elsif ($self->overwrite) {
                $self->dbh->do('UPDATE itan SET valid = 0 WHERE tindex = '.$index)
                    or die "ERROR: Cannot execute: " . $self->dbh->errstr();
                say "... import $index (overwrite old index)";
                $sth->execute($index,$tan)
                     or die "Cannot execute: " . $sth->errstr();
            } else {
                say "... did not import $index (duplicate index)";
            }
        }
    }
    $sth->finish();
    
    if ($self->deletefile) {
        $self->file->remove();
    }
    
    return;
}

__PACKAGE__->meta->make_immutable;

=head1 NAME 

App::iTan::Command::import - Import a set of itans

=head1 DESCRIPTION

See L<App::iTan> for detailed documentation

=cut

1;
