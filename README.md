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
    
### (defaluts)

    units: ('metric'|'imperial'|'internal')
    lang:  ('en'|'ru'|'it'|'sp'|'ua'|'de'|pt'|'ro'|'pl'|'fi'|'nl'|'fr'|'bg'|'se'|'zh_tw'|zh_cn')
    mode:  'json' // for now only json support
    q:     'City Name e.g. London,UK or Berlin,Germany'
    cnt:   Number(forecast:number of days, find: 0..)
    id:    Number(city id)
    
    # history
    type:  ('tick'|'hour'|'day')
    start: Number(unix timestamp)
    end:   Number(unix timestamp)
    cnt:   Number(list count)
    
attribute \ function | defaults | now | daily | history | find
--------------------:|:--------:|:---:|:-----:|:-------:|:---:
q                    |     x    |  x  |   x   |    -    | x
id                   |     x    |  x  |   x   |    x    | -
cnt                  |     x    |  -  |   x   |    x    | x
start                |     x    |  -  |   -   |    x    | -
end                  |     x    |  -  |   -   |    x    | -
units                |     x    |  x  |   x   |    x    | x

### Examples

    weather = require 'openweathermap'
    
    # set defaults
    weather.defaults {units:'metric', lang:'de', mode:'json'}
    
    # id is Cologne, Germany
    weather.now {id:2886242}, (json) ->
      console.dir json

    # 2 days forecast
    weather.daily {id:2886242, cnt:2}, (json) ->
      console.dir json
      
    # history for 3 hours
    weather.history {type:'hour', id:2886242, cnt:3}, (json) ->
      console.dir json

    # find 3 berlins
    weather.find {q:'berlin', cnt:2}, (json) ->
      console.dir json

more infos about openweathermap.org at <http://openweathermap.org>

### changelog

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

