var express = require("express");
var fs = require("fs");
var router = express.Router();

/* GET home page. */
router.post("/contract", async function(req, res, next) {
  let sc_string = await fs.readFileSync("./contract/DataExchange.json");
  res.send(sc_string);
});

module.exports = router;
