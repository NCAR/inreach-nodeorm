process.env.TZ='UTC';

var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var bodyParser = require('body-parser');
var orm = require('orm');

var saver = require('./saver');
var models = require('./models');

var routes = require('./routes/index');

var app = express();

var helpers = require('./helpers');
app.set('helpers',helpers);

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(favicon(__dirname + '/public/favicon.ico'));

if (app.get('env') === 'development') {
  var logger = require('morgan');
  app.use(logger('dev'));
}

// hack to get raw request body -- will it work?
// http://stackoverflow.com/questions/18710225/node-js-get-raw-request-body-using-express
// http://stackoverflow.com/questions/9920208/expressjs-raw-body
// https://github.com/strongloop/express/issues/897
app.use(function(req, res, next) {
  // this is just an FYI for logging, so don't waste memory on big bodies
  var contentType = req.get('content-type') || '';
  var contentLength = Number.parseInt(req.get('content-length'));
  if (isNaN(contentLength) || contentLength > 10240 ||
      contentType.indexOf('multipart') >= 0) {
    req.rawBody = '<large/multipart body data omitted>';
    return next();
  }

  req.rawBody = '';

  req.on('data', function(chunk) { 
    req.rawBody += chunk;
  });

  next();
});

app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, 'public')));

orm.settings.set('instance.returnAllErrors', true);
app.use(orm.express("mysql://inreach:delorme@localhost/inreach?pool=true", {
  define: models.setup
}));

app.use('/', routes);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handlers

if (app.get('env') === 'production') {
  var winston = require('winston'),
      expressWinston = require('express-winston');
  expressWinston.requestWhitelist.push('body');
  expressWinston.requestWhitelist.push('ip');
  expressWinston.requestWhitelist.push('rawBody');
  expressWinston.responseWhitelist.push('body');
  app.use(expressWinston.errorLogger({
    transports: [
      new winston.transports.File({
        level: 'debug',
        timestamp: true,
        filename: path.join(__dirname, 'logs', 'error_log.json'),
        maxsize: 104857600,
        maxFiles: 10,
      })
    ],
    level: 'debug',
  }));
  }

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});

module.exports = app;
