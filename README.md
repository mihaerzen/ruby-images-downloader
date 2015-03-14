# ruby-images-downloader
Script for downloading images from the world wide web.

## Requirements

### nokogiri
Used for parsing the html.

    gem install nokogiri

### ruby-progressbar
Everyone likes to see progress in a script right?

    gem install ruby-progressbar

## Usage

    ruby rid.rb <url-with-images> <path-to-folder>

### Example

    ruby rid.rb http://www.example.com ~/Downloads/ExistingFolder

## Test

    ruby -w rid_test.rb