import bcrypt from "bcrypt";
import { db } from "../../db.js";

export const changePasswordUser = async (req, res) => {

    try {

        const userId = req.user.id;

        const {
            current_password,
            new_password,
        } = req.body;

        /*
        |--------------------------------------------------------------------------
        | VALIDATION
        |--------------------------------------------------------------------------
        */

        if (!current_password || !new_password) {

            return res.status(400).json({
                success: false,
                message: "Semua field wajib diisi.",
            });

        }

        if (new_password.length < 6) {

            return res.status(400).json({
                success: false,
                message: "Password baru minimal 6 karakter.",
            });

        }

        /*
        |--------------------------------------------------------------------------
        | GET CURRENT PASSWORD
        |--------------------------------------------------------------------------
        */

        const userResult = await db.query(
            `
            SELECT password
            FROM users
            WHERE id = $1
            `,
            [userId]
        );

        if (userResult.rows.length === 0) {

            return res.status(404).json({
                success: false,
                message: "User tidak ditemukan.",
            });

        }

        /*
        |--------------------------------------------------------------------------
        | CHECK CURRENT PASSWORD
        |--------------------------------------------------------------------------
        */

        const validPassword = await bcrypt.compare(
            current_password,
            userResult.rows[0].password
        );

        if (!validPassword) {

            return res.status(400).json({
                success: false,
                message: "Password lama tidak sesuai.",
            });

        }

        /*
        |--------------------------------------------------------------------------
        | HASH NEW PASSWORD
        |--------------------------------------------------------------------------
        */

        const hashedPassword = await bcrypt.hash(
            new_password,
            10
        );

        /*
        |--------------------------------------------------------------------------
        | UPDATE PASSWORD
        |--------------------------------------------------------------------------
        */

        await db.query(
            `
            UPDATE users
            SET
                password = $1,
                updated_at = CURRENT_TIMESTAMP
            WHERE id = $2
            `,
            [
                hashedPassword,
                userId,
            ]
        );

        return res.json({
            success: true,
            message: "Password berhasil diperbarui.",
        });

    } catch (error) {

        console.error("Change Password User Error:", error);

        return res.status(500).json({
            success: false,
            message: error.message,
        });

    }

};