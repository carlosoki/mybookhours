<?php

namespace Persuit\Bundle\Api\DependencyInjection;

use Symfony\Component\DependencyInjection\ContainerBuilder;
use Symfony\Component\Config\FileLocator;
use Symfony\Component\HttpKernel\DependencyInjection\Extension;
use Symfony\Component\DependencyInjection\Loader;

/**
 * This is the class that loads and manages your bundle configuration.
 *
 * To learn more see {@link http://symfony.com/doc/current/cookbook/bundles/extension.html}
 */
class PersuitApiExtension extends Extension
{
    /**
     * {@inheritdoc}
     */
    public function load(array $configs, ContainerBuilder $container)
    {
        $configuration = new Configuration();
        $config = $this->processConfiguration($configuration, $configs);

        $loader = new Loader\YamlFileLoader($container, new FileLocator(__DIR__.'/../Resources/config'));
        $loader->load('services.yml');
        $loader->load('services_forms.yml');
        $loader->load('services_validators.yml');
        $loader->load('services_form_handlers.yml');
        $loader->load('services_repositories.yml');
        $loader->load('services_email_notifications.yml');
        $loader->load('services_inapp_notifications.yml');
        $loader->load('services_voters.yml');
    }
}
