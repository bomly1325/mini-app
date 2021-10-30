<?php

namespace App\Http\Controllers\API\User;

use App\Http\Controllers\Controller;
use App\Models\Interest;
use App\Models\Loan;
use App\Repositories\InterestRepository;
use App\Repositories\LoanRepository;
use App\Repositories\PaymentRepository;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\ValidationException;

class UserLoanController extends Controller
{
    public function create(Request $request, LoanRepository $loanRepository, InterestRepository $interestRepository)
    {
        $userId = Auth::user()->id;
        $request->validate([
            'amount' => 'required|between:0,99.99',
            'term_in_week' => 'required|integer|min:4|max:260',
        ]);

        $interest = $interestRepository->find(Interest::FREQUENCY_WEEKLY);

        $loan = $loanRepository->create([
            'amount' => $request->get('amount'),
            'term_in_week' => $request->get('term_in_week'),
            'status' => Loan::STATUS_NEW,
            'interest_id' => $interest->id,
            'user_id' => $userId,
            'interest_rate' => $interest->default_interest_rate
        ]);

        return response()->json([
            'success' => true,
            'data' => $loan
        ]);
    }

    public function getNextPayment($loanId, PaymentRepository $paymentRepository)
    {
        $payment = $paymentRepository->getNextPaymentByLoan($loanId);

        if (!$payment) {
            throw ValidationException::withMessages([
                'id' => ['Data not found.'],
            ]);
        }

        return response()->json($payment);
    }

    public function payForPayment($loanId, Request $request, PaymentRepository $paymentRepository)
    {
        $payment = $paymentRepository->getNextPaymentByLoan($loanId);

        if (!$payment) {
            throw ValidationException::withMessages([
                'id' => ['Data not found.'],
            ]);
        }

        $request->validate([
            'amount' => 'required',
        ]);

        $amount = $request->get('amount');
        if ($amount != $payment->total) {
            throw ValidationException::withMessages([
                'amount' => ['Amount payment is not correct.'],
            ]);
        }

        $paymentRepository->update($payment->id, [
            'paid' => true,
            'paid_date' => Carbon::now()->format('Y-m-d H:i:s')
        ]);

        return response()->json(['success' => true]);

    }
}
