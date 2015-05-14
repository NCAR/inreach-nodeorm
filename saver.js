exports.save = function (req, res, next) {
  if (!req.body || !req.body['Events']) return res.sendStatus(400);

  console.log(req.body);
  //console.log(JSON.stringify(req.body.Events,null,2));

  var events = [];
  req.body['Events'].forEach(function(it){
    events.push(squashEvent(it));
  });

  req.models.inreachEvent.create(events, function (err,items) {
    if (err) return next(err);
    console.log(items);
    res.send('OK');
  });
};

exports.get = function (req, res, next) {
  // can't instantiate from execQuery's data
  // (createInstance() is not public; create() tries to save(); ctor sets isNew/ignores id)
  // so must just select "i.id" instead of "i.*" and then load with another query
  req.db.driver.execQuery(
   'select i.id from ( select * from inreach_event order by message_time desc ) as i group by imei',
   function(err,data) {
     if (err) return next(err);

     var ids = [];
     data.forEach(function(it) { ids.push(it.id); });

     req.models.inreachEvent.find({id:ids}).all(function(err,events) {
       if (err) return next(err);
       res.render('events', { listType: 'Latest', events: events });
     });
   });
};

function squashEvent(orig) {
  //var copy = Object.assign({},orig);
  var copy = {};

  for (key in orig) {
    if (key === 'point') {
      for (key in orig.point) {
        copy[key]=orig.point[key]
      }
    } else if (key === 'status') {
      for (key in orig.status) {
        copy[key]=orig.status[key]
      }
    } else if (key === 'addresses') {
      copy.addresses = [];
      orig.addresses.forEach(function(it){ copy.addresses.push(it); });
    } else if (key === 'timeStamp') {
      copy.timeStamp = orig.timeStamp ? new Date(orig.timeStamp) : null;
    } else if (key === 'pingbackReceived') {
      copy.pingbackReceived = orig.pingbackReceived ? new Date(orig.pingbackReceived) : null;
    } else if (key === 'pingbackResponded') {
      copy.pingbackResponded = orig.pingbackResponded ? new Date(orig.pingbackResponded) : null;
    } else {
      copy[key] = orig[key];
    }
  }

  return(copy);
}
