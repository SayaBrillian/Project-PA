import bcrypt from "bcrypt";
import { db } from "../../db.js";

export async function registerAdmin(req, res) {

  try {

    const {

      name,
      username,
      birthDate,
      email,
      phone,
      password,
      role,

    } = req.body;

    /*
    |--------------------------------------------------------------------------
    | REQUIRED
    |--------------------------------------------------------------------------
    */

    if (

      !name ||
      !username ||
      !birthDate ||
      !password

    ) {

      return res.status(400).json({

        success: false,

        message: "Semua field wajib diisi.",

      });

    }

    if (!email && !phone) {

      return res.status(400).json({

        success: false,

        message: "Email atau Nomor WhatsApp wajib diisi.",

      });

    }

    /*
    |--------------------------------------------------------------------------
    | ROLE
    |--------------------------------------------------------------------------
    */

    const adminRole = role || "admin";

    if (

      ![
        "admin",
        "super_admin",
      ].includes(adminRole)

    ) {

      return res.status(400).json({

        success: false,

        message: "Role tidak valid.",

      });

    }

    /*
    |--------------------------------------------------------------------------
    | VALIDATION
    |--------------------------------------------------------------------------
    */

    if (username.length < 4) {

      return res.status(400).json({

        success: false,

        message: "Username minimal 4 karakter.",

      });

    }

    if (

      email &&
      !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)

    ) {

      return res.status(400).json({

        success: false,

        message: "Format email tidak valid.",

      });

    }

    if (

      phone &&
      !/^08\d{8,13}$/.test(phone)

    ) {

      return res.status(400).json({

        success: false,

        message: "Nomor WhatsApp tidak valid.",

      });

    }

    if (

      password.length < 8 ||
      password.length > 12

    ) {

      return res.status(400).json({

        success: false,

        message: "Password harus 8-12 karakter.",

      });

    }

    if (!/(?=.*[a-z])/.test(password)) {

      return res.status(400).json({

        success: false,

        message: "Password harus memiliki huruf kecil.",

      });

    }

    if (!/(?=.*[A-Z])/.test(password)) {

      return res.status(400).json({

        success: false,

        message: "Password harus memiliki huruf besar.",

      });

    }

    if (!/(?=.*\d)/.test(password)) {

      return res.status(400).json({

        success: false,

        message: "Password harus memiliki angka.",

      });

    }

    /*
    |--------------------------------------------------------------------------
    | DUPLICATE
    |--------------------------------------------------------------------------
    */

    const usernameExist =
      await db.query(
        `
        SELECT id
        FROM admins
        WHERE username = $1
        `,
        [username]
      );

    if (usernameExist.rows.length > 0) {

      return res.status(400).json({

        success: false,

        message: "Username sudah digunakan.",

      });

    }

    if (email) {

      const emailExist =
        await db.query(
          `
          SELECT id
          FROM admins
          WHERE email = $1
          `,
          [email]
        );

      if (emailExist.rows.length > 0) {

        return res.status(400).json({

          success: false,

          message: "Email sudah digunakan.",

        });

      }

    }

    if (phone) {

      const phoneExist =
        await db.query(
          `
          SELECT id
          FROM admins
          WHERE phone = $1
          `,
          [phone]
        );

      if (phoneExist.rows.length > 0) {

        return res.status(400).json({

          success: false,

          message: "Nomor WhatsApp sudah digunakan.",

        });

      }

    }

    /*
    |--------------------------------------------------------------------------
    | HASH PASSWORD
    |--------------------------------------------------------------------------
    */

    const hashedPassword =
      await bcrypt.hash(
        password,
        10
      );

    /*
    |--------------------------------------------------------------------------
    | INSERT
    |--------------------------------------------------------------------------
    */

    const result =
      await db.query(

        `
        INSERT INTO admins (

          name,
          username,
          birth_date,
          email,
          phone,
          password,
          role

        )

        VALUES (

          $1,
          $2,
          $3,
          $4,
          $5,
          $6,
          $7

        )

        RETURNING

          id,
          name,
          username,
          birth_date,
          email,
          phone,
          role,
          created_at

        `,

        [

          name,
          username,
          birthDate,
          email || null,
          phone || null,
          hashedPassword,
          adminRole,

        ]

      );

    return res.status(201).json({

      success: true,

      message: "Admin berhasil dibuat.",

      admin: result.rows[0],

    });

  }

  catch (error) {

    console.error(error);

    return res.status(500).json({

      success: false,

      message: error.message,

    });

  }

}