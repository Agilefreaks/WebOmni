When(/^I am on the (.+) page$/) do |page_name|
  visit path_to(page_name)
end

When(/^I follow "([^"]*)"$/) do |link|
  click_link(link)
end
