<?php

namespace Project\Bundle\Api\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class TravelInfoType extends AbstractType
{
    /**
     * @param FormBuilderInterface $builder
     * @param array $options
     */
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('travelType', ChoiceType::class,[
                'required' => true,
                'choices' => [
                    'with client' => 'with client',
                    'between client' => 'between client'
                ]
            ])
            ->add('kmStart', NumberType::class)
            ->add('kmEnd', NumberType::class)
        ->getForm();
    }

    /**
     * @param OptionsResolver $resolver
     */
    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults([
            'data_class' => 'Project\Bundle\Api\Entity\TravelInfo',
            'allow_extra_fields' => true,
            'error_bubbling' => true
        ]);
    }

    /**
     * @return null|string
     */
    public function getBlockPrefix()
    {
        return 'travelInfo_type';
    }
}