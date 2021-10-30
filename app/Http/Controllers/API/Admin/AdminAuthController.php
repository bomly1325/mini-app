<?php

namespace App\Http\Controllers\API\Admin;

use App\Http\Controllers\API\ApiController;
use App\Repositories\AdminRepository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AdminAuthController extends ApiController
{
    public function login(Request $request, AdminRepository $adminRepository)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        $user = $adminRepository->findBy('email', $request->email);

        if (!$user || !Hash::check($request->password, $user->password)) {
            throw ValidationException::withMessages([
                'email' => ['The provided credentials are incorrect.'],
            ]);
        }

        return response()->json([
            'success' => true,
            'access_token' => $user->createToken('access_token', ['role:admin'])->plainTextToken
        ]);
    }

    public function logout()
    {
        Auth::user()->tokens()->delete();
        return response()->json(['success' => true]);
    }
}
