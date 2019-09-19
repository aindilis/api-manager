package API::Source::MapsGoogleAPIs::Directions;

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

sub Directions {
  my ($self,%args) = @_;
  my $qorigin = uri_encode($args{Origin});
  my $qdestination = uri_encode($args{Destination});
  my $qmode = uri_encode($args{Mode});
  my $apikey = $self->APIKey;
  my @res1 = $self->CallAPIFunction
    (
     Call1 => sub {
       return $self->LWPUserAgent->get
	 (
	  "https://maps.googleapis.com/maps/api/directions/json?origin=$_[0]->{QOrigin}&destination=$_[0]->{QDestination}&mode=$_[0]->{QMode}&key=$_[0]->{APIKey}",
	 );
     },
     Data1 => [{
		QOrigin => $qorigin,
		QDestination => $qdestination,
		QMode => $qmode || 'driving',
		APIKey => $apikey,
	       }],
     Overwrite => $args{Overwrite},
    );
  return get_response(Response => $res1[0][0]);
}

1;
