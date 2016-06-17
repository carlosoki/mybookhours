<?php

namespace Project\Bundle\Api\Form\Type;

use Doctrine\ORM\EntityManager;
use FOS\RestBundle\Form\Transformer\EntityToIdObjectTransformer;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;
use Symfony\Component\Form\Extension\Core\Type\DateTimeType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

/**
 * Class AppointmentType
 * @package Project\Bundle\Api\Form\Type
 */
class AppointmentType extends AbstractType
{
    private $em;

    public function __construct(EntityManager $em)
    {
        $this->em = $em;
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $clientTrans = new EntityToIdObjectTransformer($this->em, 'ProjectApiBundle:Client');
        $staffTrans = new EntityToIdObjectTransformer($this->em, 'ProjectApiBundle:Staff');

       $builder
           ->add('start', DateTimeType::class, [
                'required' => true,
                'widget' => 'single_text'
           ])
           ->add('end', DateTimeType::class, [
               'required' => true,
               'widget' => 'single_text'
           ])
           ->add($builder->create('client', 'text')->addModelTransformer($clientTrans))
           ->add($builder->create('staff', 'text')->addModelTransformer($staffTrans))
           ->add('serviceInfo', TextareaType::class, ['required' => false])
           ->add('report', TextareaType::class, ['required' => false])
           ->add('clientSignature', TextType::class, ['required' => false])
//           ->add('travelInfo', CollectionType::class, [
//               'type' => new TravelInfoType($this->em),
//               'allow_add' => true,
//               'allow_delete' => true,
//               'by_reference' => false,
//               'error_bubbling' => false,
//           ])
           ->getForm()
       ;
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults([
            'data_class' => 'Project\Bundle\Api\Entity\Appointment',
            'allow_extra_fields' => true,
            'error_bubbling' => true
        ]);
    }

    public function getBlockPrefix()
    {
        return 'appointment_type';
    }


}