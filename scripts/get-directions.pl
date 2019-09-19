#!/usr/bin/perl -w

use API;
# use API::API;
# use API::SourceManager;

# use API::Source::MapsGoogleAPIs::Directions;

use Data::Dumper;

my $apimanager = API->new();

my $api = $apimanager->GetAPI(API => 'MapsGoogleAPIs/Directions');


my $res1 = $api->Directions
  (
   Origin => $ARGV[0],
   Destination=> $ARGV[1],
   Mode => 'transit',
   # departure_time,
   # arrival_time,
   Overwrite => 1,
  );
print Dumper({Res1 => $res1});
