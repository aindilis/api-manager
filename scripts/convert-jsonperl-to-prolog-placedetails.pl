#!/usr/bin/perl -w

my $data =
  {
   'name' => 'Walmart Supercenter',
   'opening_hours' => {
		       'periods' => [
				     {
				      'close' => {
						  'day' => 1,
						  'time' => '0000'
						 },
				      'open' => {
						 'time' => '0600',
						 'day' => 0
						}
				     },
				     {
				      'open' => {
						 'day' => 1,
						 'time' => '0600'
						},
				      'close' => {
						  'day' => 2,
						  'time' => '0000'
						 }
				     },
				     {
				      'close' => {
						  'day' => 3,
						  'time' => '0000'
						 },
				      'open' => {
						 'time' => '0600',
						 'day' => 2
						}
				     },
				     {
				      'close' => {
						  'day' => 4,
						  'time' => '0000'
						 },
				      'open' => {
						 'day' => 3,
						 'time' => '0600'
						}
				     },
				     {
				      'open' => {
						 'time' => '0600',
						 'day' => 4
						},
				      'close' => {
						  'day' => 5,
						  'time' => '0000'
						 }
				     },
				     {
				      'close' => {
						  'time' => '0000',
						  'day' => 6
						 },
				      'open' => {
						 'day' => 5,
						 'time' => '0600'
						}
				     },
				     {
				      'close' => {
						  'time' => '0000',
						  'day' => 0
						 },
				      'open' => {
						 'day' => 6,
						 'time' => '0600'
						}
				     }
				    ],
		       'weekday_text' => [
					  "Monday: 6:00 AM \x{2013} 12:00 AM",
					  "Tuesday: 6:00 AM \x{2013} 12:00 AM",
					  "Wednesday: 6:00 AM \x{2013} 12:00 AM",
					  "Thursday: 6:00 AM \x{2013} 12:00 AM",
					  "Friday: 6:00 AM \x{2013} 12:00 AM",
					  "Saturday: 6:00 AM \x{2013} 12:00 AM",
					  "Sunday: 6:00 AM \x{2013} 12:00 AM"
					 ],
		       'open_now' => bless( do{\(my $o = 0)}, 'JSON::PP::Boolean' )
		      },
  };
