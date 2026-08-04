import { db } from "../../db.js";

/*
|--------------------------------------------------------------------------
| GET PRODUCTS BY GAME
|--------------------------------------------------------------------------
*/

export const getProductsByGame = async (req, res) => {

    try {

        const { gameId } = req.params;

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
                p.game_id = $1
                AND p.is_active = true
            ORDER BY
                p.display_order ASC,
                p.id ASC
            `,
            [gameId]

        );

        res.json({

            success: true,

            products: result.rows,

        });

    } catch (error) {

        console.error(error);

        res.status(500).json({

            success: false,

            message: error.message,

        });

    }

};