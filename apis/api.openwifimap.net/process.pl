#!/usr/bin/perl -w

use PerlLib::SwissArmyKnife;

use JSON;   # imports encode_json, decode_json, to_json and from_json.

# simple and fast interfaces (expect/generate UTF-8)

$Data::Dumper::Deepcopy = 1;

my $utf8_encoded_json_text = read_file('results.json');
my $hash  = decode_json $utf8_encoded_json_text;
print Dumper({Hash => $hash});


