import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseCrud(),
    );
  }
}

class FirebaseCrud extends StatefulWidget {
  @override
  _FirebaseCrudState createState() => _FirebaseCrudState();
}

class _FirebaseCrudState extends State<FirebaseCrud> {
  TextEditingController _idAll = TextEditingController();
  TextEditingController _adAll = TextEditingController();
  TextEditingController _kategoriAll = TextEditingController();
  TextEditingController _sayfaAll = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("firebase crude"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              controller: _idAll,
              decoration: InputDecoration(
                labelText: "Kitap id",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54, width: 2),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              controller: _adAll,
              decoration: InputDecoration(
                labelText: "Kitap adi",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54, width: 2),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              controller: _kategoriAll,
              decoration: InputDecoration(
                labelText: "Kitap kategori",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54, width: 2),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              controller: _sayfaAll,
              decoration: InputDecoration(
                labelText: "Kitap sayfasi",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54, width: 2),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  _veriEkle();
                },
                child: Text("Ekle"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  shadowColor: Colors.redAccent,
                  elevation: 5,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _veriSil();
                },
                child: Text("sil"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow,
                  onPrimary: Colors.white,
                  shadowColor: Colors.redAccent,
                  elevation: 5,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _veriGuncelle();
                },
                child: Text("guncelle"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  onPrimary: Colors.white,
                  shadowColor: Colors.redAccent,
                  elevation: 5,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _veriOku();
                },
                child: Text("oku"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  shadowColor: Colors.redAccent,
                  elevation: 5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _veriEkle() {
    //------veri ekleme
    String one = _idAll.text;
    DocumentReference veriYolu =
        FirebaseFirestore.instance.collection("kitaplik").doc(one);
    Map<String, dynamic> kitaplar = {
      "kitapId": _idAll.text,
      "kitapAdi": _adAll.text,
      "kitapKategori": _kategoriAll.text,
      "kitapSayfa": _sayfaAll.text,
    };

    veriYolu.set(kitaplar).whenComplete(() {
      Fluttertoast.showToast(msg: _idAll.text + "Id li kitap gonderildi");
    });
  }

  void _veriSil() {
    String one = _idAll.text;

    DocumentReference veriSilmeYolu =
        FirebaseFirestore.instance.collection("kitaplik").doc(one);
    veriSilmeYolu.delete();
  }

  void _veriGuncelle() {
    String one = _idAll.text;

    DocumentReference veriGuncellemeYolu =
        FirebaseFirestore.instance.collection("kitaplik").doc(one);
    Map<String, dynamic> guncellemeVeri = {
      "kitapId": _idAll.text,
      "kitapAdi": _adAll.text,
      "kitapKategori": _kategoriAll.text,
      "kitapSayfa": _sayfaAll.text,
    };

    veriGuncellemeYolu.update(guncellemeVeri).whenComplete(
          () => Fluttertoast.showToast(msg: _idAll.text + "Guncellendi"),
        );
  }

  void _veriOku() {
    String one = _idAll.text;

    DocumentReference veriOkumaYolu =
        FirebaseFirestore.instance.collection("kitaplik").doc(one);
    veriOkumaYolu.get().then((value) {
      Map<String, dynamic>? alinanVeri = value.data();

      _idAll.text = alinanVeri?["kitapId"];
      _adAll.text = alinanVeri?["kitapAdi"];
      _kategoriAll.text = alinanVeri?["kitapKategori"];
      _sayfaAll.text = alinanVeri?["kitapSayfa"];
    });
    Fluttertoast.showToast(msg: "id" + _adAll.text + "adi" + _kategoriAll.text);
  }
}
