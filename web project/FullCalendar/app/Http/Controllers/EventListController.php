<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Event;



class EventListController extends Controller
{
     public function list()
     {
        $data=Event::all();
        return view('list',['events'=>$data]);
     }


     public function delete($id)
    {
        $data=Event::find($id);
        $data->delete();
        return redirect('list');
    }
    public function showData($id)
    {
       $data= Event::find($id);
       return view('edit',['data'=>$data]);
    }
    public function update(Request $req)
    {
       $data=Event::find($req->id);
       $data->title=$req->title;
       $data->start=$req->start;
       $data->end=$req->end;
       $data->save();
       return redirect('list');
    }
 }