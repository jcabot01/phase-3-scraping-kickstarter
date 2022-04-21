# require libraries/modules here
require 'nokogiri'
require 'pry'

  # projects: kickstarter.css("li.project.grid_4")      #when there's a space in the class name; "project grid_4", you add a . inbetween
  # title: project.css("h2.bbcard_name strong a").text
  # image link: project.css("div.project-thumbnail a img").attribute("src").value
  # description: project.css("p.bbcard_blurb").text
  # location: project.css("span.location-name").text
  # percent funded: project.css("ul.project-stats li.first.funded strong").text     #when there's a space in the class name; "first funded", you add a . inbetween
  #   ==>  let's add .gsub("%", "").to_i  to remove the percent sign and convert it to an integer
  # percent funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {} #projects is an empty hash where we can store data

  #iterate through the projects
  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {    #converting the title to a symbol using the to_sym method.  Symbols make better hash keys than strings.
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
    }   
  end

  #return projects hash
  projects
end
