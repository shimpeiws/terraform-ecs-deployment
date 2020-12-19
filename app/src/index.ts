import * as express from "express";

const PORT = 8080;
const HOST = "0.0.0.0";

const app = express();
app.get("/", (_, res) => {
  res.send("Hello World\n");
});

app.listen(PORT, HOST);
console.log(`Local port is ${PORT}`);
