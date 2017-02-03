namespace :tmp do
  namespace :pids do
    desc 'clears tmp/pids'
    task :clear do
      FileUtils.rm(Dir['tmp/pids/[^.]*'])
    end
  end
end

