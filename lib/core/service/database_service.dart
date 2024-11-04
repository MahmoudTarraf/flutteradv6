import 'package:flutteradv6/model/products_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutteradv6/core/const_data/app_strings.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();
  DatabaseService._constructor();
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "favorites.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    return database;
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {}

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE ${AppStrings.tasksTableName} (
      ${AppStrings.favoritesIdColumnName} INTEGER PRIMARY KEY,
      ${AppStrings.favoritesTitleColumnName} TEXT NOT NULL,
      ${AppStrings.favoritesImageColumnName} TEXT NOT NULL,
      ${AppStrings.favoritesPriceColumnName} INTEGER NOT NULL
    )
    ''');
  }

  // Add favorite item
  Future<int> addFavorite(ProductDetails product) async {
    final db = await database;
    return await db.insert(
      AppStrings.tasksTableName,
      {
        AppStrings.favoritesIdColumnName: product.id,
        AppStrings.favoritesTitleColumnName: product.name,
        AppStrings.favoritesImageColumnName: product.image,
        AppStrings.favoritesPriceColumnName: product.price,
      },
      conflictAlgorithm: ConflictAlgorithm.replace, // Replaces if ID exists
    );
  }

  // Delete favorite item
  Future<int> deleteFavorite(int id) async {
    final db = await database;
    return await db.delete(
      AppStrings.tasksTableName,
      where: '${AppStrings.favoritesIdColumnName} = ?',
      whereArgs: [id],
    );
  }

  Future<List<ProductDetails>> getFavorites() async {
    final db = await database;
    final favorites = await db.query(AppStrings.tasksTableName);
    return favorites.map((item) {
      return ProductDetails(
        id: item[AppStrings.favoritesIdColumnName] as int,
        name: item[AppStrings.favoritesTitleColumnName] as String,
        image: item[AppStrings.favoritesImageColumnName] as String,
        price: item[AppStrings.favoritesPriceColumnName] is int
            ? item[AppStrings.favoritesPriceColumnName] as int
            : int.parse(item[AppStrings.favoritesPriceColumnName] as String),
        subCategory: SubCategory(
          id: 0,
          name: '',
          category: Category(id: 0, name: ''),
        ),
        evaluation: 0,
        discount: 0,
        isFavorite: true,
      );
    }).toList();
  }
}
