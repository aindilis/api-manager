package API::Source::OTRecorderAPI::Last;

use API::API;
use API::Util qw(get_response);

use URI::Encode qw(uri_encode);

use Data::Dumper;

our @ISA = qw(API::API);

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / DoNotCache /

  ];

sub init {
  my ($self,%args) = @_;
  $self->SUPER::init(%args);
  $self->DoNotCache($args{DoNotCache} || 1);
}

sub Last {
  my ($self,%args) = @_;
  my $host = $args{Host};
  my $port = $args{Port};
  my $qusername = uri_encode($args{Username});
  my $qdevice = uri_encode($args{Device});
  my @res1 = $self->CallAPIFunction
    (
     Call1 => sub {
       return $self->LWPUserAgent->get
	 (
	  "http://$_[0]->{Host}:$_[0]->{Port}/api/0/last?user=$_[0]->{QUsername}&device=$_[0]->{QDevice}",
	 );
     },
     Data1 => [{
		Host => $host,
		Port => $port,
		QUsername => $qusername,
		QDevice => $qdevice,
	       }],
     Overwrite => $args{Overwrite},
     DoNotCache => $self->DoNotCache,
    );
  # print Dumper({Res1 => \@res1});
  return get_response(Response => $res1[0][0]);
}

sub Locations {
  my ($self,%args) = @_;
  my $host = $args{Host};
  my $port = $args{Port};
  my $qusername = uri_encode($args{Username});
  my $qdevice = uri_encode($args{Device});
  my @res1 = $self->CallAPIFunction
    (
     Call1 => sub {
       return $self->LWPUserAgent->get
	 (
	  "http://$_[0]->{Host}:$_[0]->{Port}/api/0/locations?user=$_[0]->{QUsername}&device=$_[0]->{QDevice}",
	 );
     },
     Data1 => [{
		Host => $host,
		Port => $port,
		QUsername => $qusername,
		QDevice => $qdevice,
	       }],
     Overwrite => $args{Overwrite},
     DoNotCache => $self->DoNotCache,
    );
  # print Dumper({Res1 => \@res1});
  return get_response(Response => $res1[0][0]);
}

1;
