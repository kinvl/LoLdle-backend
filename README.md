<br>

<p align="center">
  <img src="/Assets/banner-light-mode.png#gh-light-mode-only" width="240"/>
  <img src="/Assets/banner-dark-mode.png#gh-dark-mode-only"  width="240"/>
</p>

<p align="center">
    <strong><a href="#features">Features</a></strong> |
    <strong><a href="#endpoints">Endpoints</a></strong> |
    <strong><a href="#deployment">Deployment</a></strong>
</p>

## Features
LoLdle-backend made using Vapor framework; written in Swift. 📲 <br>
Works together with [LoLdle](https://github.com/kinvl/LoLdle).

## Endpoints
|   Endpoint   |   Method   |   Description   |   Response   | 
:-------------:|:----------:|:---------------:|:-------------:
challenge/champion/ | GET | Get today's champion LoLdle | [Challenge.Public](https://github.com/kinvl/LoLdle-backend/blob/master/Sources/App/Model/Database%20Models/Challenge.swift#L32)
challenge/champion/answer/ | POST | Mark today's champion LoLdle as completed | [Statistic.Public](https://github.com/kinvl/LoLdle-backend/blob/master/Sources/App/Model/Database%20Models/Statistic.swift#L32)
data/champions/ | GET | Get all champions from database and base icon URL | [Champion.PublicData](https://github.com/kinvl/LoLdle-backend/blob/master/Sources/App/Model/Database%20Models/Champion.swift#L58)
data/count/ | GET | Get number of champions in database | ["champions": Int]
statistics/ | GET | Get statistics of all today's LoLdles | [[Statistic.Public](https://github.com/kinvl/LoLdle-backend/blob/master/Sources/App/Model/Database%20Models/Statistic.swift#L32)]

## Deployment
### Heroku
Please refer to official [Vapor documentation](https://docs.vapor.codes/deploy/heroku/) about deploying to Heroku.

### Local
Setup and run a PostgreSQL database. Download this repository to your local machine and open it in Xcode. <br>
Go to _Product_ > _Scheme_ > _Edit scheme_ > _Run/Test_ > _Arguments_ and set **DATABASE_NAME**, **DATABASE_HOST**, **DATABASE_USERNAME** and **DATABASE_PASSWORD** environment variables. <br>
Run the project. By default, your app can be accessed at `127.0.0.1:8080`.
