#!/usr/bin/perl -w

use API;
# use API::API;
# use API::SourceManager;

use Data::Dumper;

my $apimanager = API->new();

my $api = $apimanager->GetAPI(API => 'OTRecorderAPI/Last');

my $res1 = $api->Last
  (
   Host => '127.0.0.1',
   Port => '8083',
   Username => 'aindilis',
   Device => 'lv7',
  );
print Dumper({Res1 => $res1});

my $res2 = $api->Locations
  (
   Host => '127.0.0.1',
   Port => '8083',
   Username => 'aindilis',
   Device => 'lv7',
>  );
print Dumper({Res2 => $res2});
