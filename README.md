# good_night_app

## Models

1. `User` - contains information about user.
2. `SleepPeriod` - contains Clock In operations information.
3. `Following` - contains follofers data and following logic.

## Endpoints

1. Particular `User` info:

`GET /v1/users/:user_id`

2. Create `SleepPeriod`:

`POST /v1/sleep_periods` with params

```
{
  sleep_period: {
    user_id: integer(*),
    fall_asleep: time(*),
    wake_up: time
  }
}
```

3. Set `wake_up` to particular `SleepPeriod`:

`PUT /v1/sleep_periods/sleep_period_id/wake_up` with params

```
{
  sleep_period: {
    wake_up: time(*)
  }
}
```

4. List of `SleepPeriod`'s for particular `User`:

`GET /v1/users/:user_id/sleep_periods`

5. Follow by particular `User`:

`POST /v1/users/:user_id/follow` with params

```
{
  followings: {
    followee_id: integer(*)
   }
}
```

6. Follow particular `User`:

`DELETE /v1/users/:user_id/unfollow` with params

```

{
  followings: {
    followee_id: integer(*)
   }
}
```

7. Particular `User` followees list of `SleepPeriod`:

`GET /v1/users/:user_id/friend`


## Commands
1. `bin/puma` - run the App
2. `bin/console` - run the App`s console
3. `rspec` - run tests
4. `ruby ./db/seeds.rb` - generate users list
