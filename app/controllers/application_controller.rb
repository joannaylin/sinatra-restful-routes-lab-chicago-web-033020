class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # index
  get "/recipes" do 
    @recipes = Recipe.all
    erb :index 
  end

  # create new recipe
  get "/recipes/new" do
    erb :new
  end

  # creates a new recipe 
  post "/recipes" do
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end

  # read single recipe 
  get "/recipes/:id" do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  # edit form 
  get "/recipes/:id/edit" do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  # update entry 
  patch "/recipes/:id" do
    @recipe = Recipe.find(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end

  # delete a recipe
  delete "/recipes/:id" do
    @recipe = Recipe.find(params[:id])
    @recipe.destroy 
    redirect to "/recipes"
  end

end
