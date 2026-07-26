import bcrypt from "bcrypt";
import { db } from "../../db.js";

export const changePasswordAdmin = async (req, res) => {

    try {

        const adminId = req.user.id;

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

        const adminResult = await db.query(
            `
            SELECT password
            FROM admins
            WHERE id = $1
            `,
            [adminId]
        );

        if (adminResult.rows.length === 0) {

            return res.status(404).json({
                success: false,
                message: "Admin tidak ditemukan.",
            });

        }

        /*
        |--------------------------------------------------------------------------
        | CHECK CURRENT PASSWORD
        |--------------------------------------------------------------------------
        */

        const validPassword = await bcrypt.compare(
            current_password,
            adminResult.rows[0].password
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
            UPDATE admins
            SET
                password = $1,
                updated_at = CURRENT_TIMESTAMP
            WHERE id = $2
            `,
            [
                hashedPassword,
                adminId,
            ]
        );

        return res.json({
            success: true,
            message: "Password berhasil diperbarui.",
        });

    } catch (error) {

        console.error(error);

        return res.status(500).json({
            success: false,
            message: error.message,
        });

    }

};