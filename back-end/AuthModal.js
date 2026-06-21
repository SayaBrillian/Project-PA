import bcrypt from "bcrypt";
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
    const hashedPassword = await bcrypt.hash(password, 10);

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
      [name, email, hashedPassword],
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
| REGISTER USER
|--------------------------------------------------------------------------
*/

router.post("/register-admin", async (req, res) => {
  try {
   const { name, email, password, level } = req.body;

    const hashedPassword = await bcrypt.hash(password, 10);

    const result = await db.query(
      `
      INSERT INTO admins (
        name,
        email,
        password,
        level
      )
      VALUES ($1, $2, $3, $4)
      RETURNING *
      `,
      [
  name,
  email,
  hashedPassword,
  level
]
    );

    res.status(201).json({
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
  `,
      [email],
    );

    if (result.rows.length === 0) {
      return res.status(401).json({
        success: false,
        message: "Email atau password salah",
      });
    }

    const user = result.rows[0];

    const isMatch = await bcrypt.compare(
      password,
      user.password
    );
    if (!isMatch) {
      return res.status(401).json({
        success: false,
        message: "Email atau password salah",
      });
    }
    // Buat object baru TANPA password
    const userData = {
      id: user.id,
      name: user.name,
      email: user.email,
    };
    res.json({
      success: true,
      user: userData,
    })}
     catch (error) {
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
  `,
      [email],
    );

    if (result.rows.length === 0) {
      return res.status(401).json({
        success: false,
        message: "Email atau password salah",
      });
    }

    const admin = result.rows[0];

    const isMatch = await bcrypt.compare(password, admin.password);

    if (!isMatch) {
      return res.status(401).json({
        success: false,
        message: "Email atau password salah",
      });
    }

    const adminData = {
      id: admin.id,
      name: admin.name,
      email: admin.email,
      level: admin.level,
    };

    res.json({
      success: true,
      admin: adminData,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
});

export default router;
