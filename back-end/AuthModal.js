import jwt from "jsonwebtoken";
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
    if (!name || !email || !password) {
      return res.status(400).json({
        success: false,
        message: "Semua field wajib diisi",
      });
    }

    if (!email.includes("@")) {
      return res.status(400).json({
        success: false,
        message: "Format email tidak valid",
      });
    }

    if (password.length < 6) {
      return res.status(400).json({
        success: false,
        message: "Password minimal 6 karakter",
      });
    }
    const existingUser = await db.query(
      `
  SELECT id
  FROM users
  WHERE email = $1
  `,
      [email]
    );

    if (existingUser.rows.length > 0) {
      return res.status(400).json({
        success: false,
        message: "Email sudah digunakan",
      });
    }

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

    const user = result.rows[0];

const userData = {
  id: user.id,
  name: user.name,
  email: user.email,
};

res.status(201).json({
  success: true,
  user: userData,
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
| REGISTER ADMIN
|--------------------------------------------------------------------------
*/

router.post(
  "/register-admin",
  verifyToken,
  requireLevel(100),
  async (req, res) => {
    try {
      const { name, email, password, level } = req.body;
      if (level < 1 || level > 100) {
  return res.status(400).json({
    success: false,
    message: "Level harus antara 1 sampai 100",
  });
}
      if (!level) {
  return res.status(400).json({
    success: false,
    message: "Level wajib diisi",
  });
}
      if (!name || !email || !password) {
        return res.status(400).json({
          success: false,
          message: "Semua field wajib diisi",
        });
      }

      if (!email.includes("@")) {
        return res.status(400).json({
          success: false,
          message: "Format email tidak valid",
        });
      }

      if (password.length < 6) {
        return res.status(400).json({
          success: false,
          message: "Password minimal 6 karakter",
        });
      }
      const existingAdmin = await db.query(
        `
  SELECT id
  FROM admins
  WHERE email = $1
  `,
        [email]
      );

      if (existingAdmin.rows.length > 0) {
        return res.status(400).json({
          success: false,
          message: "Email admin sudah digunakan",
        });
      }
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

      const admin = result.rows[0];

const adminData = {
  id: admin.id,
  name: admin.name,
  email: admin.email,
  level: admin.level,
};

res.status(201).json({
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

/*
|--------------------------------------------------------------------------
| LOGIN USER
|--------------------------------------------------------------------------
*/

router.post("/login-user", async (req, res) => {
  try {
    const { email, password } = req.body;
    if (!email || !password) {
      return res.status(400).json({
        success: false,
        message: "Email dan password wajib diisi",
      });
    }
    const result = await db.query(
      `
      SELECT *
      FROM users
      WHERE email = $1
      `,
      [email]
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

    const userData = {
      id: user.id,
      name: user.name,
      email: user.email,
    };

    const token = jwt.sign(
      {
        id: user.id,
        email: user.email,
        type: "user",
      },
      process.env.JWT_SECRET,
      {
        expiresIn: "1d",
      }
    );

    res.json({
      success: true,
      token,
      user: userData,
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
    if (!email || !password) {
      return res.status(400).json({
        success: false,
        message: "Email dan password wajib diisi",
      });
    }
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

    const token = jwt.sign(
      {
        id: admin.id,
        email: admin.email,
        type: "admin",
        level: admin.level,
      },
      process.env.JWT_SECRET,
      {
        expiresIn: "1d",
      }
    );

    res.json({
      success: true,
      token,
      admin: adminData,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
});

function verifyToken(req, res, next) {
  try {
    const authHeader =
      req.headers.authorization;

    if (!authHeader) {
      return res.status(401).json({
        success: false,
        message: "Token tidak ditemukan",
      });
    }

    const token =
      authHeader.split(" ")[1];

    const decoded = jwt.verify(
      token,
      process.env.JWT_SECRET
    );

    req.user = decoded;

    next();

  } catch (error) {
    return res.status(401).json({
      success: false,
      message: "Token tidak valid",
    });
  }
}

function requireLevel(minLevel) {
  return (req, res, next) => {

    if (req.user.type !== "admin") {
      return res.status(403).json({
        success: false,
        message: "Hanya admin yang diizinkan",
      });
    }

    if (req.user.level < minLevel) {
      return res.status(403).json({
        success: false,
        message: "Level admin tidak mencukupi",
      });
    }

    next();
  };
}

router.get(
  "/me",
  verifyToken,
  (req, res) => {

    res.json({
      success: true,
      user: req.user,
    });

  }
);

router.get(
  "/admin-only",
  verifyToken,
  requireLevel(80),
  (req, res) => {

    res.json({
      success: true,
      message: "Selamat datang Admin",
      admin: req.user,
    });

  }
);
export default router;
