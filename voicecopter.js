var arDrone = require('ar-drone');
var client = arDrone.createClient();

client.takeoff();

client.createRepl();

client.stop();
client.land();
