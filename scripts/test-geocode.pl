#!/usr/bin/perl -w

use API::OpenRouteService::Geocode;

use Data::Dumper;

my $geocode = API::APIs::OpenRouteService::Geocode->new;

my $res1 = $geocode->GeocodeStructured
  (
   Address => '3404 Sherwood Dr',
   PostalCode => 48503,
  );
print Dumper({Res1 => $res1});

my $res2 = $geocode->GeocodeReverse
  (
   Longitude => -83.727205,
   Latitude => 43.01112,
  );
print Dumper({Res2 => $res2});
