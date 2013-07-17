package App::Sqitch::GUI::MainFrame::Panel::Bottom;

use utf8;
use Moose;
use Wx qw(:allclasses :everything);
use Wx::Event qw(EVT_CLOSE);

with 'App::Sqitch::GUI::Roles::Element';

has 'panel' => ( is => 'rw', isa => 'Wx::Panel', lazy_build => 1 );
has 'sizer' => ( is => 'rw', isa => 'Wx::Sizer', lazy_build => 1 );

has 'log_sbs'      => ( is => 'rw', isa => 'Wx::Sizer', lazy_build => 1 );
has 'log_ctrl' => ( is  => 'rw', isa => 'Wx::TextCtrl', lazy_build => 1 );
has 'old_log'  => ( is => 'rw', isa => 'Maybe[Object]' );

sub BUILD {
    my $self = shift;

    #-   The main panel

    $self->panel->Show(0);

    #--  Log control on the left-bottom side

    $self->sizer->Add( $self->log_sbs, 1, wxEXPAND, 0 );
    $self->log_sbs->Add( $self->log_ctrl, 1, wxEXPAND | wxALL, 5 );

    #--

    $self->panel->SetSizer( $self->sizer );
    $self->panel->Show(1);

    return $self;
}

sub _build_panel {
    my $self = shift;

    my $panel = Wx::Panel->new(
        $self->parent,
        -1,
        [ -1, -1 ],
        [ -1, -1 ],
        wxFULL_REPAINT_ON_RESIZE,
        'mainPanel',
    );
    #$panel->SetBackgroundColour(Wx::Colour->new('blue'));

    return $panel;
}

sub _build_sizer {
    return Wx::BoxSizer->new(wxVERTICAL);
}

sub _build_log_sbs {
    my $self = shift;

    return Wx::StaticBoxSizer->new(
        Wx::StaticBox->new( $self->panel, -1, ' Log ', ), wxHORIZONTAL );
}

sub _build_log_ctrl {
    my $self = shift;

    my $log_ctrl = Wx::TextCtrl->new(
        $self->panel,
        -1, "Welcome to Sqitch.\n",
        [-1, -1],
        [-1, -1],
        wxTE_MULTILINE,
    );
    $log_ctrl->SetBackgroundColour( Wx::Colour->new( 'WHEAT' ) );
    my $old_log = Wx::Log::SetActiveTarget( Wx::LogTextCtrl->new( $log_ctrl ) );
    $self->old_log($old_log);

    return $log_ctrl;
}

sub _set_events { }

no Moose;
__PACKAGE__->meta->make_immutable;

=head1 AUTHOR

Stefan Suciu, C<< <stefan@s2i2.ro> >>

=head1 BUGS

None known.

Please report any bugs or feature requests to the author.

=head1 ACKNOWLEDGMENTS

GUI with Wx and Moose heavily inspired/copied from the LacunaWaX
project:

https://github.com/tmtowtdi/LacunaWaX

Thank you!

=head1 LICENSE AND COPYRIGHT

Copyright:
  Jonathan D. Barton 2012-2013
  Stefan Suciu       2013

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation.

=cut

1;    # End of App::Sqitch::GUI::MainFrame::Panel::Bottom