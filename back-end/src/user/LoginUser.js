import jwt from "jsonwebtoken";
import bcrypt from "bcrypt";
import { db } from "../../db.js";

export async function loginUser(req, res) {

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
    | FIND USER
    |--------------------------------------------------------------------------
    */

    const result =
      await db.query(

        `
        SELECT *
        FROM users

        WHERE

          username = $1

          OR email = $1

          OR phone = $1

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

    const user =
      result.rows[0];

    /*
    |--------------------------------------------------------------------------
    | PASSWORD
    |--------------------------------------------------------------------------
    */

    const isMatch =
      await bcrypt.compare(

        password,

        user.password,

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

          id: user.id,

          username: user.username,

          email: user.email,

          type: "user",

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

      user: {

        id: user.id,

        name: user.name,

        username: user.username,

        birthDate: user.birth_date,

        email: user.email,

        phone: user.phone,

        type: "user",

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