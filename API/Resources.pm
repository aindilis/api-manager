package API::Resources;

use API::Cacher;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / MyCacher /

  ];

sub init {
  my ($self,%args) = @_;
  $self->MyCacher
    ($args{Cacher} || API::Cacher->new(DBName => $args{DBName} || 'sayer_api_manager'));
}

1;
