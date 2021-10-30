<?php

namespace App\Http\Controllers\API\User;

use App\Http\Controllers\API\ApiController;
use App\Repositories\UserRepository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class UserAuthController extends ApiController
{
    public function login(Request $request, UserRepository $userRepository)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        $user = $userRepository->findBy('email', $request->email);

        if (!$user || !Hash::check($request->password, $user->password)) {
            throw ValidationException::withMessages([
                'email' => ['The provided credentials are incorrect.'],
            ]);
        }

        return response()->json([
            'success' => true,
            'access_token' => $user->createToken('access_token', ['role:user'])->plainTextToken
        ]);
    }

    public function logout()
    {
        Auth::user()->tokens()->delete();
        return response()->json(['success' => true]);
    }
}
