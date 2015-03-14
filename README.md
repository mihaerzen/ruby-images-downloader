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

## Some images for testing

![200](//placehold.it/200 "No prefix")
![300](http://placehold.it/300 "http")
![400](https://placehold.it/400 "https")