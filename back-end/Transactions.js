import express from "express";
import { db } from "./db.js";

const router = express.Router();

router.get("/", async (req, res) => {
    try {

        const result = await db.query(`
      SELECT
        t.*,
        p.name AS product_name
      FROM transactions t
      JOIN products p
        ON p.id = t.product_id
      ORDER BY t.id DESC
    `);

        res.json({
            success: true,
            transactions: result.rows,
        });

    } catch (error) {
        res.status(500).json({
            success: false,
            message: error.message,
        });
    }
});

router.get("/order/:orderId", async (req, res) => {
    try {

        const { orderId } = req.params;

        const transactionResult = await db.query(
            `
      SELECT *
      FROM transactions
      WHERE order_id = $1
      `,
            [orderId]
        );

        if (transactionResult.rows.length === 0) {
            return res.status(404).json({
                success: false,
                message: "Transaksi tidak ditemukan",
            });
        }

        const transaction =
            transactionResult.rows[0];

        const detailsResult = await db.query(
            `
      SELECT *
      FROM transaction_details
      WHERE transaction_id = $1
      `,
            [transaction.id]
        );

        res.json({
            success: true,
            transaction,
            details: detailsResult.rows,
        });

    } catch (error) {
        res.status(500).json({
            success: false,
            message: error.message,
        });
    }
});

router.post("/", async (req, res) => {
    try {

        const {
            user_id,
            product_id,
            quantity,
            total_price,
            customer_email,
            customer_whatsapp,
            notes,
            targets
        } = req.body;

        const orderId =
            `TRX-${Date.now()}`;

        const transactionResult =
            await db.query(
                `
        INSERT INTO transactions (
          order_id,
          user_id,
          product_id,
          quantity,
          total_price,
          customer_email,
          customer_whatsapp,
          notes
        )
        VALUES (
          $1,$2,$3,$4,$5,$6,$7,$8
        )
        RETURNING *
        `,
                [
                    orderId,
                    user_id,
                    product_id,
                    quantity,
                    total_price,
                    customer_email,
                    customer_whatsapp,
                    notes
                ]
            );

        const transaction =
            transactionResult.rows[0];

        if (
            Array.isArray(targets)
        ) {

            for (const target of targets) {

                await db.query(
                    `
          INSERT INTO transaction_details (
            transaction_id,
            game_uid,
            game_server
          )
          VALUES ($1,$2,$3)
          `,
                    [
                        transaction.id,
                        target.game_uid,
                        target.game_server
                    ]
                );

            }

        }

        res.status(201).json({
            success: true,
            transaction,
        });

    } catch (error) {
        res.status(500).json({
            success: false,
            message: error.message,
        });
    }
});

router.put(
    "/order/:orderId",
    async (req, res) => {
        try {

            const { orderId } =
                req.params;

            const {
                transaction_status,
                payment_type,
                transaction_id_midtrans,
                fraud_status,
                settlement_time
            } = req.body;

            const result =
                await db.query(
                    `
          UPDATE transactions
          SET
            transaction_status = $1,
            payment_type = $2,
            transaction_id_midtrans = $3,
            fraud_status = $4,
            settlement_time = $5,
            updated_at = CURRENT_TIMESTAMP
          WHERE order_id = $6
          RETURNING *
          `,
                    [
                        transaction_status,
                        payment_type,
                        transaction_id_midtrans,
                        fraud_status,
                        settlement_time,
                        orderId
                    ]
                );

            res.json({
                success: true,
                transaction:
                    result.rows[0],
            });

        } catch (error) {
            res.status(500).json({
                success: false,
                message: error.message,
            });
        }
    }
);
export default router;