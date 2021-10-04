<?php
namespace OC\Core\Command\Maintenance;

use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class UpdateProtectDataDirectory extends Command {
	protected function configure() {
		$this
			->setName('maintenance:update:protect-data-directory')
			->setDescription('Protects the data directory');
	}

	protected function execute(InputInterface $input, OutputInterface $output): int {
		\OC\Setup::protectDataDirectory();
		$output->writeln('Data directory has been protected');
		return 0;
	}
}
