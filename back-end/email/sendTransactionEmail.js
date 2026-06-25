import transporter from "./transporter.js";
import transactionTemplate from "./templates.js";

const sendTransactionEmail = async ({
    to,
    customerName,
    orderId,
    gameName,
    productName,
    quantity,
    totalPrice,
    status,
}) => {

    try {

        const info =
            await transporter.sendMail({

                from: `"EI Gaming Store" <${process.env.EMAIL_USER}>`,

                to,

                subject: `Pembayaran ${status} • ${orderId}`,

                html: transactionTemplate({

                    customerName,

                    orderId,

                    gameName,

                    productName,

                    quantity,

                    totalPrice,

                    status,

                }),

            });

        console.log(
            `Email transaksi berhasil dikirim ke ${to}`
        );

        return info;

    } catch (error) {

        console.error(
            "Send Transaction Email Error:",
            error
        );

        throw error;

    }

};

export default sendTransactionEmail;