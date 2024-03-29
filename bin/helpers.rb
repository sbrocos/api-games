DELAY = 3

$steps_counter = 1
$steps_messages = []

@puma_start_command = 'bundle exec puma -C config/_puma.rb'
@puma_stop_command  = 'pkill -f puma'

def wait(details, delay = DELAY)
  puts "Waiting #{delay} seconds #{details}"
  sleep(delay)
end

def step_info(message)
  info_message = "#{$steps_counter}. #{message}"
  puts info_message
  $steps_counter = $steps_counter.next
  $steps_messages << info_message
end

def system!(*args)
  system(*args) || abort("\n== Command #{args} failed ==")
end

def container_exec(container_name = 'api', cmd = 'ls')
  to_exec = "docker compose -f docker-compose.yml exec #{container_name} #{cmd}"
  puts to_exec
  system(to_exec)
end

def container_bash_exec(container_name = 'api', cmd = 'ls', detached = false)
  detached = detached ? '-d' : ''
  to_exec = "docker compose -f docker-compose.yml exec #{detached} #{container_name} /bin/bash -c '#{cmd}'"
  puts to_exec
  system(to_exec)
end

def check_docker!
  unless system('docker -v')
    puts "Docker not found"
    exit 1
  end
end

def inside_rails_conainer?
  if system('docker -v')
    puts "Docker is found. Looks like you are on the HOST machine"
    return false
  else
    puts "Docker is not found. Looks like you are in the container"
    return true
  end
end

def prompt!(message = "Are you sure to continue? [y/Y]")
  puts message
  prompt = STDIN.gets.chomp

  unless prompt.downcase == 'y'
    puts "Bye! See you next time!"
    exit 1
  end
end

def containers_information
  puts "\n" + ("~" * 50) + "\n"
  system("docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.ID}}'")
  puts ("~" * 50) + "\n"
end

# todo: update with --remove-orphans

def start_all_containers
  system('docker compose -f docker-compose.yml up -d')
end

def stop_all_containers
  system('docker compose -f docker-compose.yml down')
end

def rails_install_gems
  puts "Install Gems"
  container_bash_exec('api', 'bundle install')
end

def rails_db_migrate
  puts "DB Migrate"
  container_bash_exec('api', 'rake db:migrate')
end

def puma_start
  puts "Launching PUMA"
  container_bash_exec('api', @puma_start_command, detached = true)
end

def puma_stop
  puts "Stopping PUMA"
  container_bash_exec('api', @puma_stop_command)
end

def puma_restart
  puma_stop
  puma_start
end
