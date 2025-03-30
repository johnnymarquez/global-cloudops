const express = require(express);
const app = express();

app.get(/health, (req, res) => res.send(OK));
app.get(/product, (req, res) => res.json({ id: 42, name: "Reggae Saxophone" }));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Product service running on port ${PORT}`));

