<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Produk;

class ProdukController extends Controller
{
    public function index()
    {
        // $produks = collect([
        //     (object)[
        //         'id' => 1,
        //         'nama' => 'CreamBath Refresh',
        //         'harga' => 15000,
        //         'stok' => 10
        //     ],
        //     (object)[
        //         'id' => 2,
        //         'nama' => 'Conditioner Premium',
        //         'harga' => 25000,
        //         'stok' => 5
        //     ],
        //     (object)[
        //         'id' => 3,
        //         'nama' => 'Hair Mask Premium',
        //         'harga' => 48000,
        //         'stok' => 8
        //     ],
        // ]);
        $produks = Produk::all(); // ambil semua data dari tabel 'produks'

        return view('produk.index', compact('produks'));
    }
    // FORM TAMBAH
public function create()
{
    return view('produk.create');
}

// SIMPAN DATA
public function store(Request $request)
{
    $request->validate([
        'nama'  => 'required',
        'harga' => 'required|numeric',
        'stok'  => 'required|numeric'
    ]);

    Produk::create($request->all());

    return redirect()->route('produk.index')
        ->with('success', 'Data berhasil ditambahkan');
}

// FORM EDIT
public function edit($id)
{
    $produk = Produk::findOrFail($id);
    return view('produk.edit', compact('produk'));
}

// UPDATE DATA
public function update(Request $request, $id)
{
    $request->validate([
        'nama'  => 'required',
        'harga' => 'required|numeric',
        'stok'  => 'required|numeric'
    ]);

    $produk = Produk::findOrFail($id);
    $produk->update($request->all());

    return redirect()->route('produk.index')
        ->with('success', 'Data berhasil diupdate');
}

// DELETE DATA
public function destroy($id)
{
    $produk = Produk::findOrFail($id);
    $produk->delete();

    return redirect()->route('produk.index')
        ->with('success', 'Data berhasil dihapus');
}
}