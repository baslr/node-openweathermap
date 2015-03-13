node-openweathermap
===================

A small abstraction layer for the openweathermap API

### install

    $ npm install openweathermap

### methods

    # set defaults
    defaults(cfg)

    # return the weather right now
    now(cfg, callback)

    # get a 7 days every 3h forecast
    forecast(cfg, callback)

    # get up to 14 days daily forecast
    # cfg
    #  cnt:int(number of days for forecast)
    daily(cfg, callback)
    
    # get history for a city
    history(cfg, callback)
    
    # find
    #  cnt, beginns from 0, cnt 0 returns 1 item, cnt 1 returns 2 items
    find(cfg, callback)
    
### (defaults)

    units: ('metric'|'imperial'|'internal')
    lang:  ('en'|'ru'|'it'|'sp'|'ua'|'de'|'pt'|'ro'|'pl'|'fi'|'nl'|'fr'|'bg'|'se'|'zh_tw'|zh_cn')
    mode:  'json' // for now only json support
    q:     'City Name e.g. London,UK or Berlin,Germany'
    cnt:   Number(forecast:number of days, find: 0..)
    id:    Number(city id)
    
    # history
    type:  ('tick'|'hour'|'day')
    start: Number(unix timestamp)
    end:   Number(unix timestamp)
    cnt:   Number(list count)
    
attribute \ function | defaults | now | daily | history | find | forecast
--------------------:|:--------:|:---:|:-----:|:-------:|:----:|:--------:
q                    |     x    |  x  |   x   |    -    | x    |  x
id                   |     x    |  x  |   x   |    x    | -    |  x
cnt                  |     x    |  -  |   x   |    x    | x    |  -
start                |     x    |  -  |   -   |    x    | -    |  -
end                  |     x    |  -  |   -   |    x    | -    |  -
units                |     x    |  x  |   x   |    x    | x    |  x

### opts

    weather.ops({port:8080})

sets the port to 8080 for all following requests. The opts method is chainable.
Generally you can set all http.get [Node.js options](http://nodejs.org/api/http.html#http_http_request_options_callback).

### Examples

    weather = require 'openweathermap'
    
    # set defaults
    weather.defaults {units:'metric', lang:'de', mode:'json'}
    
    # id is Cologne, Germany
    weather.now {id:2886242}, (err, json) ->
      console.dir json

    # 2 days forecast
    weather.daily {id:2886242, cnt:2}, (err, json) ->
      console.dir json
      
    # history for 3 hours
    weather.history {type:'hour', id:2886242, cnt:3}, (err, json) ->
      console.dir json

    # find 3 berlins
    weather.find {q:'berlin', cnt:2}, (err, json) ->
      console.dir json
    
    # forecast for Okemos, MI
    weather.forecast {id: 5004359}, (err, json) ->
      console.dir json

more infos about openweathermap.org at <http://openweathermap.org>

### changelog

#### 1.0.0
* added error handling: Use node.js style Error-First Callbacks #5 (many thanks to @sweetpi)
* release v1.0.0
* release npm v1.0.0

#### 0.2.1
* fixes issue #4 bug: Return invalid json

#### 0.2.0
* node-openweathermap is now browserifiable, #2 (many thanks to @MikkoH)
* set http options via opts() eg. port ...

#### 0.1.1
* fixed #1
* resonse now in flow mode
* use <http://semver.org/>

#### 0.0.3
* added city history

#### 0.0.2
* added find

#### 0.0.1
* inital release
