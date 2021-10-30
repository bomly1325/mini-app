<?php

namespace Tests\Unit\Repositories;

use App\Models\Loan;
use App\Models\Payment;
use App\Repositories\LoanRepository;
use Illuminate\Support\Facades\DB;
use Tests\TestCase;


class LoanRepositoryTest extends TestCase
{
    public function test_get_model()
    {
        $loanRepository = new LoanRepository();
        $data = $loanRepository->getModel();
        $this->assertEquals(Loan::class, $data);
    }

    public function test_create()
    {
        $this->clearLoanData();
        $loanRepository = new LoanRepository();
        $data = $loanRepository->create([
            'amount' => 5000,
            'term_in_week' => 52,
            'status' => Loan::STATUS_NEW,
            'interest_id' => 1,
            'user_id' => 1,
            'interest_rate' => 0.01
        ]);
        $this->assertEquals(1, Loan::all()->count());
    }

    public function test_update()
    {
        $this->clearLoanData();
        $loanRepository = new LoanRepository();
        $data = $loanRepository->create([
            'amount' => 5000,
            'term_in_week' => 52,
            'status' => Loan::STATUS_NEW,
            'interest_id' => 1,
            'user_id' => 1,
            'interest_rate' => 0.01
        ]);
        $data1 = $loanRepository->update($data->id, ['status' => Loan::STATUS_APPROVED]);

        $this->assertEquals(Loan::STATUS_APPROVED, $data1->status);
    }
}
