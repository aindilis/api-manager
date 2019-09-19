package API::Source::OpenRouteService::Geocode;

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
  my $apikey = `cat /etc/myfrdcsa/config/cred/openrouteservice`;
  chomp $apikey;
  $self->APIKey($args{APIKey} || $apikey);
  $self->SUPER::init(%args);
}

sub GeocodeStructured {
  my ($self,%args) = @_;
  my $qaddress = uri_encode($args{Address});
  my $qpostalcode = uri_encode($args{PostalCode});
  my $apikey = $self->APIKey;
  my $response = $self->LWPUserAgent->get
    (
     "https://api.openrouteservice.org/geocode/search/structured?address=$qaddress&postalcode=$qpostalcode&api_key=$apikey",
    );
  $self->get_response(Response => $response);
}

sub GeocodeReverseOld {
  my ($self,%args) = @_;
  my $lat = $args{Latitude};
  my $lon = $args{Longitude};
  my $apikey = $self->APIKey;
  my $response = $self->LWPUserAgent->get
    (
     "https://api.openrouteservice.org/geocode/reverse?point.lat=$lat&point.lon=$lon&api_key=$apikey",
    );
  $self->get_response(Response => $response);
}

sub GeocodeReverse {
  my ($self,%args) = @_;
  my $apikey = $self->APIKey;
  my $qlat = uri_encode($args{Latitude});
  my $qlon = uri_encode($args{Longitude});
  my @res1 = $self->CallAPIFunction
    (
     Call1 => sub {
       return $self->LWPUserAgent->get
	 (
	  "https://api.openrouteservice.org/geocode/reverse?point.lat=$_[0]->{QLat}&point.lon=$_[0]->{QLon}&api_key=$_[0]->{APIKey}",
	 );
     },
     Data1 => [{
		APIKey => $apikey,
		QLat => $qlat,
		QLon => $qlon,
	       }],
     Overwrite => $args{Overwrite},
    );
  print Dumper({Res1 => \@res1});
  return get_response(Response => $res1[0][0]);
}

1;
