class DogsController < ApplicationController
  
  get "/dogs" do
    Dog.all.to_json(methods: [:age])
  end

  get "/dogs/:id" do 
    
  end

  post "/dogs" do 
    # puts params
    Dog.create(dog_params).to_json(methods: [:age])
  end

  patch "/dogs/:id" do
    # binding.pry
    dog = Dog.find_by_id(params[:id])
    dog.update(dog_params)
    dog.to_json(methods: [:age])
  end

  delete "/dogs/:id" do 
    dog = Dog.find_by_id(params[:id])
    dog.destroy
    dog.to_json
    # if you want to send back a no_content response instead, use the following line
    # status 204 
  end

  private 

  # a method used to specify which keys are allowed through params into the controller
  # we use this method to create a list of what's permitted to be passed to .create or .update
  # within controller actions.
  def dog_params
    allowed_params = %w(name birthdate breed image_url)
    params.filter do |param, value|
      allowed_params.include?(param)
    end
  end

end