<?php

namespace Project\Bundle\Api\Form\Type;

use Doctrine\ORM\EntityManager;
use FOS\RestBundle\Form\Transformer\EntityToIdObjectTransformer;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\CheckboxType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class TravelInfoType extends AbstractType
{
    private $em;

    public function __construct(EntityManager $em)
    {
        $this->em = $em;
    }

    /**
     * @param FormBuilderInterface $builder
     * @param array $options
     */
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $clientTrans = new EntityToIdObjectTransformer($this->em, 'ProjectApiBundle:Client');
        $staffTrans = new EntityToIdObjectTransformer($this->em, 'ProjectApiBundle:Staff');

        $builder->add('travelType', CheckboxType::class, ['required' => true])
            ->add($builder->create('client', 'text')->addModelTransformer($clientTrans))
            ->add($builder->create('staff', 'text')->addModelTransformer($staffTrans))
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