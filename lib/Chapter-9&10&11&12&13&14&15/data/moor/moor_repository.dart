import 'dart:async';

import '../models/models.dart';
import '../repository.dart';
import 'moor_db.dart';

class MoorRepository extends Repository {

  late RecipeDatabase recipeDatabase;
  late RecipeDao _recipeDao;
  late IngredientDao _ingredientDao;
  Stream<List<Ingredient>>? ingredientStream;
  Stream<List<Recipe>>? recipeStream;

  //Add findAllRecipes()
  @override
  Future<List<Recipe>> findAllRecipes() {
    return _recipeDao.findAllRecipes().then<List<Recipe>>((List<MoorRecipeData> moorRecipes) {
      final recipes = <Recipe>[];
      moorRecipes.forEach((moorRecipe) async {
        final recipe = moorRecipeToRecipe(moorRecipe);
        if(recipe.id != null) {
          recipe.ingredients = await findRecipeIngredients(recipe.id!);
        }
        recipes.add(recipe);
      });
      return recipes;
    });
  }

  //Add watchAllRecipes()
  @override
  Stream<List<Recipe>> watchAllRecipes() {
    if(recipeStream == null) {
      recipeStream = _recipeDao.watchAllRecipes();
    }
    return recipeStream!;
  }


  //Add watchAllIngredients()
  @override
  Stream<List<Ingredient>> watchAllIngredients() {
    if(ingredientStream == null) {
      final stream = _ingredientDao.watchAllIngredients();
      ingredientStream = stream.map((moorIngredients) {
        final ingredients = <Ingredient>[];
        moorIngredients.forEach((moorIngredient) {
          ingredients.add(moorIngredientToIngredient(moorIngredient));
        });
        return ingredients;
      });
    }
    return ingredientStream!;
  }

  //Add findRecipeById()
  @override
  Future<Recipe> findRecipeById(int id) {
    return _recipeDao.findRecipeById(id).then((listOfRecipes) => moorRecipeToRecipe(listOfRecipes.first));
  }

  //Add findAllIngredients()
  @override
  Future<List<Ingredient>> findALlIngredients() {
    return _ingredientDao.findAllIngredients().then<List<Ingredient>>(
      (List<MoorIngredientData> moorIngredients) {
        final ingredients = <Ingredient>[];
        moorIngredients.forEach(
          (ingredient) {
            ingredients.add(moorIngredientToIngredient(ingredient));
          },
        );
        return ingredients;
      },
    );
  }

  //Add findRecipeIngredients()
  @override
  Future<List<Ingredient>> findRecipeIngredients(int recipeId) {
    return _ingredientDao.findRecipeIngredients(recipeId).then((listOfIngredients) {
      final ingredients = <Ingredient>[];
      listOfIngredients.forEach((ingredient) {
        ingredients.add(moorIngredientToIngredient(ingredient));
      });
      return ingredients;
    });
  }

  //Add insertRecipe()
  @override
  Future<int> insertRecipe(Recipe recipe) {
    return Future(() async {
      final id = await _recipeDao.insertRecipe(recipeToInsertableMoorRecipe(recipe));
      if(recipe.ingredients != null) {
        recipe.ingredients!.forEach((ingredient) {
          ingredient.recipeId = id;
        });
        insertIngredients(recipe.ingredients!);
      }
      return id;
    });
  }


  //Add insertIngredients()
  @override
  Future<List<int>> insertIngredients(List<Ingredient> ingredients) {
    return Future(() {
      if(ingredients.length == 0) {
        return <int>[];
      }
      final resultIds = <int>[];
      ingredients.forEach((ingredient) {
        final moorIngredient = ingredientToInsertableMoorIngredient(ingredient);
        _ingredientDao.insertIngredient(moorIngredient).then((int id) => resultIds.add(id));
      });
      return resultIds;
    });
  }

  //Add Delete methods
  @override
  Future<void> deleteRecipe(Recipe recipe) {
    if(recipe.id != null) {
      return _recipeDao.deleteRecipe(recipe.id!);
    }
    return Future.value();
  }

  @override
  Future<void> deleteIngredient(Ingredient ingredient) {
    if(ingredient.id != null) {
      return _ingredientDao.deleteIngredient(ingredient.id!);
    }else {
      return Future.value();
    }
  }

  @override
  Future<void> deleteIngredients(List<Ingredient> ingredients) {
    ingredients.forEach((ingredient) {
      if(ingredient.id != null) {
        _ingredientDao.deleteIngredient(ingredient.id!);
      }
    });
    return Future.value();
  }

  @override
  Future<void> deleteRecipeIngredients(int recipeId) async {
    final ingredients = await findRecipeIngredients(recipeId);
    return deleteIngredients(ingredients);
  }






  @override
  Future init() async {
    recipeDatabase = RecipeDatabase();
    _recipeDao = recipeDatabase.recipeDao;
    _ingredientDao = recipeDatabase.ingredientDao;
  }

  @override
  void close() {
    recipeDatabase.close();
  }

}