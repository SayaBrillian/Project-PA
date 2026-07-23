import { db } from "../../db.js";
/*
|--------------------------------------------------------------------------
| GET USERS
|--------------------------------------------------------------------------
*/

export const getUsers = async (req, res) => {

    try {

        const result = await db.query(`
      SELECT
        id,
        name,
        username,
        birth_date,
        email,
        phone,
        created_at,
        updated_at
      FROM users
      ORDER BY id DESC
    `);

        res.json({
            success: true,
            users: result.rows,
        });

    } catch (error) {

        console.error("Get Users Error:", error);

        res.status(500).json({
            success: false,
            message: "Gagal mengambil data user.",
        });

    }

};