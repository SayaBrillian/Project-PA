import { db } from "../../db.js";

export async function checkUser(req, res) {

  try {

    const {

      field,
      value,

    } = req.body;

    /*
    |--------------------------------------------------------------------------
    | VALIDATION
    |--------------------------------------------------------------------------
    */

    const allowedFields = [

      "username",

      "email",

      "phone",

    ];

    if (

      !field ||
      !value

    ) {

      return res.status(400).json({

        success: false,

        message: "Field dan value wajib diisi.",

      });

    }

    if (

      !allowedFields.includes(field)

    ) {

      return res.status(400).json({

        success: false,

        message: "Field tidak valid.",

      });

    }

    /*
    |--------------------------------------------------------------------------
    | CHECK
    |--------------------------------------------------------------------------
    */

    const result =
      await db.query(

        `
        SELECT id
        FROM users
        WHERE ${field} = $1
        LIMIT 1
        `,

        [

          value,

        ],

      );

    return res.json({

      success: true,

      available:
        result.rows.length === 0,

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