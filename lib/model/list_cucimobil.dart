class ListItemCuci {
  final int id;
  final String label;
  final int harga;

  ListItemCuci(this.id, this.label, this.harga);

  static final listPilihan = <ListItemCuci>[
    ListItemCuci(1, "Cuci Hidrolik", 75000),
    ListItemCuci(2, "Cuci Otomatis", 50000),
    ListItemCuci(3, "Cuci Manual", 35000),
    ListItemCuci(4, "Cuci Underbody", 20000),
    ListItemCuci(5, "Cuci Poles", 25000),
    ListItemCuci(6, "Cuci Salju", 60000)
  ];
}
