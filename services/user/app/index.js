const express = require(express);
const app = express();

app.get(/health, (req, res) => res.send(OK));
app.get(/user, (req, res) => res.json({ id: 1, name: "Johnny" }));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`User service running on port ${PORT}`));

