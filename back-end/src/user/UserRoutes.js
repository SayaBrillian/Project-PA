import express from "express";

import { registerUser } from "./RegisterUser.js";
import { loginUser } from "./LoginUser.js";
import { checkUser } from "./CheckUser.js";
import { profileUser } from "./ProfileUser.js";

import { getUsers } from "./GetUsers.js";
import { updateUser } from "./UpdateUser.js";

import { verifyToken } from "../middleware/Auth.js";

const router = express.Router();

/*
|--------------------------------------------------------------------------
| REGISTER
|--------------------------------------------------------------------------
*/

router.post(
  "/register",
  registerUser
);

/*
|--------------------------------------------------------------------------
| LOGIN
|--------------------------------------------------------------------------
*/

router.post(
  "/login",
  loginUser
);

/*
|--------------------------------------------------------------------------
| CHECK
|--------------------------------------------------------------------------
*/

router.post(
  "/check",
  checkUser
);

/*
|--------------------------------------------------------------------------
| PROFILE
|--------------------------------------------------------------------------
*/

router.get(
  "/me",
  verifyToken,
  profileUser
);

/*
|--------------------------------------------------------------------------
| USERS
|--------------------------------------------------------------------------
*/

router.get(
  "/",
  getUsers
);

router.put(
  "/:id",
  updateUser
);

export default router;