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


 **\config\environments\development.rb**
 ```ruby
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
 ```
 
**\config\routes.rb**
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
 
 ##### Third step
 ###### setup cancancan abilities:

 *terminal*
 
  `$ rails g cancan:ability`
 
  `$ rails generate migration add_roles_mask_to_users roles_mask:integer`
  
  `$ rake db:migrate`

**\app\models\user.rb**

 ```ruby
 ROLES = %i[admin author]

 def roles=(roles)
   roles = [*roles].map { |r| r.to_sym }
   self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
 end

 def roles
   ROLES.reject do |r|
     ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
   end
 end

 def has_role?(role)
   roles.include?(role)
 end
```


**\app\controller\application_controller.rb**

 ```ruby
 before_action :configure_permitted_parameters, if: :devise_controller?
 protected

 def configure_permitted_parameters
   devise_parameter_sanitizer.for(:sign_up)  { |u| u.permit(  roles: [], :email,:password, :password_confirmation ) }
 end
 ```
 
**\app\views\devise\registrations\new.html.erb**

 ```html.erb
<% for role in User::ROLES %>
  <%= check_box_tag "user[roles][#{role}]", role, @user.roles.include?(role), {:name => "user[roles][]"}%>
  <%= label_tag "user_roles_#{role}", role.to_s.humanize %><br />
<% end %>
<%= hidden_field_tag "user[roles][]", "" %>
 ```
 
**\app\models\ability.rb**

 ```ruby
   user ||= User.new
   if user.has_role? :admin
     can :manage, :all
   elsif user.has_role? :author
     can :create, Status
     can :update, Status
   else
     can :read, :all
   end
 ```
**\app\controllers\statuses_controller.rb**

 ```ruby
  load_and_authorize_resource
 ```

Now Test It !!
