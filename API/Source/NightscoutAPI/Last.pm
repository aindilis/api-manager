package API::Source::NightscoutAPI::Last;

use API::API;
use API::Util qw(get_response);

use URI::Encode qw(uri_encode);

use Data::Dumper;

our @ISA = qw(API::API);

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / APIKey DoNotCache /

  ];

sub init {
  my ($self,%args) = @_;
  $self->SUPER::init(%args);
  $self->DoNotCache($args{DoNotCache} || 1);
}

sub Last {
  my ($self,%args) = @_;
  my $host = $args{Host};
  my $port = $args{Host};
  my @res1 = $self->CallAPIFunction
    (
     Call1 => sub {
       return $self->LWPUserAgent->get
	 (
	  "https://$_[0]->{Host}/api/v1/entries/sgv.json",
	 );
     },
     Data1 => [{
		Host => $host,
	       }],
     Overwrite => $args{Overwrite},
     DoNotCache => $self->DoNotCache,
    );
  return get_response(Response => $res1[0][0]);
}

1;
