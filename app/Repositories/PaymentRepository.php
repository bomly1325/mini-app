<?php


namespace App\Repositories;


use App\Models\Loan;
use App\Models\Payment;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

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

    public function createPaymentForLoan(Loan $loan)
    {
        $today = Carbon::now();
        $amount = $loan->amount;
        $terms = $loan->term_in_week;
        $rate = $loan->interest_rate;
        $paymentAmount = $amount / $terms;
        $balance = $amount;
        for ($i = 1; $i <= $terms; $i ++) {
            $interest = $balance * $rate;
            $balance = $balance - $paymentAmount;
            $this->create([
                'loan_id' => $loan->id,
                'payment_date' => $today->addWeek()->format('Y-m-d'),
                'payment' => $paymentAmount,
                'interest' => $interest,
                'balance' => $balance
            ]);
        }
    }
}
