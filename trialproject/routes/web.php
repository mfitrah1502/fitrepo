<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;
use App\Http\Controllers\ProdukController; 
use App\Http\Controllers\AuthController; 
use App\Http\Controllers\PasswordResetController;

Route::get('/home', function () {
    return view('home');
});
Route::get('/reset_password', function () {
    return view('reset_password');
})->name('reset.password');
Route::resource('produk', ProdukController::class);
Route::get('/dashboard', function () {
    return view('dashboard.homepage');
})->name('dashboard');
Route::get('/auth', function () {
    return view('auth');
})->name('auth');
Route::get('/auth/login', [AuthController::class, 'showLoginForm'])->name('login');
Route::post('/auth/login', [AuthController::class, 'login'])->name('login.process');
Route::get('/auth/register', [AuthController::class, 'showRegisterForm'])->name('register');
Route::post('/auth/register', [AuthController::class, 'register'])->name('register.process');

// Route::get('/produk', [ProdukController::class, 'index'])->name('produk');
// Route::get('/dashboard', function () {
//     return view('dashboard.homepage');
// })->name('dashboard');
Route::get('/login', function () {
    return view('login');
})->name('login');
Route::get('/register', [AuthController::class, 'showRegisterForm'])->name('register');
Route::post('/register', [AuthController::class, 'register'])->name('register.process');

// Login
Route::get('/login', [AuthController::class, 'showLoginForm'])->name('login');
Route::post('/login', [AuthController::class, 'login'])->name('login.process');

// Logout
Route::post('/logout', [AuthController::class, 'logout'])->name('logout');
//1️⃣ Tampilkan form reset password (masukkan email)
Route::get('/forgot-password', function () {
    return view('otp_reset'); // file: resources/views/forgot_password.blade.php
})->name('reset.password');

// 2️⃣ Proses kirim OTP ke email
Route::post('/forgot-password', [PasswordResetController::class, 'sendOtp'])
     ->name('reset.password.email');

// 3️⃣ Tampilkan form input OTP + password baru
Route::get('/reset-password/otp', function (Request $request) {
    return view('otp_reset', ['email' => $request->email]); // file: resources/views/otp_reset.blade.php
})->name('reset.password.otp');

// 4️⃣ Proses verifikasi OTP + reset password
Route::post('/reset-password/otp', [PasswordResetController::class, 'resetPassword'])
     ->name('reset.password.update');
// 1️⃣ Halaman untuk input email
// Route::get('/forgot-password', function () {
//     return view('otp_request'); // blade: resources/views/otp_request.blade.php
// })->name('reset.password.request');

// // 2️⃣ Proses kirim OTP ke email
// Route::post('/forgot-password', [PasswordResetController::class, 'sendOtp'])
//     ->name('reset.password.email');

// // 3️⃣ Halaman input OTP + password baru
// Route::get('/reset-password', function () {
//     return view('otp_reset'); // blade: resources/views/otp_reset.blade.php
// })->name('reset.password.form');

// // 4️⃣ Proses update password
// Route::post('/reset-password', [PasswordResetController::class, 'resetPassword'])
//     ->name('reset.password.update');
