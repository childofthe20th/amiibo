class AmiiboController < ApplicationController
    skip_before_action :verify_authenticity_token


    def index
        render json: Amiibo.all
    end

    def show
        render json: Amiibo.find(params["id"])
    end

    def create
        render json: Amiibo.create(params["amiibo"])
    end

    def delete
        render json: Amiibo.delete(params["id"])
    end

    def update
        render json: Amiibo.update(params["id"], params["amiibo"])
    end
end
