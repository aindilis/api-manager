#!/usr/bin/perl -w

use API;
# use API::API;
# use API::SourceManager;

use Data::Dumper;

my $apimanager = API->new();

my $api = $apimanager->GetAPI(API => 'MapsGoogleAPIs/Place');


my $res1 = $api->PlaceSearch
  (
   Input => $ARGV[0],
  );
print Dumper({Res1 => $res1});


my $res2 = $api->PlaceDetails
  (
   PlaceID => $res1->{candidates}[0]{place_id},$res1->{place_id},
  );
print Dumper({Res2 => $res2});
