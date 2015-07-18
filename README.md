#### How to use devise and cancancan gem instraction:
##### Get vidio tutorial: 
<a href="https://www.youtube.com/watch?v=DEyPpgs7EUk" target="_blank"><img src="http://i.ytimg.com/vi/DEyPpgs7EUk/maxresdefault.jpg" 
alt="IMAGE ALT TEXT HERE" width="240" height="180" border="10" /></a>



##### First Step
###### create a new rails app
 *terminal*
 `$ rails new devise_cancan `
 
 `$ rails g scaffold status post:text`

###### add gem to gemfile

**\Gemfile**
  ```ruby
  gem 'devise'
  gem 'cancancan'
  ```

##### Second Step
###### setup devise
 *terminal*
 `$ rails generate devise:install`


 **\config\environments\development.rb **
 ```ruby
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
 ```
** \config\routes.rb**
 ```ruby
  root 'statuses#index'
 ```
*terminal*
 `$ rails generate devise User`
 
 `$ rake db:migrate`
 
 `$ rails generate devise:views`

**\app\controllers\statuses_controller.rb**
 ```ruby
  before_action :authenticate_user!
 ```
 
**\app\views\layouts\application.html.erb**
 ```html.erb
 <% if user_signed_in? %>
     <%= link_to "sign out",destroy_user_session_path, method: :delete   %>
 <% end %>
 <br>
 ```
