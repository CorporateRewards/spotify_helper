web: bundle exec puma -C config/puma.rb  
worker1: bundle exec sidekiq -e production -C config/sidekiq.yml  
worker2: bundle exec clockwork clock.rb