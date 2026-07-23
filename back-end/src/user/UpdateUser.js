import { db } from "../../db.js";

/*
|--------------------------------------------------------------------------
| UPDATE USER
|--------------------------------------------------------------------------
*/

export const updateUser = async (req, res) => {

    const { id } = req.params;

    const {
        name,
        username,
        birth_date,
        email,
        phone,
    } = req.body;

    try {

        const result = await db.query(
            `
      UPDATE users
      SET
        name = $1,
        username = $2,
        birth_date = $3,
        email = $4,
        phone = $5,
        updated_at = CURRENT_TIMESTAMP
      WHERE id = $6
      RETURNING
        id,
        name,
        username,
        birth_date,
        email,
        phone,
        created_at,
        updated_at
      `,
            [
                name,
                username,
                birth_date,
                email,
                phone,
                id,
            ]
        );

        if (result.rowCount === 0) {

            return res.status(404).json({
                success: false,
                message: "User tidak ditemukan.",
            });

        }

        res.json({
            success: true,
            message: "User berhasil diperbarui.",
            user: result.rows[0],
        });

    } catch (error) {

        console.error("Update User Error:", error);

        res.status(500).json({
            success: false,
            message: "Gagal memperbarui user.",
        });

    }

};