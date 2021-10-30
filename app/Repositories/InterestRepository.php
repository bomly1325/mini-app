<?php


namespace App\Repositories;


use App\Models\Interest;

class InterestRepository extends Repository
{
    public function getModel()
    {
        return Interest::class;
    }
}
