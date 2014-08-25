When /^I am on the (.+) page$/ do |page_name|
  visit path_to(page_name)
end

When /^I follow "([^"]*)"$/ do |link|
  begin
    click_link(link)
  rescue
    save_and_open_page
    raise
  end
end
