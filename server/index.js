const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");
require("dotenv/config");

const app = express();
const env = process.env;
const PORT = 3000;

//middleware
app.use(express.json());
app.use(authRouter);

mongoose
  .connect(env.MONGODB_CONNECTION_STRING)
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => {});
