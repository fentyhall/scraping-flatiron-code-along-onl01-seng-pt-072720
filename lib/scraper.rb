require 'nokogiri'
require 'open-uri'
# require 'pry'

require_relative './course.rb'

class Scraper

  # get_page contain only the code for getting HTML doc
  def get_page 
    doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
    # doc.css(".post").each do |post|
    #   course = Course.new 
    #   course.title = post.css("h2").text
    #   course.schedule = post.css(".date").text
    #   course.description = post.css("p").text
    # end 
  end 

  # get_courses responsible for using CSS selector
  # return value should be a collection of Nokogiri 
  # XML elements
  def get_courses
    self.get_page.css(".post")
  end 

  # make_courses is responsible for instantiating Course
  def make_courses 
    self.get_courses.each do |post|
      course = Course.new 
      course.title = post.css("h2").text 
      course.schedule = post.css(".date").text 
      course.description = post.css("p").text 
    end 
  end 
  
  # print_courses calls on .make_courses and iterates
  # all courses that get created to puts out a list of
  # course offerings
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  
end

# Scraper.new.get_page 
Scraper.new.print_courses 