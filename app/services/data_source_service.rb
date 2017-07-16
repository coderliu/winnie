class DataSourceService
  def self.update_posts
    update_siming_posts
    Rails.logger.info "Posts updated"
  end

  def self.update_siming_posts
    host = 'http://www.smjy.net'
    list_uri = host + '/web/info/Meeting/'
    reps = Net::HTTP.get_response(URI.parse(list_uri))
    doc = Nokogiri::HTML(reps.body)
    posts = doc.css('.tab_exam3 a')
    posts.each do |post|
      url = host + post['href']
      title = post.text
      if title.include?('招聘') && !title.include?('中学') && !title.include?('结果') && !Post.where(district: :siming, url: url).first
        content_reqs = Net::HTTP.get_response(URI.parse(url))
        content_doc = Nokogiri::HTML(content_reqs.body)
        content = content_doc.css('.exam_content').first.text.strip
        Post.create(title: title, url: url, content: content, include_english: content.include?('英语'), district: :siming)
      end
    end
  end
end
