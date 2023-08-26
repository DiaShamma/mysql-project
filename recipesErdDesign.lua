+--------------+        +------------------+
| Categories   |        | Ingredients      |
+--------------+        +------------------+
| category_id  |<-------| ingredient_id    |
| category_name|        | ingredient_name  |
+--------------+        +------------------+
      |                          ^
      |                          |
      v                          |
+--------------+        +------------------+
| Recipes      |        | Steps            |
+--------------+        +------------------+
| recipe_id    |<---+   | step_id          |
| recipe_name  |    |   | step_description |
| category_id  |----+   +------------------+
| instructions |
+--------------+
      |
      v
+------------------+
| RecipeIngredients|
+------------------+
| recipe_id        |
| ingredient_id    |
+------------------+
      |
      v
+------------------+
| RecipeSteps      |
+------------------+
| recipe_id        |
| step_id          |
+------------------+
