import { db } from "../../db.js";

/*
|--------------------------------------------------------------------------
| GET ADMINS
|--------------------------------------------------------------------------
*/

export const getAdmins = async (req, res) => {

    try {

        const result = await db.query(`
      SELECT
        id,
        name,
        username,
        birth_date,
        email,
        phone,
        role,
        created_at,
        updated_at
      FROM admins
      ORDER BY id DESC
    `);

        res.json({
            success: true,
            admins: result.rows,
        });

    } catch (error) {

        console.error("Get Admins Error:", error);

        res.status(500).json({
            success: false,
            message: "Gagal mengambil data admin.",
        });

    }

};