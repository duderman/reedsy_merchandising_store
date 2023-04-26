# Reedsy Merchandising Store

Simple app that allows to list store items and get total price for a cart. It also has discounts configured for some items

## API

1. __`GET /`__ or __`GET /store`__: _Get a list of available items_

```bash
$ curl http://localhost:3000/ -s -v -X GET -H 'Content-Type: application/json; charset=utf-8' | jq '.'
*   Trying 127.0.0.1:3000...
* Connected to localhost (127.0.0.1) port 3000 (#0)
> GET / HTTP/1.1
> Host: localhost:3000
> User-Agent: curl/7.87.0
> Accept: */*
> Content-Type: application/json; charset=utf-8
>
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< X-Frame-Options: SAMEORIGIN
< X-XSS-Protection: 0
< X-Content-Type-Options: nosniff
< X-Download-Options: noopen
< X-Permitted-Cross-Domain-Policies: none
< Referrer-Policy: strict-origin-when-cross-origin
< Content-Type: application/json; charset=utf-8
< Vary: Accept
< ETag: W/"523d73dffbd6a93577dbcbb46ea85a21"
< Cache-Control: max-age=0, private, must-revalidate
< X-Request-Id: 445bffdc-f4e5-44dc-b861-9dec9f4669f5
< X-Runtime: 0.010335
< Server-Timing: start_processing.action_controller;dur=0.09, sql.active_record;dur=0.61, instantiation.active_record;dur=0.03, render.active_model_serializers;dur=0.44, process_action.action_controller;dur=2.43
< Transfer-Encoding: chunked
<
{ [189 bytes data]
* Connection #0 to host localhost left intact
{
  "store_items": [
    {
      "code": "MUG",
      "name": "New name",
      "price": "7.25"
    },
    {
      "code": "TSHIRT",
      "name": "Reedsy T-shirt",
      "price": "15.0"
    },
    {
      "code": "HOODIE",
      "name": "Reedsy Hoodie",
      "price": "20.0"
    }
  ]
}
```

2. __`PATCH /store/:code/`__: _Update item price and/or name_


```bash
#
# Success:
#
$ curl http://localhost:3000/store/MUG -s -v \
  -X PATCH \
  -H 'Content-Type: application/json; charset=utf-8' \
  -d $'{"store_item": {"name": "New name", "price": 7.25}}' | jq '.'
*   Trying 127.0.0.1:3000...
* Connected to localhost (127.0.0.1) port 3000 (#0)
> PATCH /store/MUG HTTP/1.1
> Host: localhost:3000
> User-Agent: curl/7.87.0
> Accept: */*
> Content-Type: application/json; charset=utf-8
> Content-Length: 51
>
} [51 bytes data]
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< X-Frame-Options: SAMEORIGIN
< X-XSS-Protection: 0
< X-Content-Type-Options: nosniff
< X-Download-Options: noopen
< X-Permitted-Cross-Domain-Policies: none
< Referrer-Policy: strict-origin-when-cross-origin
< Content-Type: application/json; charset=utf-8
< Vary: Accept
< ETag: W/"396c09ab899446433b88d780f0bb2121"
< Cache-Control: max-age=0, private, must-revalidate
< X-Request-Id: 12d6732a-c45c-413c-8d88-ec2e5097cef9
< X-Runtime: 0.009814
< Server-Timing: start_processing.action_controller;dur=0.13, sql.active_record;dur=1.83, instantiation.active_record;dur=0.03, render.active_model_serializers;dur=0.18, process_action.action_controller;dur=3.36
< Transfer-Encoding: chunked
<
{ [73 bytes data]
* Connection #0 to host localhost left intact
{
  "store_item": {
    "code": "MUG",
    "name": "New name",
    "price": "7.25"
  }
}



#
# With incorrect params:
#
$ curl http://localhost:3000/store/MUG -s -v \
  -X PATCH \
  -H 'Content-Type: application/json; charset=utf-8' \
  -d $'{"store_item": {"name": ""}}' | jq '.'
*   Trying 127.0.0.1:3000...
* Connected to localhost (127.0.0.1) port 3000 (#0)
> PATCH /store/MUG HTTP/1.1
> Host: localhost:3000
> User-Agent: curl/7.87.0
> Accept: */*
> Content-Type: application/json; charset=utf-8
> Content-Length: 28
>
} [28 bytes data]
* Mark bundle as not supporting multiuse
< HTTP/1.1 422 Unprocessable Entity
< X-Frame-Options: SAMEORIGIN
< X-XSS-Protection: 0
< X-Content-Type-Options: nosniff
< X-Download-Options: noopen
< X-Permitted-Cross-Domain-Policies: none
< Referrer-Policy: strict-origin-when-cross-origin
< Content-Type: application/json; charset=utf-8
< Vary: Accept
< Cache-Control: no-cache
< X-Request-Id: 9202fc94-8849-4812-958e-e9d55f59c542
< X-Runtime: 0.008686
< Server-Timing: start_processing.action_controller;dur=0.10, sql.active_record;dur=1.42, instantiation.active_record;dur=0.03, render.active_model_serializers;dur=0.22, process_action.action_controller;dur=2.75
< Transfer-Encoding: chunked
<
{ [49 bytes data]
* Connection #0 to host localhost left intact
{
  "errors": {
    "name": [
      "can't be blank"
    ]
  }
}


#
# 404:
#
$ curl http://localhost:3000/store/UNKNOWN -v \
  -X PATCH \
  -H 'Content-Type: application/json; charset=utf-8' \
  -d $'{}'
*   Trying 127.0.0.1:3000...
* Connected to localhost (127.0.0.1) port 3000 (#0)
> PATCH /store/UNKNOWN HTTP/1.1
> Host: localhost:3000
> User-Agent: curl/7.87.0
> Accept: */*
> Content-Type: application/json; charset=utf-8
> Content-Length: 2
>
* Mark bundle as not supporting multiuse
< HTTP/1.1 404 Not Found
< X-Frame-Options: SAMEORIGIN
< X-XSS-Protection: 0
< X-Content-Type-Options: nosniff
< X-Download-Options: noopen
< X-Permitted-Cross-Domain-Policies: none
< Referrer-Policy: strict-origin-when-cross-origin
< Content-Type: application/json; charset=utf-8
< Vary: Accept
< Cache-Control: no-cache
< X-Request-Id: 83982677-5846-48ef-bd20-378f75a3e784
< X-Runtime: 0.024315
< Server-Timing: start_processing.action_controller;dur=0.08, sql.active_record;dur=0.71, instantiation.active_record;dur=0.01, render.active_model_serializers;dur=0.06, process_action.action_controller;dur=3.17
< Transfer-Encoding: chunked
<
* Connection #0 to host localhost left intact
{"error":"not_found"}
```

3. __`GET /store/total`__: _Calculate total for items in the "cart"_

```bash
$ curl http://localhost:3000/store/total -s -v \
  -X GET \
  -H 'Content-Type: application/json; charset=utf-8' \
  -d $'{"cart": {"items": {"MUG":"45", "TSHIRT":"3"}}}' | jq '.'
*   Trying 127.0.0.1:3000...
* Connected to localhost (127.0.0.1) port 3000 (#0)
> GET /store/total HTTP/1.1
> Host: localhost:3000
> User-Agent: curl/7.87.0
> Accept: */*
> Content-Type: application/json; charset=utf-8
> Content-Length: 47
>
} [47 bytes data]
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< X-Frame-Options: SAMEORIGIN
< X-XSS-Protection: 0
< X-Content-Type-Options: nosniff
< X-Download-Options: noopen
< X-Permitted-Cross-Domain-Policies: none
< Referrer-Policy: strict-origin-when-cross-origin
< Content-Type: application/json; charset=utf-8
< Vary: Accept
< ETag: W/"63e3b41dcf2e5cbfc4d5dd074b9be226"
< Cache-Control: max-age=0, private, must-revalidate
< X-Request-Id: 0b883bcb-c5c8-4e11-b911-cf3afabf7696
< X-Runtime: 0.118184
< Server-Timing: start_processing.action_controller;dur=0.08, sql.active_record;dur=0.77, instantiation.active_record;dur=0.76, render.active_model_serializers;dur=0.05, process_action.action_controller;dur=4.92
< Transfer-Encoding: chunked
<
{ [28 bytes data]
* Connection #0 to host localhost left intact
{
  "total": "279.9"
}
```

## Installation and usage

1. Make sure Ruby 3.2.2 is installed

2. Clone the repo

```bash
git clone git@github.com:duderman/reedsy_merchandising_store.git
```

3. Install required gems

```bash
bundle install
```

4. Initialize and seed DB

```bash
bundle exec rails db:setup
```

5. Start Rails server

```bash
bundle exec rails server
```

6. To run RSpec tests

```bash
bundle exec rspec
```
