class FirstController < ApplicationController
  def hello
    # render plain: 'hello'
    # render json: {name: 'freda', age: 12}
    render 'first/hello'
  end
  def hi
    @name='first controller name'
    render 'first/hi'
  end
end