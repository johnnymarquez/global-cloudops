const express = require(express);
const app = express();

app.get(/health, (req, res) => res.send(OK));
app.get(/order, (req, res) => res.json({ id: 99, status: "confirmed" }));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Order service running on port ${PORT}`));

