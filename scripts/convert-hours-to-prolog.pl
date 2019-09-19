#!/usr/bin/perl -w

use KBS2::Util;

my $result =
  {
   'html_attributions' => [],
   'result' => {
		'name' => 'Panera Bread',
		'opening_hours' => {
				    'periods' => [
						  {
						   'close' => {
							       'time' => '2100',
							       'day' => 0
							      },
						   'open' => {
							      'day' => 0,
							      'time' => '0700'
							     }
						  },
						  {
						   'close' => {
							       'time' => '2100',
							       'day' => 1
							      },
						   'open' => {
							      'day' => 1,
							      'time' => '0600'
							     }
						  },
						  {
						   'open' => {
							      'time' => '0600',
							      'day' => 2
							     },
						   'close' => {
							       'day' => 2,
							       'time' => '2100'
							      }
						  },
						  {
						   'open' => {
							      'time' => '0600',
							      'day' => 3
							     },
						   'close' => {
							       'day' => 3,
							       'time' => '2100'
							      }
						  },
						  {
						   'open' => {
							      'day' => 4,
							      'time' => '0600'
							     },
						   'close' => {
							       'time' => '2100',
							       'day' => 4
							      }
						  },
						  {
						   'open' => {
							      'time' => '0600',
							      'day' => 5
							     },
						   'close' => {
							       'time' => '2100',
							       'day' => 5
							      }
						  },
						  {
						   'open' => {
							      'day' => 6,
							      'time' => '0600'
							     },
						   'close' => {
							       'time' => '2100',
							       'day' => 6
							      }
						  }
						 ],
				    'open_now' => bless( do{\(my $o = 0)}, 'JSON::PP::Boolean' ),
				    'weekday_text' => [
						       "Monday: 6:00 AM \x{2013} 9:00 PM",
						       "Tuesday: 6:00 AM \x{2013} 9:00 PM",
						       "Wednesday: 6:00 AM \x{2013} 9:00 PM",
						       "Thursday: 6:00 AM \x{2013} 9:00 PM",
						       "Friday: 6:00 AM \x{2013} 9:00 PM",
						       "Saturday: 6:00 AM \x{2013} 9:00 PM",
						       "Sunday: 7:00 AM \x{2013} 9:00 PM"
						      ]
				   }
	       }
   };

my $dayhash =
  {
   0 => 'sunday',
   1 => 'monday',
   2 => 'tuesday',
   3 => 'wednesday',
   4 => 'thursday',
   5 => 'friday',
   6 => 'saturday',
  };

sub ConvertAPICallToPrologAssertions {
  my (%args) = @_;
  my $result = $args{Result};
  my $periods = $result->{result}{opening_hours}{periods};
  my $name = Prologify($result->{result}{name});
  my @facts;
  foreach my $period (@$periods) {
    my $day = $dayhash->{$period->{open}{day}};
    my $open = GetPrologTime($period->{open}{time});
    my $close = GetPrologTime($period->{close}{time});
    push @facts, "hasHours($name,$day,[[$open,$close]]).";
  }
  print join("\n",@facts);
}

sub GetPrologTime {
  my $time = shift;
  $time =~ /^(\d\d)(\d\d)$/;
  return "[$1:$2:00]";
}

ConvertAPICallToPrologAssertions(Result => $result);
