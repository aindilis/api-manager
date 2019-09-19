package API::SourceManager;

use Manager::Dialog qw(Message SubsetSelect);
use PerlLib::Collection;

# use API::Source::MapsGoogleAPIs::Place;

use Data::Dumper;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw { ListOfSources MySources }

  ];

sub init {
  my ($self,%args) = (shift,@_);
  $UNIVERSAL::systemdir = "/var/lib/myfrdcsa/codebases/minor/api-manager";
  Message(Message => "Initializing sources...");
  my $dir = "$UNIVERSAL::systemdir/API/Source";

  my @names = sort map {$_ =~ s/.pm$//; $_ =~ s/$dir\///sg; $_} grep(/\.pm$/,split /\n/,`find $dir`);
  $self->ListOfSources(\@names);
  $self->MySources
    (PerlLib::Collection->new
     (Type => "API::Source"));
  $self->MySources->Contents({});
  foreach my $name (@{$self->ListOfSources}) {
    my $modulename = $name;
    $modulename =~ s/\//::/sg;
    Message(Message => "Initializing API/Source/$name.pm...");
    require "$dir/$name.pm";
    my $s = "API::Source::$modulename"->new();
    $self->MySources->Add
      ($name => $s);
  }
}

1;
