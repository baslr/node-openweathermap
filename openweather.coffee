
http    = require 'http'
opts    = hostname:'api.openweathermap.org', port: 80, withCredentials: false
imgPath = 'http://openweathermap.org/img/w/'
def     = ''

exports.defaults = (cfg) ->
  objs = []
  objs.push "#{i}=#{n}" for i,n of cfg  
  def = objs.join '&'

exports.opts = (optsIn = {}) ->
  opts[i] = optsIn[i] for i,n of optsIn
  this


exports.find = (cfg, cb) ->
  opts.path = "/data/2.5/find?#{buildPath(cfg)}"

  getWeather opts, (err, json) ->
    return cb(err) if err?
    item.weather[0].iconUrl = "#{imgPath}#{item.weather[0].icon}.png" for item in json.list
    cb null, json  


exports.now = (cfg, cb) ->
  opts.path = "/data/2.5/weather?#{buildPath(cfg)}"
  
  getWeather opts, (err, json) ->
    return cb(err) if err?
    json.weather[0].iconUrl = "#{imgPath}#{json.weather[0].icon}.png" if 200 is Number json.cod
    cb null, json


exports.forecast = (cfg, cb) ->
  opts.path = "/data/2.5/forecast?#{buildPath(cfg)}"

  getWeather opts, (err, json) ->
    return cb(err) if err?
    item.weather[0].iconUrl = "#{imgPath}#{item.weather[0].icon}.png" for item in json.list
    cb null, json


exports.daily = (cfg, cb) ->
  opts.path = "/data/2.5/forecast/daily?#{buildPath(cfg)}"  

  getWeather opts, (err, json) ->
    return cb(err) if err?
    item.weather[0].iconUrl = "#{imgPath}#{item.weather[0].icon}.png" for item in json.list
    cb null, json


exports.history = (cfg, cb) ->
  opts.path = "/data/2.5/history/city?#{buildPath(cfg)}"  

  getWeather opts, (err, json) ->
    return cb(err) if err?
    item.weather[0].iconUrl = "#{imgPath}#{item.weather[0].icon}.png" for item in json.list
    cb null, json


buildPath = (cfg) ->
  objs = []  
  objs.push "#{i}=#{n}" for i,n of cfg

  return "#{def}&#{objs.join('&')}"


getWeather = (opts, cb) ->
  http.get opts, (res) ->
    buffer = ''

    res.on 'data', (data) -> buffer += data
    res.on 'error', (error) -> cb(error)
    res.on 'end', () ->
      try json  = JSON.parse buffer catch error then return cb(error)
      json.list = [] if ! json.list?
      cb null, json
