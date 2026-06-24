import express from "express";
import { db } from "./db.js";

const router = express.Router();

/*
|--------------------------------------------------------------------------
| GET ALL GAMES
|--------------------------------------------------------------------------
*/

router.get("/", async (req, res) => {
    try {

        const result = await db.query(
            `
      SELECT *
      FROM games
      ORDER BY id
      `
        );

        res.json({
            success: true,
            games: result.rows,
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
| GET GAME BY SLUG
|--------------------------------------------------------------------------
*/

router.get("/:slug", async (req, res) => {
    try {

        const { slug } = req.params;

        const result = await db.query(
            `
      SELECT *
      FROM games
      WHERE slug = $1
      `,
            [slug]
        );

        if (result.rows.length === 0) {
            return res.status(404).json({
                success: false,
                message: "Game tidak ditemukan",
            });
        }

        res.json({
            success: true,
            game: result.rows[0],
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
| CREATE GAME
|--------------------------------------------------------------------------
*/

router.post("/", async (req, res) => {
    try {

        const {
            name,
            slug,
            game_key,
            description,
            official_url,
            patchnote_url,
            latest_patch,
            latest_update,
            publisher
        } = req.body;

        const result = await db.query(
            `
      INSERT INTO games (
        name,
        slug,
        game_key,
        description,
        official_url,
        patchnote_url,
        latest_patch,
        latest_update,
        publisher
      )
      VALUES (
        $1,$2,$3,$4,$5,$6,$7,$8,$9
      )
      RETURNING *
      `,
            [
                name,
                slug,
                game_key,
                description,
                official_url,
                patchnote_url,
                latest_patch,
                latest_update,
                publisher
            ]
        );

        res.status(201).json({
            success: true,
            game: result.rows[0],
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
| UPDATE GAME
|--------------------------------------------------------------------------
*/

router.put("/:id", async (req, res) => {
    try {

        const { id } = req.params;

        const {
            name,
            slug,
            game_key,
            publisher,
            description,
            official_url,
            patchnote_url,
            latest_patch,
            latest_update
        } = req.body;

        const result = await db.query(
            `
            UPDATE games
            SET
                name = $1,
                slug = $2,
                game_key = $3,
                publisher = $4,
                description = $5,
                official_url = $6,
                patchnote_url = $7,
                latest_patch = $8,
                latest_update = $9,
                updated_at = CURRENT_TIMESTAMP
            WHERE id = $10
            RETURNING *
            `,
            [
                name,
                slug,
                game_key,
                publisher,
                description,
                official_url,
                patchnote_url,
                latest_patch,
                latest_update,
                id
            ]
        );

        res.json({
            success: true,
            game: result.rows[0],
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
| DELETE GAME
|--------------------------------------------------------------------------
*/

router.delete("/:id", async (req, res) => {
    try {

        const { id } = req.params;

        await db.query(
            `
      UPDATE games
      SET is_active = false
      WHERE id = $1
      `,
            [id]
        );

        res.json({
            success: true,
            message: "Game dinonaktifkan",
        });

    } catch (error) {
        res.status(500).json({
            success: false,
            message: error.message,
        });
    }
});

router.get("/:id/servers", async (req, res) => {
  try {

    const { id } = req.params;

    const result = await db.query(
      `
      SELECT *
      FROM game_servers
      WHERE game_id = $1
      ORDER BY display_order
      `,
      [id]
    );

    res.json({
      success: true,
      servers: result.rows,
    });

  } catch (error) {

    res.status(500).json({
      success: false,
      message: error.message,
    });

  }
});
export default router;