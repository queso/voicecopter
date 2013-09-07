#telnet 192.168.1.1
#killall udhcpd; iwconfig ath0 mode managed essid 'Top Gun Guest WiFi'; ifconfig ath0 10.10.10.203 netmask 255.255.255.0 up;

arDrone = require("ar-drone")
client = arDrone.createClient({ip: '10.10.10.203'})
speech = require("google-speech-api")
exec = require('child_process').exec

exec 'rec test.flac silence 1 0.2 1.5% 1 00:01 1.5%', (error, stdout, stderr) ->
  speech file: "test.flac", (err, results) ->
    console.log err if err
    console.log results
    processCommand results[0].hypotheses[0].utterance

processCommand = (text) ->
  console.log "TEXT: #{text}"
  switch text
    when "launch", "take off"
      client.takeoff()
    when "land"
      client.land()
    when "stop"
      client.stop()
    when "move forward"
      client.front(0.5)

client.after 10000, ->
  @land()

