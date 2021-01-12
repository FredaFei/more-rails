class Api::FirstController < ApplicationController
  def hello
    # render plain: 'hello'
    render json: {message: '222 hello', name: 'freda', age: 12}
    # render 'first/hello'
  end
  
  def hi
    render plain: 'hi'
    # @name = 'first controller name'
    # render 'first/hi'
  end
end