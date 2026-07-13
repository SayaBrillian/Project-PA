import jwt from "jsonwebtoken";

/*
|--------------------------------------------------------------------------
| VERIFY TOKEN
|--------------------------------------------------------------------------
*/

export function verifyToken(req, res, next) {

  try {

    const authHeader =
      req.headers.authorization;

    if (!authHeader) {

      return res.status(401).json({

        success: false,

        message: "Token tidak ditemukan.",

      });

    }

    const token =
      authHeader.split(" ")[1];

    if (!token) {

      return res.status(401).json({

        success: false,

        message: "Token tidak valid.",

      });

    }

    const decoded =
      jwt.verify(

        token,

        process.env.JWT_SECRET,

      );

    req.user =
      decoded;

    next();

  }

  catch (error) {

    return res.status(401).json({

      success: false,

      message: "Token tidak valid.",

    });

  }

}

/*
|--------------------------------------------------------------------------
| REQUIRE ROLE
|--------------------------------------------------------------------------
*/

export function requireRole(...roles) {

  return (req, res, next) => {

    if (!req.user) {

      return res.status(401).json({

        success: false,

        message: "Unauthorized.",

      });

    }

    if (
      !roles.includes(req.user.role)
    ) {

      return res.status(403).json({

        success: false,

        message: "Akses ditolak.",

      });

    }

    next();

  };

}