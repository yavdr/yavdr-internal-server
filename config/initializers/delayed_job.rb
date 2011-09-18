#Delayed::Worker.destroy_failed_jobs = true
Delayed::Worker.sleep_delay = 30
#Delayed::Worker.max_attempts = 1
Delayed::Worker.max_run_time = 5.minutes
Delayed::Worker.delay_jobs = !Rails.env.test?