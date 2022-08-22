<?php

use App\Http\Controllers\UserController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\FullCalendarEventMasterController;
use App\Http\Controllers\insertEventController;
use App\Http\Controllers\EventListController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::group([ "middleware" => ['auth:sanctum', 'verified'] ], function() {
    Route::view('/dashboard', "dashboard")->name('dashboard');
    Route::view('/PublicHolidays', "PublicHolidays")->name('PublicHolidays');
    Route::view('/eventsTable', "eventsTable")->name('eventsTable');
    Route::view('/insertEvent', "insertEvent")->name('insertEvent');
    Route::view('/list', "list")->name('list');
    Route::view('/insertEventData', "insertEventData")->name('insertEventData');

 Route::view('/insertEvent', 'insertEvent')->name('insertEvent');
    Route::post('insertEvent', [insertEventController::class,'addData']);
    


    Route::get('/user', [ UserController::class, "index_view" ])->name('user');
    Route::view('/user/new', "pages.user.user-new")->name('user.new');
    Route::view('/user/edit/{userId}', "pages.user.user-edit")->name('user.edit');

   
    Route::get('list',[EventListController::class,'list']);
    Route::get('delete/{id}',[EventListController::class,'delete']);
    Route::get('edit/{id}',[EventListController::class,'showData']);
    Route::post('edit',[EventListController::class,'update']);
    /*
    Route::post('/EventList/index',[EventListController::class,'index']);
*/
   

    
   
    Route::post('/fullcalendareventmaster/delete',[FullCalendarEventMasterController::class,'destroy']);


    Route::get('/fullcalendareventmaster',[FullCalendarEventMasterController::class,'index']);
Route::post('/fullcalendareventmaster/create',[FullCalendarEventMasterController::class,'create']);
Route::post('/fullcalendareventmaster/update',[FullCalendarEventMasterController::class,'update']);
Route::post('/fullcalendareventmaster/delete',[FullCalendarEventMasterController::class,'destroy']);
});




//fullcalender

