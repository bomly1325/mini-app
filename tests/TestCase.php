<?php

namespace Tests;

use App\Models\Admin;
use App\Models\Payment;
use App\Models\User;
use Illuminate\Foundation\Testing\TestCase as BaseTestCase;
use Illuminate\Support\Facades\DB;

abstract class TestCase extends BaseTestCase
{
    use CreatesApplication;

    public function getUserLoginToken()
    {
        $user = User::find(2);
        return $user->createToken('access_token', ['role:user'])->plainTextToken;
    }

    public function getAdminLoginToken()
    {
        $user = Admin::find(1);
        return $user->createToken('access_token', ['role:admin'])->plainTextToken;
    }

    public function clearLoanData()
    {
        DB::table('payments')->delete();
        DB::table('loans')->delete();
    }
}
