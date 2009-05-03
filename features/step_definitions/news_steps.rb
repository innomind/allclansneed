Given /^I create a news with title "([^\"]*)"$/ do |title|
  visit new_onenews_path
  fill_in "news_title", :with => title
  fill_in "news_news", :with => "dies ist nur eine testnews"
  fill_in "news_subtext", :with => "dies ist nur eine testnews"
  click_button "News erstellen"
  response.should contain("News erstellt")
end
