class HelloController < ApplicationController
    def index
        render json: { message: "Ruby on Rails楽しそう" }
    end
end