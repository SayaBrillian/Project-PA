import express from "express";
import { db } from "./db.js";

const router = express.Router();

/*
|--------------------------------------------------------------------------
| GET ALL ADMINS
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
        level,
        created_at
      FROM admins
      ORDER BY level DESC, id DESC
      `
        );

        res.json({
            success: true,
            admins: result.rows,
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
| GET ADMIN BY ID
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
        level,
        created_at
      FROM admins
      WHERE id = $1
      `,
            [id]
        );

        if (result.rows.length === 0) {

            return res.status(404).json({
                success: false,
                message: "Admin tidak ditemukan",
            });

        }

        res.json({
            success: true,
            admin: result.rows[0],
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
| UPDATE ADMIN
|--------------------------------------------------------------------------
*/

router.put("/:id", async (req, res) => {
    try {

        const { id } = req.params;

        const {
            name,
            email,
            level,
        } = req.body;

        const result = await db.query(
            `
      UPDATE admins
      SET
        name = $1,
        email = $2,
        level = $3
      WHERE id = $4
      RETURNING
        id,
        name,
        email,
        level,
        created_at
      `,
            [
                name,
                email,
                level,
                id,
            ]
        );

        if (result.rows.length === 0) {

            return res.status(404).json({
                success: false,
                message: "Admin tidak ditemukan",
            });

        }

        res.json({
            success: true,
            admin: result.rows[0],
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
| DELETE ADMIN
|--------------------------------------------------------------------------
*/

router.delete("/:id", async (req, res) => {
    try {

        const { id } = req.params;

        const result = await db.query(
            `
      DELETE
      FROM admins
      WHERE id = $1
      RETURNING id
      `,
            [id]
        );

        if (result.rows.length === 0) {

            return res.status(404).json({
                success: false,
                message: "Admin tidak ditemukan",
            });

        }

        res.json({
            success: true,
            message: "Admin berhasil dihapus",
        });

    } catch (error) {

        res.status(500).json({
            success: false,
            message: error.message,
        });

    }
});

export default router;