<?php
/**
 * Created by PhpStorm.
 * User: carlosoliveira
 * Date: 13/05/2016
 * Time: 5:35 PM
 */

namespace Project\Bundle\Api\Form\Type;

use Doctrine\ORM\EntityManager;
use FOS\RestBundle\Form\Transformer\EntityToIdObjectTransformer;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\DateTimeType;
use Symfony\Component\Form\Extension\Core\Type\DateType;
use Symfony\Component\Form\Extension\Core\Type\MoneyType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\TimeType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

/**
 * Class ClientLogType
 * @package Project\Bundle\Api\Form\Type
 */
class ClientLogType extends AbstractType
{
    private $em;

    public function __construct(EntityManager $em)
    {
        $this->em = $em;
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $client = new EntityToIdObjectTransformer($this->em, 'ProjectApiBundle:Client');

        $builder->add($builder->create('client', TextType::class)->addModelTransformer($client))
            ->add('start', DateTimeType::class, [
                'widget' => 'single_text',
                'format' => 'yyyy-MM-dd HH:mm:ss',
            ])
            ->add('end', DateTimeType::class, [
                'widget' => 'single_text',
                'format' => 'yyyy-MM-dd HH:mm:ss',
            ])
            ->add('durationPeriod', TimeType::class, ['widget' => 'single_text'])
            ->add('breakPeriod', TimeType::class, ['widget' => 'single_text'])
            ->add('rate', MoneyType::class, ['scale' => 2])
            ->add('km', NumberType::class, ['scale' => 2])
            ->add('totalPayment', MoneyType::class, ['scale' => 2])
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