import { db } from "../../db.js";

export const profileUser = async (req, res) => {

  try {

    const userId = req.user.id;

    const result = await db.query(
      `
            SELECT
                id,
                name,
                username,
                email,
                phone,
                birth_date,
                created_at,
                updated_at
            FROM users
            WHERE id = $1
            LIMIT 1
            `,
      [userId]
    );

    if (result.rows.length === 0) {

      return res.status(404).json({
        success: false,
        message: "User tidak ditemukan.",
      });

    }

    return res.json({
      success: true,
      user: result.rows[0],
    });

  } catch (error) {

    console.error("Profile User Error:", error);

    return res.status(500).json({
      success: false,
      message: error.message,
    });

  }

};