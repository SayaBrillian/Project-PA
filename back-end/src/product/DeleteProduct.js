import express from "express";
import { db } from "../../db.js";

/*
|--------------------------------------------------------------------------
| DELETE PRODUCT
|--------------------------------------------------------------------------
*/

export const deleteProduct = async (req, res) => {
    try {

        const { id } = req.params;

        const result = await db.query(
            `
            UPDATE products
            SET

                is_active = false,
                updated_at = CURRENT_TIMESTAMP

            WHERE id = $1

            RETURNING *
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

            message: "Product berhasil dinonaktifkan",

            product: result.rows[0],

        });

    } catch (error) {

        res.status(500).json({

            success: false,

            message: error.message,

        });

    }

};