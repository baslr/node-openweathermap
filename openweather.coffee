
http = require 'http'
opts = hostname:'api.openweathermap.org'
def  = ''

exports.defaults = (cfg) ->
  objs = []
  objs.push "#{i}=#{n}" for i,n of cfg  
  def = objs.join '&'

exports.find = ->


exports.now = (cfg, cb) ->
  opts.path = "/data/2.5/weather?#{buildPath(cfg)}"
  console.log opts.path
  
  getWeather opts, (json) ->
    json.weather[0].iconUrl = "http://openweathermap.org/img/w/#{json.weather[0].icon}.png"
    cb json


exports.forecast = (cfg, cb) ->
  opts.path = "/data/2.5/forecast?#{buildPath(cfg)}"
  console.log opts.path

  getWeather opts, (json) ->
    cb json


exports.daily = (cfg, cb) ->
  opts.path = "/data/2.5/forecast/daily?#{buildPath(cfg)}"  
  console.log opts.path

  getWeather opts, (json) ->
    item.weather[0].iconUrl = "http://openweathermap.org/img/w/#{item.weather[0].icon}.png" for item in json.list
    cb json


buildPath = (cfg) ->
  objs = []  
  objs.push "#{i}=#{n}" for i,n of cfg

  return "#{def}&#{objs.join('&')}"
  
getWeather = (opts, cb) ->
  http.get opts, (res) ->
    buffer = new Buffer 0
    
    res.on 'readable',  ->
      buffer = Buffer.concat [buffer, @read()]
      
    res.on 'end', ->
      cb JSON.parse buffer.toString 'utf8'
