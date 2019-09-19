#!/usr/bin/perl -w

use Data::Dumper;
use DateTime;
use DateTime::Format::Strptime;
use File::Slurp;
use JSON;

# pull the json data, don't cache it
my $c = read_file('sgv.json');
my $data = decode_json($c);
my $parser = DateTime::Format::Strptime->new
  (
   pattern => '%Y-%M-%DT%H:%m:%S',
   on_error => 'croak',
  );
my $timezones =
  {
   '0400' => 'America/Chicago',
  };
CheckIfAlarmTriggered(Data => $data);

sub CheckIfAlarmTriggered {
  my (%args) = @_;

  my $currentdatetime = DateTime->now();
  my $nextdatetime = $currentdatetime;
  foreach my $datapoint (@{$args{Data}}) {
    print Dumper($datapoint);

    my $datetime;
    if ($datapoint->{dateString} =~ /^([0-9]{4})-([0-9]{2})-([0-9]{2})T([0-9]{2}):([0-9]{2}):([0-9]{2})\.([0-9]{3})-([0-9]{4})$/) {
      $datetime = DateTime->new
	(
	 year => $1,
	 month => $2,
	 day => $3,
	 hour => $4,
	 minute => $5,
	 second => $6,
	 nanosecond => $7 * 1000000,
	 time_zone => $timezones->{$8},
	);
      my $howlongago = $currentdatetime - $datetime;
      my $howlongbetween = $nextdatetime - $datetime;
      my $secondsago = $howlongago->in_units( 'minutes' ) * 60 + $howlongago->in_units( 'seconds' );
      my $secondsbetween = $howlongbetween->in_units( 'minutes' ) * 60 + $howlongbetween->in_units( 'seconds' );
      print Dumper
	({
	  ago => $secondsago,
	  between => $secondsbetween,
	 });
      $nextdatetime = $datetime;
    } else {
      die "WTF!\n";
    }
  }

  # alarm on missing data

  # three consecutive under 50

  # one under 40
}
