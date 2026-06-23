import express from "express";
import { db } from "./db.js";
import snap from "./midtrans.js";

const router = express.Router();

router.post("/create", async (req, res) => {
    try {

        const {
            order_id
        } = req.body;

        const result = await db.query(
            `
      SELECT *
      FROM transactions
      WHERE order_id = $1
      `,
            [order_id]
        );

        if (result.rows.length === 0) {
            return res.status(404).json({
                success: false,
                message: "Transaksi tidak ditemukan",
            });
        }

        const transaction =
            result.rows[0];

        const parameter = {

            transaction_details: {
                order_id:
                    transaction.order_id,

                gross_amount:
                    transaction.total_price,
            },

            customer_details: {
                email:
                    transaction.customer_email,

                phone:
                    transaction.customer_whatsapp,
            },

        };

        const snapResponse =
            await snap.createTransaction(
                parameter
            );

        await db.query(
            `
      UPDATE transactions
      SET snap_token = $1
      WHERE id = $2
      `,
            [
                snapResponse.token,
                transaction.id
            ]
        );

        res.json({
            success: true,
            token: snapResponse.token,
            redirect_url:
                snapResponse.redirect_url,
        });

    } catch (error) {

        console.error(error);

        res.status(500).json({
            success: false,
            message: error.message,
        });

    }
});

export default router;