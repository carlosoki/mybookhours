<?php

namespace Persuit\Bundle\Api\Form\Type;

use Persuit\Bundle\Api\Entity\Client;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class ClientType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder->add('name', 'text')
            ->add('typeContract', 'choice', [
                Client::CASUAL => 'casual',
                Client::PART_TIME => 'part-time',
                Client::FULL_TIME => 'full-time'
            ])
            ->add('rate', 'money')
            ->getForm();
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults([
            'data_class' => 'Persuit\Bundle\Api\Entity\Client',
            'allow_extra_fields' => true
        ]);

    }

    public function getName()
    {
        return 'client_type';
    }
}
