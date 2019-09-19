#!/usr/bin/perl -w

my $key = `cat /etc/myfrdcsa/config/cred/maps.googleapis.com`;
chomp $key;

# my $search = 'mongolian%20grill';
# my $search = 'Jared%20L.%20Cohon%20University%20Center';
# my $search = 'Museum%20of%20Contemporary%20Art%20Australia';
# my $search = 'Aurora%20Interfaith%20Food%20Pantry';
my $search = 'CMU%20Wean%20Hall';

system "wget \"https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$search&inputtype=textquery&fields=place_id,photos,formatted_address,name,rating,opening_hours,geometry&key=$key\"";

