namespace :post do
  desc "Get new posts"
  task get_new_posts: :environment do
    DataSourceService.update_posts
  end
end
