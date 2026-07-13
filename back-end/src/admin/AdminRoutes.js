import express from "express";

import { registerAdmin } from "./RegisterAdmin.js";
import { loginAdmin } from "./LoginAdmin.js";
import { profileAdmin } from "./ProfileAdmin.js";

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

export default router;