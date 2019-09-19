package API;

use API::Resources;
use API::SourceManager;
use PerlLib::SwissArmyKnife;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / MyResources MySourceManager /

  ];

sub init {
  my ($self,%args) = @_;
  $UNIVERSAL::apimanager = $self;
  $self->MyResources
    (API::Resources->new());
  $self->MySourceManager
    (API::SourceManager->new());
}

sub GetAPI {
  my ($self,%args) = @_;
  # print Dumper({Sources => $self->MySourceManager->MySources});
  return $self->MySourceManager->MySources->Contents->{$args{API}};
}

1;
