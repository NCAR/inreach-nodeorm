var express = require('express');
var router = express.Router();
var saver = require('../saver');

router.all('/', function (req, res, next) {
  res.sendStatus(404);
});

/* GET home page. */
router.get('/inreach', saver.get);

/* POST home page. */
router.post('/inreach', saver.save);

module.exports = router;
