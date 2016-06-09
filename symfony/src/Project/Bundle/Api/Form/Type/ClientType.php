<?php

namespace Project\Bundle\Api\Form\Type;

use Project\Bundle\Api\Entity\Client;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\CheckboxType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
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
        $builder->add('name', TextType::class, ['required' => true])
            ->add('address', TextType::class, ['required' => true])
            ->add('aboutClient', TextareaType::class, ['required' => false])
            ->add('isInactive', CheckboxType::class, ['required' => false])
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
