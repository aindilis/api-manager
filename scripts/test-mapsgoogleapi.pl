#!/usr/bin/perl -w

use API;
# use API::API;
# use API::SourceManager;

use Data::Dumper;

my $apimanager = API->new();

# API::Source::MapsGoogleAPIs::Place

my $api = $apimanager->GetAPI(API => 'MapsGoogleAPIs/Place');


my $res1 = $api->PlaceSearch
  (
   Overwrite => 1,
   Input => '3404 Sherwood Dr., Flint, MI 48503',
  );
print Dumper({Res1 => $res1});

# $api = $apimanager->GetAPI(API => 'MapsGoogleAPIs/Place');

my $res2 = $api->PlaceDetails
  (
   Overwrite => 1,
   PlaceID => 'ChIJ2aggpYWCI4gRvfhofFGCsOw', # $res1->{candidates}[0]{place_id},$res1->{place_id},
  );
print Dumper({Res2 => $res2});
