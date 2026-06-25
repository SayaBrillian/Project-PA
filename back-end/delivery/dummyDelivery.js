import { db } from "../db.js";

const deliverySteps = [
  {
    status: "processing",
    delay: 60 * 1000,
  },
  {
    status: "sending",
    delay: 120 * 1000,
  },
  {
    status: "done",
    delay: 180 * 1000,
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

      } catch (error) {

        console.error(
          "Dummy Delivery Error:",
          error
        );

      }

    }, step.delay);

  });

}