import dotenv from "dotenv";
import sendTransactionEmail from "./sendTransactionEmail.js";

dotenv.config();

await sendTransactionEmail({

    to: process.env.EMAIL_USER,

    customerName: "Lian",

    orderId: "TRX-TEST-001",

    gameName: "Mobile Legends",

    productName: "86 Diamonds",

    quantity: 2,

    totalPrice: 25000,

    status: "Settlement",

});

export default testEmail;