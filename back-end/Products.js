import express from "express";
import { db } from "./db.js";

const router = express.Router();

/*
|--------------------------------------------------------------------------
| GET ALL PRODUCTS
|--------------------------------------------------------------------------
*/

router.get("/", async (req, res) => {
    try {
        const result = await db.query(`
      SELECT
  p.*,
  g.name AS game_name,
  g.slug AS game_slug
FROM products p
JOIN games g
  ON g.id = p.game_id
WHERE p.is_active = true
ORDER BY p.id
    `);

        res.json({
            success: true,
            products: result.rows,
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: error.message,
        });
    }
});

/*
|--------------------------------------------------------------------------
| GET PRODUCTS BY GAME
|--------------------------------------------------------------------------
*/

router.get("/game/:gameId", async (req, res) => {
    try {
        const { gameId } = req.params;

        const result = await db.query(
            `
      SELECT *
FROM products
WHERE game_id = $1
AND is_active = true
ORDER BY display_order
      `,
            [gameId],
        );

        res.json({
            success: true,
            products: result.rows,
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: error.message,
        });
    }
});

/*
|--------------------------------------------------------------------------
| GET PRODUCT BY ID
|--------------------------------------------------------------------------
*/

router.get("/:id", async (req, res) => {
    try {
        const { id } = req.params;

        const result = await db.query(
            `
      SELECT *
      FROM products
      WHERE id = $1
      `,
            [id],
        );

        if (result.rows.length === 0) {
            return res.status(404).json({
                success: false,
                message: "Product tidak ditemukan",
            });
        }

        res.json({
            success: true,
            product: result.rows[0],
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: error.message,
        });
    }
});

/*
|--------------------------------------------------------------------------
| CREATE PRODUCT
|--------------------------------------------------------------------------
*/

router.post("/", async (req, res) => {
    try {
        const { game_id, name, slug, currency_amount, price, display_order } =
            req.body;

        const result = await db.query(
            `
      INSERT INTO products (
        game_id,
        name,
        slug,
        currency_amount,
        price,
        display_order
      )
      VALUES (
        $1,$2,$3,$4,$5,$6
      )
      RETURNING *
      `,
            [game_id, name, slug, currency_amount, price, display_order],
        );

        res.status(201).json({
            success: true,
            product: result.rows[0],
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: error.message,
        });
    }
});

/*
|--------------------------------------------------------------------------
| UPDATE PRODUCT
|--------------------------------------------------------------------------
*/

router.put("/:id", async (req, res) => {
    try {
        const { id } = req.params;

        const { name, price, currency_amount, is_active } = req.body;

        const result = await db.query(
            `
      UPDATE products
      SET
        name = $1,
        price = $2,
        currency_amount = $3,
        is_active = $4,
        updated_at = CURRENT_TIMESTAMP
      WHERE id = $5
      RETURNING *
      `,
            [name, price, currency_amount, is_active, id],
        );

        res.json({
            success: true,
            product: result.rows[0],
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: error.message,
        });
    }
});

/*
|--------------------------------------------------------------------------
| DELETE PRODUCT
|--------------------------------------------------------------------------
*/

router.delete("/:id", async (req, res) => {
    try {
        const { id } = req.params;

        await db.query(
            `
      UPDATE products
      SET is_active = false
      WHERE id = $1
      `,
            [id],
        );

        res.json({
            success: true,
            message: "Product dinonaktifkan",
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: error.message,
        });
    }
});

export default router;
