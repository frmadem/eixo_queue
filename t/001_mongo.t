use strict;
use t::test_base;

use Eixo::Queue::MongoDriver;
use Eixo::Queue::Job;

my $BD = 'bd_test_' . int(rand(10000));

my $D;

eval{

	$D = Eixo::Queue::MongoDriver->new(

		db=>$BD,

		collection=>"jobs"

	);

	my $queue = TestQueue->new(

		db=>$BD,

		collection=>"jobs"

	);

	$queue->init;

	my $j;

	$queue->add(

		$j = Eixo::Queue::Job->new(

			id=>Eixo::Queue::Job::ID

		)

	);

	my $j2;

	ok($j2 = $D->getPendingJob(), 'Job has been enqueued');

	ok($j2 && $j2->id eq $j->id, 'Pending job seems correct');

	$D->updateJob(

		$j2->finished

	);

	ok(!$D->getPendingJob(), 'There are no more pending jobs');

	ok($D->getJob($j2->id), 'The job is still collectable');

};
if($@){
	print Dumper($@);
}

if($D){

	$D->getDb->drop;
}

done_testing;

package TestQueue;

use strict;
use parent qw(Eixo::Queue::Mongo);
