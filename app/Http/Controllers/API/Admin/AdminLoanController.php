<?php


namespace App\Http\Controllers\API\Admin;


use App\Http\Controllers\API\ApiController;
use App\Models\Loan;
use App\Repositories\PaymentRepository;
use App\Repositories\LoanRepository;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;

class AdminLoanController extends ApiController
{

    public function approveLoan($id, LoanRepository $loanRepository, PaymentRepository $paymentRepository)
    {
        $loan = $loanRepository->find($id);

        if (!$loan) {
            throw ValidationException::withMessages([
                'id' => ['Loan not found.'],
            ]);
        }

        if ($loan->status != Loan::STATUS_NEW) {
            throw ValidationException::withMessages([
                'status' => ['Loan status is not valid for approval.'],
            ]);
        }

        DB::beginTransaction();
        try {
            $loanRepository->update($id, [
                'status' => Loan::STATUS_APPROVED,
                'admin_id' => Auth::user()->id
            ]);
            $paymentRepository->createPaymentForLoan($loan);
            DB::commit();
        } catch (\Exception $exception) {
            DB::rollBack();
            Log::error($exception);
            throw ValidationException::withMessages([
                'id' => ['Error'],
            ]);
        }

        return response()->json(['success' => true]);
    }

    public function rejectLoan($id, LoanRepository $loanRepository)
    {
        $loan = $loanRepository->find($id);

        if (!$loan) {
            throw ValidationException::withMessages([
                'id' => ['Loan not found.'],
            ]);
        }

        if ($loan->status != Loan::STATUS_NEW) {
            throw ValidationException::withMessages([
                'status' => ['Loan status is not valid for rejectiony.'],
            ]);
        }

        $loanRepository->update($id, [
            'status' => Loan::STATUS_REJECTED,
            'admin_id' => Auth::user()->id
        ]);

        return response()->json(['success' => true]);
    }
}
