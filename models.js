var orm = require('orm');
var ormts = require('orm-timestamps');
var enforce = orm.enforce;

exports.setup = function (db, models, next) {

  db.use(ormts, {
    createdProperty: 'row_create_time',
    modifiedProperty: 'row_revise_time'
  });

  models.inreachEvent = db.define('inreachEvent',{
    imei : { type: 'text' },
    messageCode : { type: 'integer', mapsTo: 'message_code' },
    freeText : { type: 'text', mapsTo: 'free_text' },
    timeStamp : { type: 'date', time: true, mapsTo: 'message_time' },
    pingbackReceived : { type: 'date', time: true, mapsTo: 'pingback_received' },
    pingbackResponded : { type: 'date', time: true, mapsTo: 'pingback_responded' },
    addresses : { type: 'object' },
 
    //point
    latitude : { type: 'number' },
    longitude : { type: 'number' },
    altitude : { type: 'number' },
    gpsFix : { type: 'integer', mapsTo: 'gps_fix' },
    course : { type: 'number' },
    speed : { type: 'number' },

    //status
    autonomous : { type: 'integer' },
    lowBattery : { type: 'integer', mapsTo: 'low_battery' },
    intervalChange : { type: 'integer', mapsTo: 'interval_change' },

    //payload // encryption binary data (unused)

    //rowCreateContactId : { type: 'integer', mapsTo: 'row_create_contact_id' },
    //rowCreateTime : { type: 'date', time: true, mapsTo: 'row_create_time' },
    //rowReviseContactId : { type: 'integer', mapsTo: 'row_revise_contact_id' },
    //rowReviseTime : { type: 'date', time: true, mapsTo: 'row_revise_time' }
  },
  {
    collection : 'inreach_event',
    timestamp : true,
    validations : {
      imei : [ enforce.required(),
               enforce.notEmptyString(),
               enforce.ranges.length(1, undefined),
             ],
      messageCode : [ enforce.required(), enforce.ranges.number(0, undefined) ],
      latitude : [ enforce.required(), enforce.ranges.number(-90.0, 90.0) ],
      longitude : [ enforce.required(), enforce.ranges.number(-180.0, 180.0) ],
    }
  });

  models.messageCode = db.define('messageCode',{
    name : { type: 'text' },
    description : { type: 'text' },
  },
  {
    collection : 'inreach_message_code',
    timestamp : true
  });

  next();
};
