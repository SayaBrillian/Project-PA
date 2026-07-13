import jwt from "jsonwebtoken";
import bcrypt from "bcrypt";
import { db } from "../../db.js";

export async function loginAdmin(req, res) {

  try {

    const {

      credential,
      password,

    } = req.body;

    /*
    |--------------------------------------------------------------------------
    | REQUIRED
    |--------------------------------------------------------------------------
    */

    if (

      !credential ||
      !password

    ) {

      return res.status(400).json({

        success: false,

        message: "Credential dan password wajib diisi.",

      });

    }

    /*
    |--------------------------------------------------------------------------
    | FIND ADMIN
    |--------------------------------------------------------------------------
    */

    const result =
      await db.query(

        `
        SELECT *
        FROM admins

        WHERE

          username = $1

          OR email = $1

        LIMIT 1
        `,

        [

          credential,

        ],

      );

    if (

      result.rows.length === 0

    ) {

      return res.status(401).json({

        success: false,

        message: "Credential atau password salah.",

      });

    }

    const admin =
      result.rows[0];

    /*
    |--------------------------------------------------------------------------
    | PASSWORD
    |--------------------------------------------------------------------------
    */

    const isMatch =
      await bcrypt.compare(

        password,

        admin.password,

      );

    if (

      !isMatch

    ) {

      return res.status(401).json({

        success: false,

        message: "Credential atau password salah.",

      });

    }

    /*
    |--------------------------------------------------------------------------
    | TOKEN
    |--------------------------------------------------------------------------
    */

    const token =
      jwt.sign(

        {

          id: admin.id,

          username: admin.username,

          email: admin.email,

          role: admin.role,

          type: "admin",

        },

        process.env.JWT_SECRET,

        {

          expiresIn: "1d",

        },

      );

    /*
    |--------------------------------------------------------------------------
    | RESPONSE
    |--------------------------------------------------------------------------
    */

    return res.json({

      success: true,

      token,

      admin: {

        id: admin.id,

        name: admin.name,

        username: admin.username,

        birthDate: admin.birth_date,

        email: admin.email,

        phone: admin.phone,

        role: admin.role,

        type: "admin",

      },

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