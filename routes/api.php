<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::prefix('user-grp')->group(function () {
    Route::post('/login', [\App\Http\Controllers\API\User\UserAuthController::class, 'login']);
    Route::middleware(['auth:sanctum', 'userApi'])->group(function () {
        Route::delete('/logout', [\App\Http\Controllers\API\User\UserAuthController::class, 'logout']);
        Route::post('/loans', [\App\Http\Controllers\API\User\UserLoanController::class, 'create']);
        route::get('/loans/{id}/payment', [\App\Http\Controllers\API\User\UserLoanController::class, 'getNextPayment']);
        route::patch('/loans/{id}/pay', [\App\Http\Controllers\API\User\UserLoanController::class, 'payForPayment']);
    });
});

Route::prefix('admin-grp')->group(function () {
    Route::post('/login', [\App\Http\Controllers\API\Admin\AdminAuthController::class, 'login']);
    Route::middleware(['auth:sanctum', 'adminApi'])->group(function () {
        Route::delete('/logout', [\App\Http\Controllers\API\Admin\AdminAuthController::class, 'logout']);
        Route::patch('/loans/{id}/approve', [\App\Http\Controllers\API\Admin\AdminLoanController::class, 'approveLoan']);
    });
});
