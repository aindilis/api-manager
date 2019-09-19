#!/usr/bin/perl -w

use BOSS::Config;
use PerlLib::SwissArmyKnife;
use SVRS::Elements::Weather;

$specification = q(
	-l <location>			Location of sensor
	-p <properties>...		Climate property to query
	-a				Answer Only

	-q <query>...			Query types (i.e. current weather, 5 day forecast, etc)
	-v				Verbose output
);

my $config =
  BOSS::Config->new
  (Spec => $specification);
my $conf = $config->CLIConfig;
# $UNIVERSAL::systemdir = "/var/lib/myfrdcsa/codebases/minor/system";

my $weather = SVRS::Elements::Weather->new();
my %args = ();
# $args{CityConstant} = $conf->{'-l'} || 'auroraIllinois';
$args{CityConstant} = $conf->{'-l'} || 'flintMichigan';
if (exists $conf->{'-p'}) {
  $args{Properties} = $conf->{'-p'};
}
my $answeronly = 0;
if (exists $conf->{'-a'}) {
  $args{AnswerOnly} = 1;
  $answeronly = 1;
}

my @querytypes = ('CurrentWeatherData');

if (exists $conf->{'-q'}) {
  @querytypes = @{$conf->{'-q'}};
}

foreach my $querytype (@querytypes) {
  my $res1;
  if ($querytype eq 'CurrentWeatherData') {
    $res1 = $weather->CurrentWeatherData(%args);
  } elsif ($querytype eq 'FiveDayForecast') {
    $res1 = $weather->FiveDayForecast(%args);
  }
  if ($answeronly) {
    print $res1;
  } else {
    print ClearDumper({Res1 => $res1});
  }
}
