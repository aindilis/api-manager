#!/usr/bin/perl -w

use API;
# use API::API;
# use API::SourceManager;

use Data::Dumper;

my $apimanager = API->new();

# API::Source::OpenRouteService::Geocode

my $api = $apimanager->GetAPI(API => 'OpenRouteService/Geocode');


my $res1 = $api->GeocodeReverse
  (
   Longitude => <REDACTED>,
   Latitude => <REDACTED>,
  );
print Dumper({Res2 => $res1});

