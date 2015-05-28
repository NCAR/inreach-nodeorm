exports.save = function (req, res, next) {
  if (!req.body || !req.body['Events']) return res.status(400).send('No events');

  // TODO: accept data only from known hosts/subnets
  //       e.g. 50.57.12.84 app1.delorme.com (50.57.12.0/255.255.255.0)

  var events = [];
  req.body['Events'].forEach(function(it){
    // TODO: accept data only for known IMEIs

    // don't accept data for this bogus IMEI that comes 1x/day
    if ('300234010961140' != it.imei) {
      var event = squashEvent(it);

      // only save good latlons; in particular 0,0 is valid only with position reports
      // (seems to be a missing value for other messageCode's like  20/Mail Check)
      if (event.message_code === 0 || event.latitude != 0)
        events.push(event);
    }
  });

  if (events.length === 0)
    return res.status(200).json({status:"Pretend it's OK that no or bad data arrived."});

  req.models.inreachEvent.create(events, function (err,items) {
    if (err) {
      res.status(400).send(err.toString());
    } else {
      res.status(200).json({status:'OK'});
    }
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
