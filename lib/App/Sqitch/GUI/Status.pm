package App::Sqitch::GUI::Status;

use Moose;
use namespace::autoclean;
use Moose::Util::TypeConstraints;

has state => (
    is       => 'rw',
    isa      => enum([ qw(load init idle edit) ]),
    required => 1,
    default  => 'load',
);

with 'MooseX::Observer::Role::Observable' => {
    notify_after => [
        qw{
             set_state
        }
    ]
};

# sub _utility_method {
#     print "utility?\n";
# }


sub set_state {
    my ($self, $state) = @_;

    $self->state($state);

    return;
}

sub get_state {
    my $self = shift;

    return $self->state;
}

sub is_state {
    my ($self, $state) = @_;

    return 1 if $self->state eq $state;

    return;
}

no Moose::Util::TypeConstraints;
__PACKAGE__->meta->make_immutable;

1;