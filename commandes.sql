-- 1 Afficher toutes les recettes disponibles
-- (nom de la recette, catégorie et temps de préparation)
-- triées de façon décroissante sur la durée de réalisation
    SELECT recipe.recipe_name, recipe.preparation_time, category.category_name
    FROM recipe
    INNER JOIN category
    ON recipe.id_category = category.id_category
    ORDER BY preparation_time DESC;

-- 2- En modifiant la requête précédente,
-- faites apparaître le nombre d’ingrédients nécessaire par recette.
    SELECT recipe.id_recipe, recipe.recipe_name, COUNT(recipe_ingredients.id_ingredient) AS nbIngredients
    FROM recipe
    INNER JOIN recipe_ingredients
    ON recipe.id_recipe = recipe_ingredients.id_recipe
    GROUP BY recipe.id_recipe
    ORDER BY nbIngredients DESC;


-- 3- Afficher les recettes qui nécessitent au moins 30 min de préparation
    SELECT recipe.recipe_name, recipe.preparation_time
    FROM recipe
    WHERE preparation_time >= 30;

-- 4- Afficher les recettes dont le nom contient le mot « Salade »
-- (peu importe où est situé le mot en question)
    SELECT recipe_name FROM recipe
    WHERE LOWER(recipe_name)
    LIKE '%salade%';

-- 5- Insérer une nouvelle recette :
-- « Pâtes à la carbonara » dont la durée de réalisation est de 20 min avec 
-- les instructions de votre choix.
-- Pensez à alimenter votre base de données en conséquence afin de 
-- pouvoir lister les détails de cette recettes (ingrédients)
    INSERT INTO recipe (recipe_name, preparation_time, instructions, id_category)
    VALUES ('Pâtes à la carbonara', 20, 'Preparer, manger.', 2);

-- 6- Modifier le nom de la recette ayant comme identifiant
-- id_recette = 3 (nom de la recette à votre convenance)
    UPDATE recipe
    SET recipe_name = 'Nouvelle recette'
    WHERE id_recipe = 3;

-- 7- Supprimer la recette n°2 de la base de données
    DELETE FROM recipe_ingredients
    WHERE id_recipe = 2;

    DELETE FROM recipe
    WHERE id_recipe = 2;

-- 8- Afficher le prix total de la recette n°5
    SELECT recipe.recipe_name, SUM(ingredient.price)
    FROM recipe
    INNER JOIN recipe_ingredients AS ri
    ON recipe.id_recipe = ri.id_recipe
    INNER JOIN ingredient
    ON ri.id_ingredient = ingredient.id_ingredient
    WHERE recipe.id_recipe = 5;

-- 9- Afficher le détail de la recette n°5 (liste des ingrédients, quantités et prix)
    SELECT recipe_ingredients.quantity, recipe_ingredients.unit, ingredient.ingredient_name, ingredient.price
    FROM recipe
    INNER JOIN recipe_ingredients
    ON recipe.id_recipe = recipe_ingredients.id_recipe
    INNER JOIN ingredient
    ON recipe_ingredients.id_ingredient = ingredient.id_ingredient
    WHERE recipe.id_recipe = 5;

-- 10- Ajouter un ingrédient en base de données : Poivre, unité : cuillère à café, prix : 2.5 €
    INSERT INTO ingredient (ingredient_name,price)
    VALUES ('Poivre', 2.5);

-- 11- Modifier le prix de l’ingrédient n°12 (prix à votre convenance)
    UPDATE ingredient
    SET price = 4
    WHERE id_ingredient = 12;

-- 12- Afficher le nombre de recettes par catégories : X entrées, Y plats, Z desserts
    SELECT category.category_name, COUNT(recipe.id_recipe) AS recipe_count
    FROM recipe
    INNER JOIN category ON recipe.id_category = category.id_category
    GROUP BY category.category_name;

-- 13- Afficher les recettes qui contiennent l’ingrédient « Poulet »
    SELECT recipe.recipe_name
    FROM recipe
    INNER JOIN recipe_ingredients AS ri
    ON recipe.id_recipe = ri.id_recipe
    INNER JOIN ingredient
    ON ri.id_ingredient = ingredient.id_ingredient
    WHERE LOWER(ingredient.ingredient_name) = 'poulet';

-- 14- Mettez à jour toutes les recettes en diminuant leur temps de préparation de 5 minutes 
    UPDATE recipe
    SET preparation_time = (preparation_time - 5);

-- 15- Afficher les recettes qui ne nécessitent
-- pas d’ingrédients coûtant plus de 2€ par unité de mesure
    SELECT recipe_name
    FROM recipe
    WHERE id_recipe
    NOT IN (
        SELECT recipe_ingredients.id_recipe
        FROM recipe_ingredients
        INNER JOIN ingredient
        ON recipe_ingredients.id_ingredient = ingredient.id_ingredient
        WHERE ingredient.price > 2
    );

-- 16- Afficher la / les recette(s) les plus rapides à préparer
    SELECT recipe_name, preparation_time as min_prep
    FROM recipe
    GROUP BY recipe_name
    HAVING min_prep = ( -- HAVING a le même rôle que WHERE mais s'utilise pour les fonctions d'agrégation
        SELECT MIN(preparation_time)
        FROM recipe
    );

-- 17- Trouver les recettes qui ne nécessitent aucun ingrédient
-- (par exemple la recette de la tasse d’eau chaude qui consiste à verser de l’eau chaude dans une tasse)
    SELECT recipe_name
    FROM recipe
    WHERE id_recipe
    NOT IN (
        SELECT id_recipe
        FROM recipe_ingredients
    );

-- 18- Trouver les ingrédients qui sont utilisés dans au moins 3 recettes
    SELECT ingredient_name, COUNT(*) As nbRecettes
    FROM ingredient
    INNER JOIN recipe_ingredients ON ingredient.id_ingredient = recipe_ingredients.id_ingredient
    GROUP BY ingredient.id_ingredient
    HAVING nbRecettes >= 3;
    -- WHERE id_ingredient
    -- IN (
    --     SELECT id_ingredient
    --     FROM recipe_ingredients
    --     GROUP BY id_ingredient
    --     HAVING COUNT(id_ingredient) >= 3 
    -- );

-- 19- Ajouter un nouvel ingrédient à une recette spécifique
    INSERT INTO recipe_ingredients (quantity, unit, id_recipe, id_ingredient)
    VALUES (100, 'grammes', 1, 2);

-- 20- Bonus : Trouver la recette la plus coûteuse de la base de données
-- (il peut y avoir des ex aequo, il est donc exclu d’utiliser la clause LIMIT)
    SELECT r.recipe_name, SUM(i.price)
    FROM recipe as r
    INNER JOIN recipe_ingredients as ri
    ON r.id_recipe = ri.id_recipe
    INNER JOIN ingredient as i
    ON ri.id_ingredient = i.id_ingredient
    GROUP BY r.recipe_name
    HAVING SUM(i.price) >= ALL (
        SELECT SUM(ingredient.price) as total_price
        FROM recipe
        INNER JOIN recipe_ingredients AS ri
        ON recipe.id_recipe = ri.id_recipe
        INNER JOIN ingredient
        ON ri.id_ingredient = ingredient.id_ingredient
        GROUP BY recipe.id_recipe
    );