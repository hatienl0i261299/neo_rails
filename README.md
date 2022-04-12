# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:
* Ruby version
```
6.1.4
```

* Ruby version
```
3.0.3
```
```
docker-compose build
docker-compose up
docker-compose run web_rails rails db:create db:migrate
```

* Exec the container
```
docker exec -it web_rails /bin/bash
```

* Application at
```
http://localhost:3000/
```

* Create a superuser
```
rails create_superuser:run[root,root]
```

* Server at
```
http://localhost:5555/
```

* Install git hook
```
./scripts/install-hooks.bash
```

* Migrate and seed data for production
```
RAILS_ENV=production DISABLE_DATABASE_ENVIRONMENT_CHECK=1
```