#!/usr/bin/perl -w

my $key = `cat /etc/myfrdcsa/config/cred/maps.googleapis.com`;
chomp $key;
# my $placeid = 'ChIJN1t_tDeuEmsRUsoyG83frY4';
# my $placeid = 'ChIJCwmCvPTvDogRY1JaRFp_EJM';
my $placeid = 'ChIJRbkJ5CHyNIgR-41T03tBsxY';
system "wget \"https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeid\&fields=name,opening_hours&key=$key\"";
