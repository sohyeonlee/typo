
Given /^the admin user and non-admin user is set up$/ do
  Blog.default.update_attributes!({:blog_name => 'The Blog',
                                   :base_url => 'http://localhost:3000'});
  Blog.default.save!
  User.create!({:login => 'admin',
                :password => 'aaaaaaaa',
                :email => 'joe@snow.com',
                :profile_id => 1,
                :name => 'admin',
                :state => 'active'});
  User.create!({:login => 'user1',
                :password => '123456789',
                :email => 'example@snow.com',
                :profile_id => 2,
                :name => 'non-admin',
                :state => 'active'});
end

And /^I have an article with id "(.*)", title "(.*)" and content "(.*)"$/ do |id, title, content|
  Article.create!(:allow_comments => true,
                 :allow_pings => true, 
                 :author => "admin", 
                 :body => content, 
                 :id => id, 
                 :permalink => "first-article", 
                 :post_type => "read", 
                 :published => true, 
                 :published_at => "2012-06-09 21:51:55 UTC", 
                 :settings => {"password"=>""}, 
                 :state => "published", 
                 :text_filter_id => 5, 
                 :title => title, 
                 :type => "Article", 
                 :user_id => 1);
end
  
  

And /^I am logged into the non-admin panel$/ do
  visit '/accounts/login'
  fill_in 'user_login', :with => 'user1'
  fill_in 'user_password', :with => '123456789'
  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('Login successful')
  else
    assert page.has_content?('Login successful')
  end
end