# Load the Module::Install bundled in ./inc/
use strict;
use inc::Module::Install;

# Define metadata
name            'App-iTan';
all_from        'lib/App/iTan.pm';

perl_version    '5.010';

# Specific dependencies
requires        'DBI'                   => 0;
requires        'DBD::SQLite'           => 0;
requires        'DateTime'              => 0;
requires        'Moose'                 => 0;
requires        'MooseX::Getopt'        => 0;
requires        'MooseX::App::Cmd'      => 0;
requires        'Params::Coerce'        => 0;
requires        'Path::Class'           => 0;
requires        'Text::Table'           => 0;
build_requires  'Test::NoWarnings'      => 0;

repository 'git://github.com/maros/App-iTan.git';

WriteAll;