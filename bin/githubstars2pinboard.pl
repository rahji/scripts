#!/usr/bin/perl

# get github stars for github user --ghuser
# and add them to the pinboard for user --pbuser
# requires wget
# note that github api only allows up to 100 items per page,
# hence the combination of --pagenum and --perpage

use strict;
use warnings;
use JSON::Parse 'parse_json';
use Getopt::Long;
use WWW::Pinboard;

our $wget = '/usr/bin/wget';

my $pagenum = 1;
my $perpage = 1;
my $ghuser  = "";
my $pbtoken = "";
my $result = GetOptions(
  "pagenum=i"  => \$pagenum,
  "perpage=i"  => \$perpage,
  "ghuser=s"   => \$ghuser,
  "pbtoken=s"  => \$pbtoken
);

die("error: pagenum is not a number\n") unless $pagenum =~ /^\d+$/;
die("error: perpage is not a number\n") unless $perpage =~ /^\d+$/;
die("error: ghuser seems off\n") unless $ghuser =~ /^\S+$/;
die("error: no pbtoken specified\n") unless $pbtoken;

my $api = WWW::Pinboard->new(token => $pbtoken);

my $cmd = "$wget --quiet -O - 'https://api.github.com/users/$ghuser/starred?per_page=$perpage&page=$pagenum'";
my $json = `$cmd`;
die("Got nothing from the API request ($cmd)\n") unless $json =~ /\S/;

my $perl = parse_json($json);

my $counter = 1;
foreach my $star (@$perl) {
  my %post = %{ $api->add( 
    url => $star->{'html_url'},
    description => $star->{'full_name'},
    extended => $star->{'description'},
    tags => 'github',
    replace => 'no'
    ) 
  };
  printf("%03d/%03d ", $counter++, $perpage);
  if ($post{'result_code'} eq "done") { print "[ADDED]  " }
  elsif ($post{'result_code'} eq "item already exists") { print "[EXISTS] " }
  print $star->{'full_name'} . "\n";
  sleep(5);
}
