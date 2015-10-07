# Add a declarative step here for populating the DB with movies.
Given /^the following movies exist:$/ do |movies_table|
movies_table.hashes.each do |movie|
Movie.create!(movie)
# each returned element will be a hash whose key is the table header.
# you should arrange to add that movie to the database here.
end
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |arg1, arg2|
page.body.should match /#{arg1}.+Director.*#{arg2}/m
# express the regexp above with the code you wish you had
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  page.body.should match /#{e1}.*#{e2}/m
#assert page.body =~ /#{e1}.+#{e2}/m
# ensure that that e1 occurs before e2.
# page.content is the entire content of the page as a string.mo
end
# Make it easier to express checking or unchecking several boxes at once
# "When I uncheck the following ratings: PG, G, R"
# "When I check the following ratings: G"
When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  #fail "Unimplemented"
  if (uncheck)
   rating_list.split(', ').each {|x| step %{I uncheck "ratings_#{x}"}}
  else
   rating_list.split(', ').each {|x| step %{I check "ratings_#{x}"}}
  end
end


Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  # fail "Unimplemented"
  page.all('table#movies tbody tr').count.should == 10
end
