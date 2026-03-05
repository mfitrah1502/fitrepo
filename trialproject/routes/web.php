<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;
use App\Http\Controllers\ProdukController; 
use App\Http\Controllers\AuthController; 

Route::get('/home', function () {
    return view('home');
});
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
