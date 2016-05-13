<?php
/**
 * Created by PhpStorm.
 * User: carlosoliveira
 * Date: 13/05/2016
 * Time: 5:35 PM
 */

namespace Project\Bundle\Api\Form\Type;

use FOS\RestBundle\Form\Transformer\EntityToIdObjectTransformer;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\DateType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\MoneyType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\TimeType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

/**
 * Class ClientLog
 * @package Project\Bundle\Api\Form\Type
 */
class ClientLog extends AbstractType
{
    private $em;

    public function __construct($em)
    {
        $this->em = $em;
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $client = new EntityToIdObjectTransformer($this->em, 'ProjectApiBundle:Client');

        $builder->add($builder->create('client', TextType::class)->addModelTransformer($this->em, $client))
            ->add('date', DateType::class)
            ->add('durationPeriod', IntegerType::class)
            ->add('startTime', TimeType::class)
            ->add('endTime', TimeType::class)
            ->add('breakPeriod', IntegerType::class)
            ->add('rate', MoneyType::class)
            ->add('km', NumberType::class)
            ->add('totalPayment', MoneyType::class)
            ->add('description', TextareaType::class)
            ->getForm();
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults([
            'data_class' => 'Project\Bundle\Api\Entity\ClientLog',
            'allow_extra_fields' => true
        ]);
    }

    public function getBlockPrefix()
    {
        return 'client_log_type';
    }


}