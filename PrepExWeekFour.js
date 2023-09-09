const { MongoClient } = require('mongodb');

// Connection URL and Database Name
const url = 'mongodb://localhost:27017';
const dbName = 'your_database_name';

// Create a new MongoClient
const client = new MongoClient(url, { useUnifiedTopology: true });

// Sample data
const categoriesData = [
  { category_name: 'Japanese' },
  { category_name: 'Cake' },
  { category_name: 'Vegetarian' },
  { category_name: 'No-Bake' },
  { category_name: 'Vegan' },
];

const ingredientsData = [
  { ingredient_name: 'Rice' },
  { ingredient_name: 'Tofu' },
  { ingredient_name: 'Flour' },
  { ingredient_name: 'Sugar' },
  { ingredient_name: 'Eggs' },
  { ingredient_name: 'Vegetables' },
  { ingredient_name: 'Condensed Milk' },
  // ... Rest of the ingredients
];

const stepsData = [
  { step_description: 'Cook rice according to package instructions.' },
  { step_description: 'Cut tofu into cubes.' },
  { step_description: 'Preheat the oven to 350°F (175°C).' },
  { step_description: 'Mix flour and sugar in a bowl.' },
  { step_description: 'Beat eggs and add to the flour-sugar mixture.' },
  { step_description: 'Chop vegetables.' },
  { step_description: 'Beat Cream Cheese.' },
  // ...The rest of   all other steps
];

const recipesData = [
  {
    recipe_name: 'Sushi Roll',
    category_id: 1,
    instructions: [
      { step_description: 'Cook rice according to package instructions.' },
      { step_description: 'Roll sushi ingredients in seaweed.' },
    ],
  },
  {
    recipe_name: 'Tofu Stir-Fry',
    category_id: 3,
    instructions: [
      { step_description: 'Cut tofu into cubes.' },
      { step_description: 'Stir-fry tofu and vegetables in a pan.' },
    ],
  },
  {
    recipe_name: 'Chocolate Cake',
    category_id: 2,
    instructions: [
      { step_description: 'Mix ingredients and bake for 30 minutes.' },
    ],
  },
  {
    recipe_name: 'No-Bake Cheesecake',
    category_id: 4,
    instructions: [
      { step_description: 'Beat Cream Cheese.' },
      { step_description: 'Add condensed Milk and blend...' },
      // ... The rest of steps for this recipe
    ],
  },
  {
    recipe_name: 'Roasted Brussels Sprouts',
    category_id: 5,
    instructions: [
      { step_description: 'Preheat the oven.' },
      { step_description: 'Mix the ingredients in a bowl...' },
      // ... The rest of steps for this recipe
    ],
  },
  {
    recipe_name: 'Mac & Cheese',
    category_id: 6,
    instructions: [
      { step_description: 'Cook Macaroni for 8 minutes.' },
      { step_description: 'Melt butter in a saucepan...' },
      // ... The rest of steps for this recipe
    ],
  },
  {
    recipe_name: 'Tamagoyaki Japanese Omelette',
    category_id: 7,
    instructions: [
      { step_description: 'Beat the eggs.' },
      { step_description: 'Add soy sauce, sugar, and salt...' },
      // ... The rest of steps for this recipe
    ],
  },
];

// Connect to the MongoDB server
async function main() {
  try {
    await client.connect();
    console.log('Connected to MongoDB');

    // Access the database
    const db = client.db(dbName);

    // Define collections
    const categories = db.collection('Categories');
    const ingredients = db.collection('Ingredients');
    const steps = db.collection('Steps');
    const recipes = db.collection('Recipes');
    const recipeIngredients = db.collection('RecipeIngredients');
    const recipeCategories = db.collection('RecipeCategories');

    // Insert data into collections
    await categories.insertMany(categoriesData);
    await ingredients.insertMany(ingredientsData);
    await steps.insertMany(stepsData);
    await recipes.insertMany(recipesData);

    console.log('Data inserted successfully.');

  } catch (err) {
    console.error('Error:', err);
  } finally {
    // Close the MongoDB connection when done
    client.close();
  }
}

// Call the main function to start the interaction with the database
main();


/*
//* What are the collections?

In the MongoDB-based document model, the collections are structured as follows:

categories: Stores information about recipe categories.
ingredients: Stores information about ingredients.
steps: Stores information about cooking steps.
recipes: Stores information about recipes, including embedded instructions.
recipeIngredients: Represents the many-to-many relationship between recipes and ingredients.
recipeCategories: Represents the many-to-many relationship between recipes and categories.



//* What information will you embed in a document and which will you store normalized?

Embedded in a document:
Instructions for recipes are embedded within the recipes collection as an array of documents. This denormalization optimizes read operations
*/