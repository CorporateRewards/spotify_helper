# CR Spotify Helper

[CircleCI](https://circleci.com/gh/CorporateRewards/spotify_helper)

Before you start, make sure you have a config/application.yml file that has the following populated.

```
spotify_id:
spotify_secret:
spotify_username:
```

To run the app locally, check out master and pull, then checkout your development branch from master.

Run docker-compose up to start the server, or BYEBUG=1 docker-compose up to enable byebug. You'll then need to open a new terminal window and run docker-compose exec app bash to jump in to the container where you can then start the server with rails s.

Once you are happy with your development branch, open a pull request to development for review.
