# README

This a project about api creation about games.

Things you may want to cover:

* Ruby version 3.2.0
* Rails Version 7.0.4

## Features

This project comes with
- Use rails_jwt_auth for authincation users in api
- Rspec tests
- Code quality tools
- Docker support
- Exception Tracking (Rollbar)
- RSpec API Doc Generator (pending)

## How to use with docker

We created some bin options for help to work with docker.

From the root of the project. 

For build and install docker containers/images 
```sh
  bin/setup
```

If you want to connect _bash_ (shell) of the container of the project
```sh
  bin/open api
  # or
  docker container exec api bash
```

If you want to view the log of the rails server in real time
```sh
  bin/as_server
```

If you want to stop all containers:
```sh
  bin/stop
```
