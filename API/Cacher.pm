package API::Cacher;

use Sayer;
use UniLang::Util::TempAgent;

use Data::Dump::Streamer;
use Data::Dumper;


use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / MySayer Results IsCached /

  ];

sub init {
  my ($self,%args) = @_;
  $self->MySayer($args{Sayer} || Sayer->new(DBName => $args{DBName}));
  # $self->MySayer->Debug(1);
  $self->Results({});
}

sub Do {
  my ($self,%args) = @_;
  my $results;
  my $overwrite = $args{Overwrite} || 0;
  $self->IsCached({});
  # my $res = $self->MySayer->ExecuteCodeOnData
  #   (
  #    GiveHasResult => 1,
  #    CodeRef => $args{Code},
  #    Data => $args{Data},
  #    Overwrite => $overwrite,
  #    NoRetrieve => $args{NoRetrieve},
  #   );
  # print Dumper({RawResults => $res}) if $args{Debug};
  # if ($res->{Success}) {
  #   $results->{$key} = $res->{Result};
  # } else {
    $results->{$key} =
      [
       $self->MySayer->ExecuteCodeOnData
       (
	CodeRef => $args{Code},
	Data => $args{Data},
	Overwrite => $overwrite,
	NoRetrieve => $args{NoRetrieve},
	OnlyRetrieve => $args{OnlyRetrieve},
	Skip => $args{Skip},
	DoNotCache => $args{DoNotCache},
       ),
      ];
    $self->IsCached($self->MySayer->IsCached());
  # }
  return $results;
}

1;
