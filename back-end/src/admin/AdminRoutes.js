import express from "express";

import { registerAdmin } from "./RegisterAdmin.js";
import { loginAdmin } from "./LoginAdmin.js";
import { profileAdmin } from "./ProfileAdmin.js";
import { getAdmins } from "./GetAdmins.js";
import { updateAdmin } from "./UpdateAdmin.js";

import {

  verifyToken,

  requireRole,

} from "../middleware/Auth.js";

const router =
  express.Router();

/*
|--------------------------------------------------------------------------
| REGISTER
|--------------------------------------------------------------------------
*/

router.post(

  "/register",

  verifyToken,

  requireRole("super_admin"),

  registerAdmin,

);

/*
|--------------------------------------------------------------------------
| LOGIN
|--------------------------------------------------------------------------
*/

router.post(

  "/login",

  loginAdmin,

);

/*
|--------------------------------------------------------------------------
| PROFILE
|--------------------------------------------------------------------------
*/

router.get(

  "/me",

  verifyToken,

  profileAdmin,

);

/*
|--------------------------------------------------------------------------
| ADMINS
|--------------------------------------------------------------------------
*/

router.get(
  "/",
  getAdmins
);

/*
|--------------------------------------------------------------------------
| UPDATE ADMIN
|--------------------------------------------------------------------------
*/

router.put(
  "/:id",
  updateAdmin
);
export default router;