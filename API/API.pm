package API::API;

$ENV{'PERL_LWP_SSL_VERIFY_HOSTNAME'} = 0;
use LWP::UserAgent;
use strict;
use warnings;
use 5.010;

# use API::Resources;
use API::Util::Prolog;

use Data::Dumper;
use URI::Encode qw(uri_encode uri_decode);

# make this the base class

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / MyCacher LWPUserAgent /

  ];

sub init {
  my ($self,%args) = @_;
  $self->MyCacher($args{Cacher} || $UNIVERSAL::apimanager->MyResources->MyCacher);
  $self->LWPUserAgent(LWP::UserAgent->new);
  $self->LWPUserAgent->default_header("Accept" => "application/json; charset=utf-8");
}

sub CallAPIFunction {
  my ($self,%args) = @_;
  my @res1 = $self->MyCacher->Do
    (
     Code => $args{Call1},
     Data => $args{Data1},
     Overwrite => $args{Overwrite},
     DoNotCache => $args{DoNotCache},
    );
  return \@res1;
}

1;
