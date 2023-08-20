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
