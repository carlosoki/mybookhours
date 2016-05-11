<?php

namespace Project\Bundle\Api\Form\Type;

use Project\Bundle\Api\Entity\Client;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\MoneyType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

/**
 * Class ClientType
 * @package Project\Bundle\Api\Form\Type
 */
class ClientType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder->add('name', TextType::class)
            ->add('typeContract', TextType::class)
            ->add('rate', MoneyType::class)
            ->getForm();
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults([
            'data_class' => 'Project\Bundle\Api\Entity\Client',
            'allow_extra_fields' => true,
            'error_bubbling' => true
        ]);
    }

    public function getBlockPrefix()
    {
        return 'client_type';
    }

}
