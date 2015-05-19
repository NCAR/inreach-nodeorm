exports.save = function (req, res, next) {
  if (!req.body || !req.body['Events']) return res.status(400).send('No events');

  if ('300234010961140' === req.body.imei)
    return res.status(200).json({status:"Pretend it's OK that this bad data arrived."});

  // TODO: accept data only from known hosts/subnets
  //       e.g. 50.57.12.84 app1.delorme.com

  // TODO: accept data only for known IMEIs

  var events = [];
  req.body['Events'].forEach(function(it){
    events.push(squashEvent(it));
  });

  req.models.inreachEvent.create(events, function (err,items) {
    if (err) throw(err);
    res.status(200).json({status:'OK'});
  });
};

exports.get = function (req, res, next) {
  // can't instantiate from execQuery's data
  // (createInstance() is not public; create() tries to save(); ctor sets isNew/ignores id)
  // so must just select "i.id" instead of "i.*" and then load with another query
  req.db.driver.execQuery(
   'select i.id from ( select * from inreach_event order by message_time desc ) as i group by imei',
   function(err,data) {
     if (err) throw(err);

     var ids = [];
     data.forEach(function(it) { ids.push(it.id); });

     req.models.inreachEvent.find({id:ids}).all(function(err,events) {
       if (err) throw(err);
       res.render('events', { listType: 'Latest', events: events, helpers: req.app.get('helpers')});
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
