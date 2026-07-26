import express from "express";
import { db } from "../../db.js";

/*
|--------------------------------------------------------------------------
| CREATE PRODUCT
|--------------------------------------------------------------------------
*/

export const createProduct = async (req, res) => {
    try {

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
            INSERT INTO products (

                game_id,
                name,
                slug,
                price,
                display_order,
                is_active

            )
            VALUES (

                $1,
                $2,
                $3,
                $4,
                $5,
                $6

            )
            RETURNING *
            `,
            [

                game_id,
                name,
                slug,
                price,
                display_order,
                is_active,

            ]
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

};