package Eixo::Queue::Job;

use strict;
use Eixo::Base::Clase;

use JSON -convert_blessed_universally;
use Data::UUID;

my $UUID_INSTANCE;

BEGIN{
	$UUID_INSTANCE = Data::UUID->new;
}

sub ID{

	$UUID_INSTANCE->create_str;
}

has(

	id		=>	undef,

	queue		=>	undef,

	running		=>	0,

	done		=>	0,

	created 	=>	time,

	start		=>	0,

	finished 	=>	0,

	args		=>	{},

	results		=>	{},

	class		=>	undef,

);

sub initialize{

	$_[0]->type(ref($_[0]));	

}

sub serialize{
	my ($self) = @_;

	JSON->new->convert_blessed->encode( $self )
}

sub unserialize{
	my ($package, $data) = @_;

	if(ref($package)){
		$package = ref($package);
	}

	bless(JSON->new->decode($data), $data->{class});
}

sub setArg{
	my ($self, $key, $value) = @_;

	$self->args->{$key} = $value;
}

sub setResult{
	my ($self, $key, $value) = @_;

	$self->results->{$key} = $value;
} 

sub setError{

	$_[0]->status(ERROR);

	$_[0]->setResult('error', $_[1]);


}

1;
