# Load the Module::Install bundled in ./inc/
use strict;
use inc::Module::Install;

my $from = 'lib/App/iTan.pm';

# Define metadata
name            'App-iTan';
all_from        $from;
readme_from     $from;
readme_markdown_from $from;

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
requires        'Crypt::Twofish'        => 0;
requires        'Term::ReadKey'         => 0;

build_requires  'File::Temp'            => 0;
build_requires  'Expect'                => 0;

#author_requires 'Test::Pod'             => '1.14';
#author_requires 'Test::Pod::Coverage'   => '1.04';
#author_requires 'Test::Perl::Critic'    => 0;
#author_requires 'Module::Install::ReadmeMarkdownFromPod'=> 0;
#author_requires 'Module::Install::ReadmeFromPod'        => 0;

if ($^O eq 'darwin') {
    recommends 'Mac::Pasteboard';
} else {
    recommends 'Clipboard';
}

install_script 'bin/itan';

repository 'git://github.com/maros/App-iTan.git';

WriteAll;
