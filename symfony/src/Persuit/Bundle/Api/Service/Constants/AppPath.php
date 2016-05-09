<?php

namespace Persuit\Bundle\Api\Service\Constants;

class AppPath
{
    const OPPORTUNITY = '/opportunity/';
    const OFFER = '/offer/';
    const INVOICES = '/settings/invoices';
    const EDIT = '/edit/';

    public static function OPPORTUNITY($opportunityId)
    {
        return self::OPPORTUNITY.$opportunityId;
    }

    public static function OPPORTUNITY_EDIT($opportunityId)
    {
        return self::OPPORTUNITY.$opportunityId.self::EDIT;
    }

    public static function OFFER($offerId)
    {
        return self::OFFER.$offerId;
    }
}
