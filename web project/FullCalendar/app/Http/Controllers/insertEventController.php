<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Event;

class insertEventController extends Controller
{
    function addData(Request $req)
        {
            $Event = new Event;
            $Event->title=$req->title;
            $Event->start=$req->start;
            $Event->end=$req->end;
            $Event->save();

            return redirect('fullcalendareventmaster');
        }
    
}
