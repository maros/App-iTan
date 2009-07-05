# -*- perl -*-

# t/01_import.t -- check import

use Test::More skip_all => 'TODO';

#use Test::More tests => 7;

use App::iTan;
use File::Temp qw(tempdir);

my $tempfile = tempfile(
    'test_app_itan_XXXX',
    CLEANUP => 1,
);

my $perlinterpreter = 'TODO';
my $modulepath = 'TODO';
my $bin = 'bin/itan.pl';

`$perlinterpreter -I $modulepath $bin import --database $tempfile`;