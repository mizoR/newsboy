require 'im-kayac'
require 'feed-normalizer'
require 'clockwork'

include Clockwork

last_recieved = Time.now.utc - 3600

handler do |job|
  begin
    puts "Running #{job}"

    rss_urls = ENV['RSS_URLS'] ? ENV['RSS_URLS'].split : []
    username = ENV['IM_KAYAC_USERNAME']
    password = ENV['IM_KAYAC_PASSWORD']
    secret   = ENV['IM_KAYAC_SECRET']

    case
    when username && password
      # do nothing
    when username && secret
      # do nothing
    else
      raise ArgumentError, 'im.kayac.com token not found'
    end

    entry_list = rss_urls.reduce([]) do |entries, rss_url|
      feed = FeedNormalizer::FeedNormalizer.parse open(rss_url)
      entries + feed.entries
    end.sort_by(&:last_updated)

    entry_list.each do |entry|
      next if entry.last_updated.utc <= last_recieved
      last_recieved = entry.last_updated.utc

      case
      when secret
        ImKayac.to(username).handler(entry.url).secret(secret).post(entry.title)
      when password
        ImKayac.to(username).handler(entry.url).password(password).post(entry.title)
      end
    end
  rescue Exception => e
    puts e.inspect
    e.backtrace.each do |line|
      puts "\t#{line}"
    end
  end
end

every(5.minutes, 'im_kayac:notify', :at => ENV['AT'].split, :tz => ENV['TZ'])
