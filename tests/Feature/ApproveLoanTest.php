<?php

namespace Tests\Feature;

use App\Models\Loan;
use App\Repositories\LoanRepository;
use Tests\TestCase;

class ApproveLoanTest extends TestCase
{
    public function test_user_can_not_approve_loan()
    {
        //Login as user
        $token = $this->getUserLoginToken();

        $this->clearLoanData();
        $loanRepo = app(LoanRepository::class);
        $loan = $loanRepo->create([
            'amount' => 5000,
            'term_in_week' => 52,
            'status' => Loan::STATUS_NEW,
            'interest_id' => 1,
            'user_id' => 2,
            'interest_rate' => 0.01
        ]);
        $response = $this->json('PATCH', "api/admin-grp/loans/$loan->id/approve", [
            'amount' => 5000,
            'term_in_week' => 60
        ], [
            'Authorization' => "Bearer $token"
        ]);
        $response
            ->assertStatus(401);
    }

    public function test_admin_approve_loan_pass()
    {
        //Login as admin
        $token = $this->getAdminLoginToken();
        $this->clearLoanData();
        $loanRepo = app(LoanRepository::class);
        $loan = $loanRepo->create([
            'amount' => 5000,
            'term_in_week' => 52,
            'status' => Loan::STATUS_NEW,
            'interest_id' => 1,
            'user_id' => 2,
            'interest_rate' => 0.01
        ]);
        $response = $this->json('PATCH', "api/admin-grp/loans/$loan->id/approve", [
            'amount' => 5000,
            'term_in_week' => 60
        ], [
            'Authorization' => "Bearer $token"
        ]);
        $response
            ->assertStatus(200);
    }

}
