use 5.012;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Eixo::Queue',
    VERSION_FROM      => 'lib/Eixo/Queue.pm', # finds $VERSION
    PREREQ_PM         => {
        'Eixo::Base' => '1.200',
        'JSON' => '2.5',
        'Data::UUID' => '1',
        'MongoDB' => '0.708',

    }, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Eixo/Queue.pod', # retrieve abstract from module
       AUTHOR         =>  ['Francisco Maseda <frmadem@gmail.com>', 'Javier Gomez <alambike@gmail.com>']) :
       ()
    ),
);
