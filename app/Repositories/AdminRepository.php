<?php

namespace App\Repositories;

use App\Models\Admin;

class AdminRepository extends Repository
{
    public function getModel()
    {
        return Admin::class;
    }
}
