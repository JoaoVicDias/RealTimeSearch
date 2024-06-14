class SearchesController < ApplicationController
    def show
        @user_searches = Search.where(user: request.remote_ip).order(count: :desc)
    end

    def new
    end

    def create
        Searches::Facades::CreationPipeline.new(search_params).call
    end

    private

    def search_params
        params.require(:search).permit(:content).merge(
            user: request.remote_ip,
            count: 1
        )
    end
  end
  