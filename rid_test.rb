#!/usr/bin/env ruby
# File:  rid_test.rb

require_relative "rid"
require "test/unit"
require "fileutils"

class TestRID < Test::Unit::TestCase

  TEST_URL = "http://mihaerzen.github.io/ruby-images-downloader/"

  EXPECTED_URLS_ARRAY = [
    "http://placehold.it/200",
    "http://placehold.it/300",
    "https://placehold.it/400"
  ]

  def setup
    @RID = RID.new()
  end

  def test_get_images_urls
    images_url = @RID.get_images_urls(TEST_URL)
    assert_equal EXPECTED_URLS_ARRAY.length, images_url.length
    EXPECTED_URLS_ARRAY.each_with_index do |expected_url, index|
      assert_equal(expected_url, images_url[index])
    end
  end

  def test_download
    folder = "test_folder"
    unless Dir.exist?(folder)
      Dir.mkdir folder
    end
    images_url = @RID.get_images_urls(TEST_URL)
    @RID.download images_url, folder
    files = Dir["#{folder}/*"]
    assert_equal(files.length, images_url.length)
    FileUtils.rm_rf folder
  end

end