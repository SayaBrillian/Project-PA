import express from "express";
import { db } from "../../db.js";

/*
|--------------------------------------------------------------------------
| GET ALL PRODUCTS
|--------------------------------------------------------------------------
*/

export const getProducts = async (req, res) => {

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
            ORDER BY
                g.name ASC,
                p.display_order ASC,
                p.id ASC
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

};