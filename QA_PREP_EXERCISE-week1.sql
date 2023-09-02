CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name TEXT
);

CREATE TABLE Ingredients (
    ingredient_id INT AUTO_INCREMENT PRIMARY KEY,
    ingredient_name TEXT
);

CREATE TABLE Steps (
    step_id INT AUTO_INCREMENT PRIMARY KEY,
    step_description TEXT
);

CREATE TABLE Recipes (
    recipe_id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_name TEXT,
    category_id INT,
    instructions TEXT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE RecipeIngredients (
    recipe_id INT,
    ingredient_id INT,
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredients(ingredient_id),
    PRIMARY KEY (recipe_id, ingredient_id)
);

CREATE TABLE RecipeSteps (
    recipe_id INT,
    step_id INT,
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id),
    FOREIGN KEY (step_id) REFERENCES Steps(step_id),
    PRIMARY KEY (recipe_id, step_id)
);

INSERT INTO Categories (category_name) VALUES ('Japanese'), ('Cake'), ('Vegetarian');

INSERT INTO Ingredients (ingredient_name) VALUES ('Rice'), ('Tofu'), ('Flour'), ('Sugar'), ('Eggs'), ('Vegetables');

INSERT INTO Steps (step_description) VALUES
    ('Cook rice according to package instructions.'),
    ('Cut tofu into cubes.'),
    ('Preheat the oven to 350°F (175°C).'),
    ('Mix flour and sugar in a bowl.'),
    ('Beat eggs and add to the flour-sugar mixture.'),
    ('Chop vegetables.');

INSERT INTO Recipes (recipe_name, category_id, instructions) VALUES
    ('Sushi Roll', 1, 'Roll sushi ingredients in seaweed.'),
    ('Tofu Stir-Fry', 3, 'Stir-fry tofu and vegetables in a pan.'),
    ('Chocolate Cake', 2, 'Mix ingredients and bake for 30 minutes.');

INSERT INTO RecipeIngredients (recipe_id, ingredient_id) VALUES
    (1, 1), (1, 2), (2, 2), (2, 6), (3, 3), (3, 4), (3, 5);

INSERT INTO RecipeSteps (recipe_id, step_id) VALUES
    (1, 1), (1, 6), (2, 2), (2, 6), (3, 4), (3, 5);

-- New Categories
INSERT IGNORE INTO Categories (category_name) VALUES ('No-Bake'), ('Vegan');

-- New Ingredients
INSERT IGNORE INTO Ingredients (ingredient_name)
VALUES ('Condensed Milk'), ('Cream Cheese'), ('Lemon Juice'), ('Pie Crust'), ('Cherry Jam'),
       ('Brussels Sprouts'), ('Lemon Juice'), ('Sesame Seeds'), ('Pepper'), ('Salt'), ('Olive Oil'),
       ('Macaroni'), ('Butter'), ('Flour'), ('Shredded Cheddar Cheese'), ('Soy Sauce'), ('Sugar'), ('Olive Oil');

-- New Steps
INSERT IGNORE INTO Steps (step_description) VALUES
    ('Beat Cream Cheese.'),
    ('Add condensed Milk and blend.'),
    ('Add Lemon Juice and blend.'),
    ('Add the mix to the pie crust.'),
    ('Spread the Cherry Jam.'),
    ('Place in refrigerator for 3 hours.'),
    ('Preheat the oven.'),
    ('Mix the ingredients in a bowl.'),
    ('Spread the mix on baking sheet.'),
    ('Bake for 30 minutes.'),
    ('Cook Macaroni for 8 minutes.'),
    ('Melt butter in a saucepan.'),
    ('Add flour, salt, pepper and mix.'),
    ('Add Milk and mix.'),
    ('Cook until mix is smooth.'),
    ('Add cheddar cheese.'),
    ('Add the macaroni.'),
    ('Beat the eggs.'),
    ('Add soy sauce, sugar, and salt.'),
    ('Add oil to a saucepan and bring to medium heat.'),
    ('Add some mix to the saucepan and let it cook for 1 minute.'),
    ('Add oil to a saucepan.'),
    ('Add some mix to the saucepan and let it cook for 1 minute.'),
    ('Remove pan from fire.');

-- New Recipes
INSERT INTO Recipes (recipe_name, category_id, instructions) VALUES
    ('No-Bake Cheesecake', 6, 'Beat Cream Cheese. Add condensed Milk and blend...'),
    ('Roasted Brussels Sprouts', 8, 'Preheat the oven. Mix the ingredients in a bowl...'),
    ('Mac & Cheese', 9, 'Cook Macaroni for 8 minutes. Melt butter in a saucepan...'),
    ('Tamagoyaki Japanese Omelette', 7, 'Beat the eggs. Add soy sauce, sugar, and salt...');

-- New Recipe Ingredients 
INSERT INTO RecipeIngredients (recipe_id, ingredient_id) VALUES
    (4, 32), (4, 31), (4, 30), (4, 29), (4, 33),
    (5, 34), (5, 35), (5, 36), (5, 37), (5, 38), (5, 39), (5, 40),
    (6, 41), (6, 28), (6, 27), (6, 26), (6, 38), (6, 25), (6, 42), (6, 43), (6, 44),
    (7, 8), (7, 37), (7, 36), (7, 35), (7, 34);

-- New Recipe Steps 
INSERT INTO RecipeSteps (recipe_id, step_id) VALUES
    (4, 32), (4, 33), (4, 34), (4, 35), (4, 36), (4, 37),
    (5, 38), (5, 39), (5, 40), (5, 41), (5, 42), (5, 43),
    (6, 44), (6, 45), (6, 46), (6, 47), (6, 48), (6, 49), (6, 50), (6, 51), (6, 52),
    (7, 53), (7, 54), (7, 55), (7, 56), (7, 57), (7, 58);


-- Queries

-- All the vegetarian recipes with potatoes:
SELECT DISTINCT r.recipe_name
FROM Recipes r
INNER JOIN RecipeIngredients ri ON r.recipe_id = ri.recipe_id
INNER JOIN Ingredients i ON ri.ingredient_id = i.ingredient_id
INNER JOIN Categories c ON r.category_id = c.category_id
WHERE c.category_name = 'Vegetarian' AND i.ingredient_name = 'Potatoes';


-- All the cakes that do not need baking:
SELECT r.recipe_name
FROM Recipes r
INNER JOIN Categories c ON r.category_id = c.category_id
INNER JOIN RecipeSteps rs ON r.recipe_id = rs.recipe_id
INNER JOIN Steps s ON rs.step_id = s.step_id
WHERE c.category_name = 'Cake' AND s.step_description NOT LIKE '%bake%';


-- All the vegan and Japanese recipes:

SELECT r.recipe_name
FROM Recipes r
INNER JOIN Categories c ON r.category_id = c.category_id
WHERE c.category_name = 'Vegan' AND c.category_name = 'Japanese';



/*

--* Week 3 (Prep Ex): *--

--* ===== Was your database already in 2NF / 3 NF? =====


--* 1. 2NF :

-- *Categories`, `Ingredients`, and `Steps`

their tables don't have partial dependencies, so they are already in 2NF. Each of them has a single candidate key.

--* `Recipes` 

the table has a partial dependency issue. The `instructions` column seems to be partially dependent on the entire primary key (recipe_id). To fix this, we can create a separate table for instructions and link it to recipes with the recipe_id as a foreign key.

--* `RecipeIngredients` and `RecipeSteps` 
their tables represent many-to-many relationships. They don't have partial dependencies.

--* 2. 3NF :


--* `Categories`, `Ingredients`, and `Steps`

their tables don't have transitive dependencies and are already in 3NF.

--* `Recipes` 

table, after addressing the partial dependency issue by creating a separate table for instructions, will be in 3NF.

--* `RecipeIngredients` and `RecipeSteps` 

their tables represent relationships and don't have transitive dependencies.

--* What changes did you have to do to normalize your database?

--* 1- Create a separate table for instructions:

Currently, the instructions attribute in the Recipes table has a partial dependency on the recipe_id primary key. To resolve this, I create a new table called RecipeInstructions to store instructions and link it to the Recipes table using a foreign key. 

--*2 Ensure data integrity:

To maintain data integrity, I can add appropriate constraints, such as NOT NULL and default values, to columns that should not be empty or need default values.

*/
