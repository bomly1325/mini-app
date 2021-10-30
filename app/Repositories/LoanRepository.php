<?php


namespace App\Repositories;


use App\Models\Loan;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class LoanRepository extends Repository
{
    public function getModel()
    {
        return Loan::class;
    }
}
