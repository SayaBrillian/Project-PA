import { db } from "../../db.js";

export const updateProfileAdmin = async (req, res) => {

    try {

        const adminId = req.user.id;

        const {
            name,
            username,
            email,
            phone,
            birth_date,
        } = req.body;

        const result = await db.query(
            `
      UPDATE admins
      SET
        name = $1,
        username = $2,
        email = $3,
        phone = $4,
        birth_date = $5,
        updated_at = CURRENT_TIMESTAMP
      WHERE id = $6
      RETURNING
        id,
        name,
        username,
        email,
        phone,
        birth_date,
        role,
        created_at,
        updated_at
      `,
            [
                name,
                username,
                email,
                phone,
                birth_date,
                adminId,
            ]
        );

        if (result.rows.length === 0) {

            return res.status(404).json({
                success: false,
                message: "Admin tidak ditemukan",
            });

        }

        res.json({
            success: true,
            message: "Profile berhasil diperbarui.",
            admin: result.rows[0],
        });

    } catch (error) {

        console.error("Update Profile Error:", error);

        res.status(500).json({
            success: false,
            message: error.message,
        });

    }

};