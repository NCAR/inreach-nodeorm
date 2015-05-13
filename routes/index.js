var express = require('express');
var router = express.Router();
var saver = require('../saver');

/* GET home page. */
router.get('/', saver.get);

/* POST home page. */
router.post('/', saver.save);

module.exports = router;
