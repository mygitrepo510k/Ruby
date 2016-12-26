#Run the all queue: rake resque:work QUEUE=*
#run the separate queue: rake resque:work QUEUE=name_queue
#all rake commands rake -T
#delayed jobs rake rake resque:scheduler and the start rake resque:work QUEUE=*

require 'resque/tasks'
require 'resque_scheduler/tasks'

namespace :resque do
  task :setup => :environment do
    require 'resque'
    require 'resque_scheduler'
    require 'resque/scheduler'

    Resque.schedule = YAML.load_file("#{Rails.root}/config/resque_schedule.yml")
  end

  desc "Restart running workers"
  task :restart_workers => :environment do
    Rake::Task['resque:stop_workers'].invoke
    Rake::Task['resque:start_workers'].invoke
  end

  desc "Quit running workers"
  task :stop_workers => :environment do
    stop_workers
  end

  desc "Start workers"
  task :start_workers => :environment do
    run_worker()
  end


  def store_pids(pids, mode)
    pids_to_store = pids
    pids_to_store += read_pids if mode == :append

    # Make sure the pid file is writable.
    File.open(File.expand_path('tmp/pids/resque.pid', Rails.root), 'w') do |f|
      f <<  pids_to_store.join(',')
    end
  end

  def read_pids
    pid_file_path = File.expand_path('tmp/pids/resque.pid', Rails.root)
    return []  if ! File.exists?(pid_file_path)

    File.open(pid_file_path, 'r') do |f|
      f.read
    end.split(',').collect {|p| p.to_i }
  end

  def stop_workers
    pids = read_pids

    if pids.empty?
      puts "No workers to kill"
    else
      syscmd = "kill -s QUIT #{pids.join(' ')}"
      puts "$ #{syscmd}"
      `#{syscmd}`
      store_pids([], :write)
    end
  end

  def run_worker()
    puts "Workers starting with QUEUE: *"

    ##  make sure log/resque_err, log/resque_stdout are writable.
    ops = {:pgroup => true, :err => [(Rails.root + "log/resque_err").to_s, "a"],
           :out => [(Rails.root + "log/resque_stdout").to_s, "a"]}
    pids = []

    users = User.all

    RefillReminderJob.send_refill_reminder(users)
    ExpireReminderJob.send_expire_reminder(users)

    pid = spawn("rake resque:work QUEUE=*", ops)
    Process.detach(pid)
    pids << pid

    store_pids(pids, :append)
  end
end