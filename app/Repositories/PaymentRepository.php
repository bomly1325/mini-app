<?php


namespace App\Repositories;


use App\Models\Payment;

class PaymentRepository extends Repository
{
    public function getModel()
    {
        return Payment::class;
    }

    public function getNextPaymentByLoan($loanId)
    {
        return $this->getQuery()
            ->where('loan_id', $loanId)
            ->where('paid', false)
            ->orderBy('payment_date', 'asc')
            ->first();
    }
}
