namespace :fnordmetric do
  desc "Populate FnordMetric with events to simulate user activity"
  task :populate => :environment do
    articles = Article.all
    loop do
      articles.sample.trigger_view_event
      sleep(rand)
    end
  end
end