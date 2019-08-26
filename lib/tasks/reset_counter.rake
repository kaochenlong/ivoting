namespace :db do
  desc 'Reset DB Counter Cache'
  task :reset_counter => :environment do
    Candidate.all.each do |c|
      Candidate.reset_counters(c.id, :vote_logs)
    end
  end
end
