package API::Source::MapsGoogleAPIs::Place;

use API::API;
use API::Util qw(get_response);

use URI::Encode qw(uri_encode);

use Data::Dumper;

our @ISA = qw(API::API);

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / APIKey /

  ];

sub init {
  my ($self,%args) = @_;
  my $apikey = `cat /etc/myfrdcsa/config/cred/maps.googleapis.com`;
  chomp $apikey;
  $self->APIKey($args{APIKey} || $apikey);
  $self->SUPER::init(%args);
}

sub PlaceSearch {
  my ($self,%args) = @_;
  my $qinput = uri_encode($args{Input});
  my $apikey = $self->APIKey;
  my @res1 = $self->CallAPIFunction
    (
     Call1 => sub {
       return $self->LWPUserAgent->get
	 (
	  "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$_[0]->{QInput}&inputtype=textquery&fields=place_id,photos,formatted_address,name,rating,opening_hours,geometry&key=$_[0]->{APIKey}",
	 );
     },
     Data1 => [{
		QInput => $qinput,
		APIKey => $apikey,
	       }],
     Overwrite => $args{Overwrite},
    );
  print Dumper({Res1 => \@res1});
  return get_response(Response => $res1[0][0]);
}

sub PlaceDetails {
  my ($self,%args) = @_;
  my $placeid = $args{PlaceID};
  my $apikey = $self->APIKey;
  my @res1 = $self->CallAPIFunction
    (
     Call1 => sub {
       return $self->LWPUserAgent->get
	 (
	  "https://maps.googleapis.com/maps/api/place/details/json?placeid=$_[0]->{PlaceID}\&fields=name,opening_hours&key=$_[0]->{APIKey}",
	 );
     },
     Data1 => [{
		PlaceID => $placeid,
		APIKey => $apikey,
	       }],
     Overwrite => $args{Overwrite},
    );
  return get_response(Response => $res1[0][0]);
}

1;
