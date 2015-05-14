exports.messageCode = function(code) {
  return messageCodes[code];
  };

var messageCodes = [];

  messageCodes[0]='Position Report';
  messageCodes[1]='Reserved';
  messageCodes[2]='Locate Response';
  messageCodes[3]='Free Text Message';
  messageCodes[4]='Declare SOS';
  messageCodes[5]='Reserved';
  messageCodes[6]='Confirm SOS';
  messageCodes[7]='Cancel SOS';
  messageCodes[8]='Reference Point';
  messageCodes[9]='Check In';
  messageCodes[10]='Start Track';
  messageCodes[11]='Track Interval';
  messageCodes[12]='Stop Track';
  messageCodes[13]='Unknown Index';
  messageCodes[14]='Puck Message 1';
  messageCodes[15]='Puck Message 2';
  messageCodes[16]='Puck Message 3';
  messageCodes[17]='Map Share';
  messageCodes[20]='Mail Check';
  messageCodes[21]='Am I Alive';

  var i;
  for (i=24;i<=63;i++)
    messageCodes[i]='Pre-defined Message';

  messageCodes[64]='Encrypted Binary';
  messageCodes[65]='Pingback Message';
  messageCodes[66]='Generic Binary';
  messageCodes[67]='EncryptedPinpoint';
  messageCodes[3099]='Canned Message';

