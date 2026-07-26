import express from "express";
import { db } from "../../db.js";

/*
|--------------------------------------------------------------------------
| UPDATE PRODUCT
|--------------------------------------------------------------------------
*/

export const updateProduct = async (req, res) => {
    try {

        const { id } = req.params;

        const {

            game_id,
            name,
            slug,
            price,
            display_order,
            is_active,

        } = req.body;

        const result = await db.query(
            `
            UPDATE products
            SET

                game_id = $1,
                name = $2,
                slug = $3,
                price = $4,
                display_order = $5,
                is_active = $6,
                updated_at = CURRENT_TIMESTAMP

            WHERE id = $7

            RETURNING *
            `,
            [

                game_id,
                name,
                slug,
                price,
                display_order,
                is_active,
                id,

            ]
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