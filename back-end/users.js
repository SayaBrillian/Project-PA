import express from "express";
import { db } from "./db.js";

const router = express.Router();

/*
|--------------------------------------------------------------------------
| GET ALL USERS
|--------------------------------------------------------------------------
*/

router.get("/", async (req, res) => {
    try {

        const result = await db.query(
            `
      SELECT
        id,
        name,
        email,
        created_at
      FROM users
      ORDER BY id DESC
      `
        );

        res.json({
            success: true,
            users: result.rows,
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
| GET USER BY ID
|--------------------------------------------------------------------------
*/

router.get("/:id", async (req, res) => {
    try {

        const { id } = req.params;

        const result = await db.query(
            `
      SELECT
        id,
        name,
        email,
        created_at
      FROM users
      WHERE id = $1
      `,
            [id]
        );

        if (result.rows.length === 0) {
            return res.status(404).json({
                success: false,
                message: "User tidak ditemukan",
            });
        }

        res.json({
            success: true,
            user: result.rows[0],
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
| UPDATE USER
|--------------------------------------------------------------------------
*/

router.put("/:id", async (req, res) => {
    try {

        const { id } = req.params;

        const {
            name,
            email,
        } = req.body;

        const result = await db.query(
            `
      UPDATE users
      SET
        name = $1,
        email = $2
      WHERE id = $3
      RETURNING
        id,
        name,
        email,
        created_at
      `,
            [
                name,
                email,
                id,
            ]
        );

        if (result.rows.length === 0) {

            return res.status(404).json({
                success: false,
                message: "User tidak ditemukan",
            });

        }

        res.json({
            success: true,
            user: result.rows[0],
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
| DELETE USER
|--------------------------------------------------------------------------
*/

router.delete("/:id", async (req, res) => {
    try {

        const { id } = req.params;

        const result = await db.query(
            `
      DELETE
      FROM users
      WHERE id = $1
      RETURNING id
      `,
            [id]
        );

        if (result.rows.length === 0) {

            return res.status(404).json({
                success: false,
                message: "User tidak ditemukan",
            });

        }

        res.json({
            success: true,
            message: "User berhasil dihapus",
        });

    } catch (error) {

        res.status(500).json({
            success: false,
            message: error.message,
        });

    }
});

export default router;