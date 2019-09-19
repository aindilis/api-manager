package API::Util;

use Cpanel::JSON::XS qw(encode_json decode_json);
use Data::Dumper;

require Exporter;
@ISA = qw(Exporter);

@EXPORT = qw (get_response);


sub get_response {
  my (%args) = @_;
  my $response = $args{Response}->{''}[0];
  if ($response->is_success) {
    return decode_json($response->decoded_content);
  } else {
    die $response->status_line;
  }
}

1;
