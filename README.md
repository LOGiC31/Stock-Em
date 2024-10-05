# Stock-Em

HEROKU LIVE LINK: https://stockem-0caaa6588e50.herokuapp.com/welcome/index

Code Climate Report : ./codeclimate_report.json
Ruby Critic : [View the HTML file](overview.html)

Capstone Inventory Management System

**What I followed :**

create item model :

rails generate model Item item_id:string serial_number:string item_name:string category:string quality_score:integer currently_available:boolean image:string

create note model

rails generate model Note note_id:string item:references msg:string creator:references image:string date_created:datetime

create user model

rails generate model User user_id:string name:string uin:string email:string contact_no:string role:string details:string :auth_level:integer

create transaction model

rails generate model Event event_id:string item:references event_type:string associated_user:references associated_student:references location:string details:string

rails db:migrate -> to generate schema

rails db:seed -> to seed all the data (to check table)

**You don't need to generate models.**

_Clone the project._

_Run bundle install_

run _rails db:migrate_ to generate schema

run _rails db:seed_ to insert seed data for dev env

run _rails console_ to go into console mode.

run _Item.all, Note.all, Event.all_ to verify data is seeded properly.

---

Google OAuth Feature Added. Changes are merged in dev-branch. Run below mentioned commands after taking latest pull.

bundle install

rails db:migrate

rails server
