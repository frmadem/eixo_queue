use strict;

use Test::More;

use Eixo::Queue::RabbitDriver;

my ($host, $port) = ("172.17.0.1", 9999);

my $r = Eixo::Queue::RabbitDriver->new(
    
    host=>$host,

    port=>$port,

);

$r->publicar("asdfasdf", "aqui", "esto");

<STDIN>;
sleep(1);

my $rr = Eixo::Queue::RabbitDriver->new(

    host=>$host,

    port=>$port,

);


use Data::Dumper;

print Dumper($rr->suscribirse("aqui", "esto"));

done_testing;
