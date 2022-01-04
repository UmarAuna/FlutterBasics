import 'package:moor_flutter/moor_flutter.dart';

import '../models/models.dart';

part 'moor_db.g.dart';

//Add MoorRecipe table definition here
class MoorRecipe extends Table {
  /*
  * • IntColumn: Integers.
  * • BoolColumn: Booleans.
  * • TextColumn: Text.
  * • DateTimeColumn: Dates.
  * • RealColumn: Doubles.
  * • BlobColumn: Arbitrary blobs of data.
  * */
  IntColumn get id => integer().autoIncrement()();
  TextColumn get label => text()();
  TextColumn get image => text()();
  TextColumn get url => text()();
  RealColumn get calories => real()();
  RealColumn get totalWeight => real()();
  RealColumn get totalTime => real()();
}

//Add MoorIngredient table definition here
class MoorIngredient extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get recipeId => integer()();
  TextColumn get name => text()();
  RealColumn get weight => real()();

}

//Add @UseMoor() and RecipeDatabase() here
@UseMoor(tables: [MoorRecipe, MoorIngredient], daos: [RecipeDao, IngredientDao])
class RecipeDatabase extends _$RecipeDatabase {
  RecipeDatabase(): super(FlutterQueryExecutor.inDatabaseFolder(
  path: 'recipes.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;
}

//Add RecipeDao here
@UseDao(tables:[MoorRecipe])
class RecipeDao extends DatabaseAccessor<RecipeDatabase> with _$RecipeDaoMixin {
  final RecipeDatabase db;

  RecipeDao(this.db) : super(db);

  Future<List<MoorRecipeData>> findAllRecipes() => select(moorRecipe).get();

  Stream<List<Recipe>> watchAllRecipes() {
    return select(moorRecipe).watch().map((rows) {
      final recipes = <Recipe>[];
      rows.forEach((row) {
        final recipe = moorRecipeToRecipe(row);
        if(!recipes.contains(recipe)) {
          recipe.ingredients = <Ingredient>[];
          recipes.add(recipe);
        }
      });
      return recipes;
    });
  }

  Future<List<MoorRecipeData>> findRecipeById(int id) => (select(moorRecipe)..where((tbl) => tbl.id.equals(id))).get();

  Future<int> insertRecipe(Insertable<MoorRecipeData> recipe) => into(moorRecipe).insert(recipe);

  Future deleteRecipe(int id) => Future.value(
      (delete(moorRecipe)..where((tbl) => tbl.id.equals(id))).go()
  );

}

//Add IngredientDao here
@UseDao(tables:[MoorIngredient])
class IngredientDao extends DatabaseAccessor<RecipeDatabase> with _$IngredientDaoMixin {
  final RecipeDatabase db;

  IngredientDao(this.db) : super(db);

  Future<List<MoorIngredientData>> findAllIngredients() => select(moorIngredient).get();

  Stream<List<MoorIngredientData>> watchAllIngredients() => select(moorIngredient).watch();

  Future<List<MoorIngredientData>> findRecipeIngredients(int id) => (select(moorIngredient)..where((tbl) => tbl.recipeId.equals(id))).get();

  Future<int> insertIngredient(Insertable<MoorIngredientData> ingredient) => into(moorIngredient).insert(ingredient);

  Future deleteIngredient(int id) => Future.value((delete(moorIngredient)..where((tbl) => tbl.id.equals(id))).go());
}

//Add moorRecipeToRecipe here
// Conversion Methods
Recipe moorRecipeToRecipe(MoorRecipeData recipe) {
  return Recipe(
    id: recipe.id,
    label: recipe.label,
    image: recipe.image,
    url: recipe.url,
    calories: recipe.calories,
    totalWeight: recipe.totalWeight,
    totalTime: recipe.totalTime
  );
}

//Add MoorRecipeData here
Insertable<MoorRecipeData> recipeToInsertableMoorRecipe(Recipe recipe) {
  return MoorRecipeCompanion.insert(
      label: recipe.label ?? '',
      image: recipe.image ?? '',
      url: recipe.url ?? '',
      calories: recipe.calories ?? 0,
      totalWeight: recipe.totalWeight ?? 0,
      totalTime: recipe.totalTime ?? 0
  );
}

//Add moorIngredientToIngredient and MoorIngredientCompanion here
Ingredient moorIngredientToIngredient(MoorIngredientData ingredient) {
  return Ingredient(
      id: ingredient.id,
      recipeId: ingredient.recipeId,
      name: ingredient.name,
      weight: ingredient.weight);
}

MoorIngredientCompanion ingredientToInsertableMoorIngredient(Ingredient ingredient) {
  return MoorIngredientCompanion.insert(
      recipeId: ingredient.recipeId ?? 0,
      name: ingredient.name ?? '',
      weight: ingredient.weight ?? 0,
  );
}