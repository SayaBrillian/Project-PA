import express from "express";
import { db } from "./db.js";

const router = express.Router();

/*
|--------------------------------------------------------------------------
| REGISTER USER
|--------------------------------------------------------------------------
*/

router.post("/register", async (req, res) => {
  try {
    const { name, email, password } = req.body;

    const result = await db.query(
      `
      INSERT INTO users (
        name,
        email,
        password
      )
      VALUES ($1, $2, $3)
      RETURNING *
      `,
      [name, email, password],
    );

    res.status(201).json({
      success: true,
      user: result.rows[0],
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
});

/*
|--------------------------------------------------------------------------
| LOGIN USER
|--------------------------------------------------------------------------
*/

router.post("/login-user", async (req, res) => {
  try {
    const { email, password } = req.body;

    const result = await db.query(
      `
      SELECT *
      FROM users
      WHERE email = $1
      AND password = $2
      `,
      [email, password],
    );

    if (result.rows.length === 0) {
      return res.status(401).json({
        success: false,
        message: "Email atau password salah",
      });
    }

    res.json({
      success: true,
      user: result.rows[0],
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
});

/*
|--------------------------------------------------------------------------
| LOGIN ADMIN
|--------------------------------------------------------------------------
*/

router.post("/login-admin", async (req, res) => {
  try {
    const { email, password } = req.body;

    const result = await db.query(
      `
      SELECT *
      FROM admins
      WHERE email = $1
      AND password = $2
      `,
      [email, password],
    );

    if (result.rows.length === 0) {
      return res.status(401).json({
        success: false,
        message: "Email atau password salah",
      });
    }

    res.json({
      success: true,
      admin: result.rows[0],
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
});

export default router;
