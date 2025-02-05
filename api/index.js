const express = require("express");
const routes = require("../src/routes/index.routes");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());
app.use(routes);

const serverless = require("serverless-http");
module.exports = serverless(app);
