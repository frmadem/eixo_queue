package Eixo::Queue::MongoDriver;

use strict;
use MongoDB;
use Eixo::Base::Clase;

has(

	db=>undef,

	collection=>undef,

	host=>'localhost',

	port=>27017,

	__conection=>undef,
);

sub addJob{
	my ($self, $job) = @_;

	#
	# Se asume que el job es un Eixo::RestServer::Job
	#
	$self->getCollection->insert({

		_id=>$job->id,

		status=>$job->status,

		content=>$job->serialize

	});

}

sub actualizarJob{
	my ($self, $job) = @_;

	$self->getColeccion->find_and_modify({

		query=>{ _id=>$job->id },

		update =>{
			
			status=>$job->status,

			contenido=>$job->serialize
		}
			

	});
}

sub getJob{
	my ($self, $id) = @_;

	$self->__formatear(

		$self->getColeccion->find({
		
			_id=>$id

		})->next

	);
}

sub getJobPendiente{
	my ($self, $job) = @_;

	$self->__formatear(

		$self->getColeccion->find_one({

			status=>'WAITING'

		})

	);

}

	sub __formatear{
		my ($self, @jobs) = @_;

		@jobs = map {

			Eixo::Queue::Job->unserialize($_->{contenido});

		} grep { ref($_) } @jobs;

		wantarray ? @jobs : (@jobs < 2) ? $jobs[0] : \@jobs;
	}

sub getColeccion{
	my ($self, $coleccion) = @_;

	$coleccion = $coleccion || $self->coleccion;

	$self->getBd->get_collection($coleccion);

}

sub getBd{
	my ($self, $bd) = @_;

	$bd = $bd || $self->bd;

	$self->getConexion->get_database($bd);
	

}

sub getConexion{

	return $_[0]->__conexion if($_[0]->__conexion);

	my $c;

	$_[0]->__conexion(


		$c = MongoDB::MongoClient->new(

			host=>$_[0]->host,

			port=>$_[0]->port

		)	

	);

	$_[0]->__conexion;
}

#__PACKAGE__->new->getConexion;

1;
