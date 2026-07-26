import { db } from "../../db.js";

export const profileAdmin = async (req, res) => {

  try {

    const adminId = req.user.id;

    const result = await db.query(
      `
      SELECT
        id,
        name,
        username,
        email,
        role,
        created_at,
        updated_at
      FROM admins
      WHERE id = $1
      LIMIT 1
      `,
      [adminId]
    );

    if (result.rows.length === 0) {

      return res.status(404).json({
        success: false,
        message: "Admin tidak ditemukan",
      });

    }

    res.json({
      success: true,
      admin: result.rows[0],
    });

  } catch (error) {

    console.error("Profile Admin Error:", error);

    res.status(500).json({
      success: false,
      message: error.message,
    });

  }

};