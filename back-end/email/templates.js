const transactionTemplate = ({
    customerName,
    orderId,
    gameName,
    productName,
    quantity,
    totalPrice,
    status,
}) => {

    return `
<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>EI Gaming Store</title>

</head>

<body
    style="
        margin:0;
        padding:40px;
        background:#f5f7fb;
        font-family:Arial, Helvetica, sans-serif;
    "
>

<table
    width="100%"
    cellpadding="0"
    cellspacing="0"
>

<tr>

<td align="center">

<table
    width="650"
    cellpadding="0"
    cellspacing="0"
    style="
        background:#ffffff;
        border-radius:18px;
        overflow:hidden;
    "
>

<tr>

<td
    style="
        background:#f472b6;
        color:white;
        text-align:center;
        padding:28px;
    "
>

<h1
    style="
        margin:0;
    "
>
EI GAMING STORE
</h1>

<p
    style="
        margin-top:8px;
    "
>
Payment Confirmation
</p>

</td>

</tr>

<tr>

<td
    style="
        padding:32px;
        color:#374151;
    "
>

<h2
    style="
        margin-top:0;
    "
>
Halo ${customerName},
</h2>

<p>
Terima kasih telah melakukan pembelian di
<b>EI Gaming Store</b>.
</p>

<table
    width="100%"
    cellpadding="10"
    cellspacing="0"
    style="
        margin-top:24px;
        border-collapse:collapse;
    "
>

<tr>

<td><b>Order ID</b></td>

<td>${orderId}</td>

</tr>

<tr>

<td><b>Game</b></td>

<td>${gameName}</td>

</tr>

<tr>

<td><b>Product</b></td>

<td>${productName}</td>

</tr>

<tr>

<td><b>Quantity</b></td>

<td>${quantity}</td>

</tr>

<tr>

<td><b>Status</b></td>

<td>${status}</td>

</tr>

<tr>

<td><b>Total</b></td>

<td>

Rp ${Number(totalPrice).toLocaleString("id-ID")}

</td>

</tr>

</table>

<p
    style="
        margin-top:36px;
    "
>

Terima kasih telah mempercayai
<b>EI Gaming Store</b>.

</p>

</td>

</tr>

<tr>

<td
    style="
        background:#f3f4f6;
        text-align:center;
        padding:20px;
        font-size:13px;
        color:#6b7280;
    "
>

© ${new Date().getFullYear()}
EI Gaming Store

</td>

</tr>

</table>

</td>

</tr>

</table>

</body>

</html>
`;

};

export default transactionTemplate;