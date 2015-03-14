#!/usr/bin/env ruby
# File:  rid.rb

require "open-uri"
require "uri"
require "rack/mime"

require "ruby-progressbar"
require "nokogiri"

class RID
  def initialize(url = nil, folder = nil)
    if url and folder
      self.download(self.get_images_urls(url), folder)
    end
  end
  def get_images_urls(url)
    unless url =~ URI::regexp
      raise "Url `#{url}` is not valid!"
    end
    urls = []
    Nokogiri::HTML(open(url)).css('img').each do |image_tag|
      image_src = image_tag["src"].to_s
      next if image_src.empty?
      if image_src[0..1] === "//"
        image_src = "http:#{image_src}"
      elsif image_src[0] === "/"
        image_src = "#{url}#{image_src}"
      end
      urls.push image_src
    end
    urls
  end
  def download(urls, folder)
    unless Dir.exist?(folder)
      raise "Folder `#{folder}` doesn't exist."
    end

    progress_bar = ProgressBar.create(  :format         => '%a %bᗧ%i %p%% %t',
                                        :progress_mark  => ' ',
                                        :remainder_mark => '･',
                                        :total          => urls.length)

    urls.each { |url|
      uri = URI.parse(url)
      filename = File.basename(uri.path, ".*")
      open(url) {|f|
        extension = Rack::Mime::MIME_TYPES.invert[f.content_type]
        File.open("#{folder}/#{filename}#{extension}","wb") do |file|
          file.puts f.read
        end
        progress_bar.increment
      }
    }
  end
end

if ARGV[0] and ARGV[1]
  RID.new ARGV[0], ARGV[1]
else
  puts "Usage: ruby rid.rb <url-with-images> <path-to-folder>"
end
