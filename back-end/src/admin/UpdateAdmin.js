import { db } from "../../db.js";

/*
|--------------------------------------------------------------------------
| UPDATE ADMIN
|--------------------------------------------------------------------------
*/

export const updateAdmin = async (req, res) => {

    const { id } = req.params;

    const {
        name,
        username,
        birth_date,
        email,
        phone,
        role,
    } = req.body;

    try {

        const result = await db.query(
            `
      UPDATE admins
      SET
        name = $1,
        username = $2,
        birth_date = $3,
        email = $4,
        phone = $5,
        role = $6,
        updated_at = CURRENT_TIMESTAMP
      WHERE id = $7
      RETURNING
        id,
        name,
        username,
        birth_date,
        email,
        phone,
        role,
        created_at,
        updated_at
      `,
            [
                name,
                username,
                birth_date,
                email,
                phone,
                role,
                id,
            ]
        );

        if (result.rowCount === 0) {

            return res.status(404).json({
                success: false,
                message: "Admin tidak ditemukan.",
            });

        }

        res.json({
            success: true,
            message: "Admin berhasil diperbarui.",
            admin: result.rows[0],
        });

    } catch (error) {

        console.error("Update Admin Error:", error);

        res.status(500).json({
            success: false,
            message: "Gagal memperbarui admin.",
        });

    }

};