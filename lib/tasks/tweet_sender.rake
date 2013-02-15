namespace :tweet_sender do
  desc "List tweets that are ready to be sent"
  task :list => :environment do
    Post.tweets_ready.each do |post|
      puts "* #{post.message}"
    end
  end

  desc "Sent them"
  task :sent => :environment do
    Post.tweets_ready.each do |post|
    end
  end

end
