const express = require("express");
const routes = require("../src/routes/index.routes");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());
app.use(routes);

app.listen(3307, () => {
    console.log("Listening in port 3307...");
})

module.exports = app;

