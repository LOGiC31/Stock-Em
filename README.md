# Stock-Em

Capstone Inventory Management System

Clone the repository.
Move to stockem folder.
Run bundle install.

What I followed :

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

Clone the project.

Run bundle install

You don't need to generate models.

run rails db:migrate to generate schema

run rails db:seed to insert seed data for dev env

run rails console to go into console mode.

run Item.all, Note.all, Event.all to verify data is seeded properly.
