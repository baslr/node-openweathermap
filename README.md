fastango
========
supercharged arangodb poc client

# impelentation status

## drawbacks
- not all functions impleneted
- all request go into the same queue. on socket error this queue will resubmited to the db -> split queue to pipelined an non pipelined requests
- no cursor iteration (possbile when async functions land in in ES7)



## initialize client
```coffeescript
parser = new (require 'fastango/parser') 'IP', PORT
require('fastango/fastango') parser, '_system', (status, fastango) ->
  if status >= 400
    'some error'
    return
  'now you can use fastango'
```

## database
## _use
```coffeescript
fastango._use 'myDb', (status, fastango) ->
  if status >= 400
    'some error'
```

Change the database. Note: the old fastango object points to the old db. You have to use the newly returned fastango object.

## collections
### truncate
```coffeescript
fastango.testCollection.truncate (status, heads, body) ->
  if status >= 400
    'some error'
```
### drop
```coffeescript
fastango.testCollection.drop (status, heads, body) ->
  if status >= 400
    'some error'
```
### _createDocumentCollection
```coffeescript
fastango._createDocumentCollection 'NAME', {options}, (status, heads, body) ->
  if status >= 400
    'some error'
```
for options see <https://docs.arangodb.com/HttpCollection/Creating.html>

## documents
### save
```coffeescript
fastango.testCollection.save JSON.strinigfy({key:'value'}), (status, heads, body) ->
  if status >= 400
    'some error'
```

### document
```coffeescript
fastango.testCollection.document '_key', (status, heads, body) ->
  if status >= 400
    'some error'
```
### count
```coffeescript
fastango.testCollection.count (status, heads, body) ->
  if status >= 400
    'some error'
```

## misc
### _query
```coffeescript
fastango._query 'FOR doc IN docs RETURN doc._key', {bindVars}, {options}, (status, cursor) ->
  if status >= 400
    'some error'
    return
  cursor.all (status, results) ->
    if status >= 400
      'some error'
```
for options see <https://docs.arangodb.com/HttpAqlQueryCursor/AccessingCursors.html>
example:

```coffeescript
fastango._query 'FOR doc IN docs RETURN doc._key', {}, {fullCount:true, maxPlans:1}, (status, cursor) ->
```

for the moment only `cursor.all` is supported.

### _transaction
```coffeescript
fastango._transaction {
  params:
    a: 4
  collections: ['col1', 'col2'] | # optional
    read: ['col1', 'col2']
    write: ['col1', 'col2']
  waitForSync: true|false # optional
  lockTimeout: UNUMBER # optional
}, (params) -> # the action function
  return params.a
, (status, headers, body) ->
  if status >= 400
    'some error'
```
