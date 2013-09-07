arDrone = require("ar-drone")
client = arDrone.createClient({ip: '10.10.10.203'})
speech = require("google-speech-api")

speech file: "audio/takeoff.flac", (err, results) ->
  console.log err if err
  console.log results[0].hypotheses[0]
  processCommand results[0].hypotheses[0].utterance

processCommand = (text) ->
  console.log "TEXT: #{text}"
  switch text
    when "take off"
      console.log "TAKE OFF"
      client.takeoff()
    when "land"
      client.land()
    when "stop"
      client.stop()
    when "move forward"
      client.front(0.5)

client.land()
