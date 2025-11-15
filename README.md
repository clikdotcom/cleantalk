# CFML Cleantalk Implementation

Simple component for connecting to the CleanTalk API via CFML

## Usage

Initialise with your CleanTalk auth key 

```javascript
cleantalk = new cleantalk.cleantalk(auth_key=auth.auth_key);
```

and then call `cleantalk.check_message()`. The result is a struct but the only necessary key is `allowed (boolean)`. 

See `test/test_cleantalk` for an example.


