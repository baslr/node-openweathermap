node-openweathermap
===================

A small abstraction layer for the openweathermap API

    defaults(cfg)

    # return the weather right now
    now(cfg, callback)

    # get a 7 days every 3h forecast
    forecast(cfg, callback)


    # get up to 14 days daily forecast

    # cfg
    #  cnt:int(number of days for forecast)
    daily(cfg, callback)
    
### defaluts

    units: ('metric'|'imperial'|'internal')
    lang:  ('en'|'ru'|'it'|'sp'|'ua'|'de'|pt'|'ro'|'pl'|'fi'|'nl'|'fr'|'bg'|'se'|'zh_tw'|zh_cn')
    mode:  'json'
    
for now only json support.

### Example

    weather = require 'openweathermap'
    
    # set defaults
    weather.defaults {units:'metric', lang:'de', mode:'json'}
    
    # id is Cologne, Germany
    weather.now {id:2886242}, (json) ->
      console.dir json

    # 2 days forecast
    weather.now {id:2886242, cnt:2}, (json) ->
      console.dir json      