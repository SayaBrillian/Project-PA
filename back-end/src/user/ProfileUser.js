export async function profileUser(req, res) {

  try {

    return res.json({

      success: true,

      user: req.user,

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