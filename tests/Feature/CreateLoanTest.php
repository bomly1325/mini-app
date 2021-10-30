<?php

namespace Tests\Feature;

use Illuminate\Support\Facades\DB;
use Tests\TestCase;

class CreateLoanTest extends TestCase
{
    public function test_user_create_loan_pass()
    {
        $this->clearLoanData();
        $token = $this->getUserLoginToken();
        $response = $this->json('POST', 'api/user-grp/loans', [
            'amount' => 5000,
            'term_in_week' => 60
        ], [
            'Authorization' => "Bearer $token"
        ]);
        $response
            ->assertStatus(200)
            ->assertJson([
                'success' => true,
            ]);
    }

    public function test_user_create_loan_fail()
    {
        $this->clearLoanData();
        $token = $this->getUserLoginToken();
        $response = $this->json('POST', 'api/user-grp/loans', [
            'amount' => 5000
        ], [
            'Authorization' => "Bearer $token"
        ]);
        $response
            ->assertStatus(422)
            ->assertJson([
                'message' => "The given data was invalid.",
            ]);
    }

    public function test_not_loggin_user_create_load_fail()
    {
        $this->clearLoanData();
        $response = $this->json('POST', 'api/user-grp/loans', [
            'amount' => 5000,
            'term_in_week' => 60
        ]);
        $response->assertStatus(401);
    }
}
