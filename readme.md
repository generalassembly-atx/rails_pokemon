# More Rails Practice!

![](http://i.imgur.com/oJkBNgX.jpg)

## Part 1 – Setup and Index

* We're going to create a Pokémon application! In this folder run `rails new pokemon_app -d postgresql` and `cd pokemon_app`. Run `rake db:create`.

* Let's create our Pokémon model. Run `rails generate model Pokemon name kind number:integer`. Look at the file inside your `db/migrate` folder to see the generated migration.
  - Look at `app/models/pokemon.rb` to see your new model file.

* Run `rake db:migrate` to set up your database and run the migration. Run `rake db:rollback`. What happened? Run `rake db:migrate` again to undo your rollback.

* Run `rails generate controller Pokemons`. Open `app/controllers/pokemons_controller.rb`.

* Inside of your controller, add this controller action:
```ruby
def index
  @pokemons = Pokemon.all
end
```

* Run `rails s` and visit `http://localhost:3000/pokemons`. What happens? You should get a routing error.

* Add `resources :pokemons` to line 2 of your `config/routes.rb` file. Refresh your `http://localhost:3000/pokemons` page. The error should change! We've now set up the route, but we don't have a view.

* Create the file `app/views/pokemons/index.html.erb`. Refresh the page. No errors! Notice that we didn't have to `render` `index.html.erb` like we did in Sinatra.

* Add the following code to `index.html.erb`:
```html
<h1>My Pokemon</h1>
<% @pokemons.each do |pokemon| %>
  <p><%= pokemon.name %></p>
<% end %>
```

* In Terminal, run `rails console`. In the console, run `Pokemon.create(name: "Pikachu", kind: "electric", number: 25)` and `Pokemon.create(name: "Charmander", kind: "fire", number: 4)`. Refresh your `http://localhost:3000/pokemons` page. What happened?

* In Terminal, run `rake routes`. You should see a list of all RESTful routes for your Pokémon resource. Look at the relationship between `GET '/pokemons'` and `pokemons#index`. What should the route for the show page be?

## Part 2 – Show

* Add a show action to your controller:
```ruby
def show
  @pokemon = Pokemon.find(params[:id])
end
```

* Create a `show.html.erb` view, and add the following code:
```html
<h1><%= @pokemon.name %> – <%= @pokemon.number %></h1>
<h4><%= @pokemon.kind.capitalize %></h4>
```
  - Visit `http://localhost:3000/pokemons/1`.

* In `index.html.erb`, change line 3 to:
```html
<p><%= link_to(pokemon.name, "/pokemons/#{pokemon.id}") %></p>
```
  - What happened?

* Now change it to:
```html
  <p><%= link_to(pokemon.name, pokemon) %></p>
```
- This should work! Why is this magical?

## Part 3 – New and Create

* Create an empty `new` and a `create` action in the controller. Set up a `new.html.erb` view. Visit 'http://localhost:3000/pokemons/new'.

* [Use `form_for` to set up the new form for your Pokémon. (Click for RailsGuides link!)](http://guides.rubyonrails.org/form_helpers.html#binding-a-form-to-an-object)

* Once your form is set up, put the following code into your `create` action:
```ruby
def create
  @pokemon = Pokemon.new
  @pokemon.name = params["pokemon"]["name"]
  @pokemon.kind = params["pokemon"]["kind"]
  @pokemon.number = params["pokemon"]["number"]
  @pokemon.save

  redirect_to @pokemon
end
```

* This should work! What is the difference between `new` and `create`?

* Just for kicks, run `rails generate resource Master name`. This gives you your migration, model, controller, routes, and views folder!

## Bonus – Edit, Update, Delete

* Set up the `edit`, `update`, and `delete` controller actions and views for the Pokemon class.

## Super Bonus - Associations

* Run another migration to add a `master_id` to the Pokemon class. Set up an association between Pokemon and Master, and set up a Master show page that lists a Master's Pokemons.
