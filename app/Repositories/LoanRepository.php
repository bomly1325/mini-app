<?php


namespace App\Repositories;


use App\Models\Loan;

class LoanRepository extends Repository
{
    public function getModel()
    {
        return Loan::class;
    }
}
