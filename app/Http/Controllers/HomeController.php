<?php

namespace App\Http\Controllers;

class HomeController extends Controller
{
    public function index()
    {
        return response()->json([
            "status" => "ok",
            "message" => "Laravel 11 rodando perfeitamente 🚀"
        ]);
    }
}