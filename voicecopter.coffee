#telnet 192.168.1.1
#killall udhcpd; iwconfig ath0 mode managed essid 'Top Gun Guest WiFi'; ifconfig ath0 10.10.10.203 netmask 255.255.255.0 up;

arDrone = require("ar-drone")
client = arDrone.createClient({ip: '10.10.10.203'})
speech = require("google-speech-api")
exec = require('child_process').exec

recordCommand = ->
  exec 'rec test.flac silence -l 1 0.2 1.5% 1 00:01 1.5%', (error, stdout, stderr) ->
    speech file: "test.flac", (err, results) ->
      console.log err if err
      command = results[0].hypotheses[0].utterance if results[0] and results[0].hypotheses[0]
      processCommand command

processCommand = (text) ->
  console.log "TEXT: #{text}"
  switch text
    when "launch", "take off", "lunch", "call"
      client.takeoff()
    when "land", "lamb", "when", "wind", "Flynn", "Lynn"
      client.land()
    when "stop", "cease", "stuck", "thief"
      client.stop()
    when "move forward", "forward", "24", "look forward", "ahead", "advance", "Advance"
      client.front(0.3)
      client.after 1000, ->
        @stop()
    when "move back", "back", "backward", "look back", "lupa", "fat"
      client.back(0.3)
      client.after 1000, ->
        @stop()
    when "left"
      client.left(0.2)
      client.after 800, ->
        @stop()
    when "right", "freight"
      client.right(0.2)
      client.after 800, ->
        @stop()
    when "up", "higher", "rays", "elevate"
      client.up(0.4)
      client.after 1000, ->
        @stop()
    when "down", "lower"
      client.down(0.4)
      client.after 1000, ->
        @stop()
    when "fire", "fire missiles", "missiles"
      client.animateLeds('doubleMissile', 1, 2)
    when "flip"
      client.animate('flipLeft', 800)
    when "reset", "Lisa", "reset a"
      client.disableEmergency()
    when "shake"
      client.animate('yawShake', 2000)
    when "dance"
      client.animate('yawDance', 2000)
  recordCommand()

recordCommand()
