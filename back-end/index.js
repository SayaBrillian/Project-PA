import express from "express";
import cors from "cors";
import dotenv from "dotenv";

import gamesRoutes from "./Games.js";
import transactionsRoutes from "./Transactions.js";
import paymentsRoutes from "./Payments.js";
import userRoutes from "./src/user/UserRoutes.js";
import adminRoutes from "./src/admin/AdminRoutes.js";
import productRoutes from "./src/product/ProductRoutes.js";

dotenv.config();

const app = express();

app.use(cors());
app.use(express.json());

app.use("/api/games", gamesRoutes);
app.use("/api/product", productRoutes);
app.use("/api/transactions", transactionsRoutes);
app.use("/api/payments", paymentsRoutes);
app.use("/api/user", userRoutes);
app.use("/api/admin", adminRoutes);

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Server berjalan di port ${PORT}`);
});
