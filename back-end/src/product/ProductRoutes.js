import express from "express";

import { getProducts } from "./GetProducts.js";
import { getProductsByGame } from "./GetProductsByGame.js";
import { getProduct } from "./GetProduct.js";
import { createProduct } from "./CreateProduct.js";
import { updateProduct } from "./UpdateProduct.js";
import { deleteProduct } from "./DeleteProduct.js";

const router = express.Router();

/*
|--------------------------------------------------------------------------
| PRODUCTS
|--------------------------------------------------------------------------
*/

router.get(
    "/",
    getProducts
);

/*
|--------------------------------------------------------------------------
| PRODUCTS BY GAME
|--------------------------------------------------------------------------
*/

router.get(
    "/game/:gameId",
    getProductsByGame
);

/*
|--------------------------------------------------------------------------
| PRODUCT
|--------------------------------------------------------------------------
*/

router.get(
    "/:id",
    getProduct
);

/*
|--------------------------------------------------------------------------
| CREATE PRODUCT
|--------------------------------------------------------------------------
*/

router.post(
    "/",
    createProduct
);

/*
|--------------------------------------------------------------------------
| UPDATE PRODUCT
|--------------------------------------------------------------------------
*/

router.put(
    "/:id",
    updateProduct
);

/*
|--------------------------------------------------------------------------
| DELETE PRODUCT
|--------------------------------------------------------------------------
*/

router.delete(
    "/:id",
    deleteProduct
);

export default router;