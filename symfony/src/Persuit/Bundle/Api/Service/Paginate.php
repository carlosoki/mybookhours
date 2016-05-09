<?php

namespace Persuit\Bundle\Api\Service;

use Doctrine\ORM\Tools\Pagination\Paginator;

class Paginate
{
    private $paginator;
    private $limit;
    private $page;

    public function __construct($query, $page)
    {
        $this->paginator = new Paginator($query);
        $this->limit = $query->getMaxResults();
        $this->page = (int) $page;
    }

    public function getResults()
    {
        // must fetch array from iterator
        $results = $this->paginator->getIterator()->getArrayCopy();
        // must fetch count before iterating over results
        $totalRowCount = $this->paginator->count();
        $totalPageCount = ceil($totalRowCount / $this->limit);

        return [
            'results' => $results,
            'totalRowCount' => $totalRowCount,
            'totalPageCount' => $totalPageCount,
            'currentPage' => $this->page,
        ];
    }
}
