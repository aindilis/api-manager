package API::Source::APIConceptNetIO::Base;

use API::API;
use API::Util qw(get_response);

use JSON qw(from_json);
use URI::Encode qw(uri_encode);

use Data::Dumper;

our @ISA = qw(API::API);

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw /  /

  ];

sub init {
  my ($self,%args) = @_;
  $self->SUPER::init(%args);
}

sub ConceptNetAPIJSONLDQuery {
  my ($self,%args) = @_;

  my $qtype = uri_encode($args{Type});
  my $qlang = uri_encode($args{Lang});
  my $qquery = uri_encode($args{Query});

  my @res1 = $self->CallAPIFunction
    (
     Call1 => sub {
       return $self->LWPUserAgent->get
	 (
	  "http://api.conceptnet.io/$_[0]->{QType}/$_[0]->{QLang}/$_[0]->{QQuery}",
	 );
     },
     Data1 => [{
		QType => $qtype,
		QLang => $qlang,
		QQuery => $qquery,
	       }],
     Overwrite => $args{Overwrite},
    );
  return get_response(Response => $res1[0][0]);
}

1;
