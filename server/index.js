// IMPORTS FROM PACKAGES
const express = require("express");
const mongoose = require("mongoose");
const adminRouter = require("./routes/admin");
// IMPORTS FROM OTHER FILES
const authRouter = require("./routes/auth");
const productRouter = require("./routes/product");

// INIT
const PORT = 3000;
const app = express();
const DB =
  "mongodb+srv://hoanghieus:maimailabaoxa1709@cluster0.tykpdfq.mongodb.net/?retryWrites=true&w=majority";

// MIDDLEWARE
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);

// CONNECTIONS
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connected Succesful");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});
