package Eixo::Queue::Mongo;

use strict;
use parent qw(Eixo::Queue);

has(

	mongo_driver=>undef,

	db=>undef,

	collection => undef,

	host=>undef,

	port=>undef,

);



1;
