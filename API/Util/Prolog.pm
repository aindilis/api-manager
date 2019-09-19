use API::Util::Prolog;

require Exporter;
@ISA = qw(Exporter);

@EXPORT = qw (JSONPerlToProlog);

sub JSONPerlToProlog {
  my (%args) = @_;
  return $args{JSONPerl};
}
