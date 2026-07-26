import express from "express";
import { db } from "../../db.js";

/*
|--------------------------------------------------------------------------
| GET PRODUCT BY ID
|--------------------------------------------------------------------------
*/

export const getProduct = async (req, res) => {

    try {

        const { id } = req.params;

        const result = await db.query(
            `
            SELECT
                p.*,
                g.name AS game_name,
                g.slug AS game_slug
            FROM products p
            JOIN games g
                ON g.id = p.game_id
            WHERE
                p.id = $1
            `,
            [id]
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

};