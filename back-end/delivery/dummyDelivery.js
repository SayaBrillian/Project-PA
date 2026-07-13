import { db } from "../db.js";
import sendTransactionEmail from "../email/sendTransactionEmail.js";
import axios from "axios";

const deliverySteps = [
  {
    status: "processing",
    delay: 15 * 1000,
  },
  {
    status: "sending",
    delay: 30 * 1000,
  },
  {
    status: "done",
    delay: 45 * 1000,
  },
];

export default function startDummyDelivery(transactionId) {

  deliverySteps.forEach((step) => {

    setTimeout(async () => {

      try {

        await db.query(
          `
          UPDATE transactions
          SET
            order_status = $1,
            updated_at = CURRENT_TIMESTAMP
          WHERE id = $2
          `,
          [
            step.status,
            transactionId
          ]
        );

        console.log(
          `Dummy Delivery -> ${step.status}`
        );
        if (step.status === "done") {

          const result = await db.query(
            `
    SELECT
      t.*,
      p.name AS product_name,
      g.name AS game_name
    FROM transactions t
    JOIN products p
      ON p.id = t.product_id
    JOIN games g
      ON g.id = p.game_id
    WHERE t.id = $1
    `,
            [transactionId]
          );

          const transaction = result.rows[0];

          if (transaction.customer_email) {

            await sendTransactionEmail({

              to: transaction.customer_email,

              customerName: "Customer",

              orderId: transaction.order_id,

              gameName: transaction.game_name,

              productName: transaction.product_name,

              quantity: transaction.quantity,

              totalPrice: transaction.total_price,

              status: "done",

            });

            console.log("Email berhasil dikirim.");

          }

          if (transaction.customer_whatsapp) {

            try {

              await axios.post(
                "https://api.fonnte.com/send",

                {
                  target: transaction.customer_whatsapp,

                  message: `🎮 EI Gaming Store
Pesanan Anda telah selesai diproses.

━━━━━━━━━━━━━━━

Order ID
${transaction.order_id}

Game
${transaction.game_name}

Produk
${transaction.product_name}

Jumlah
${transaction.quantity}

Total
Rp ${Number(transaction.total_price).toLocaleString("id-ID")}

Status
DONE ✅

━━━━━━━━━━━━━━━

Terima kasih telah berbelanja di EI Gaming Store ❤️`,
                },

                {
                  headers: {
                    Authorization: process.env.FONNTE_TOKEN,
                  },
                }
              );

              console.log("WhatsApp berhasil dikirim.");

            } catch (error) {

              console.error(
                "WhatsApp Error:",
                error.response?.data || error.message
              );

            }

          }

        }
      } catch (error) {

        console.error(
          "Dummy Delivery Error:",
          error
        );

      }

    }, step.delay);

  });

}