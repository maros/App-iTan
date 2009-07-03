# -*- perl -*-

# t/01_load.t - check module loading and create testing directory

use Test::More tests => 7;

use_ok( 'App::iTan' );
use_ok( 'App::iTan::Utils' );
use_ok( 'App::iTan::Command::get' );
use_ok( 'App::iTan::Command::import' );
use_ok( 'App::iTan::Command::info' );
use_ok( 'App::iTan::Command::list' );
use_ok( 'App::iTan::Command::reset' );