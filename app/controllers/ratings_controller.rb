class RatingsController < ApplicationController
  before_action :expire_brewery_list, except: [:index]

  def index
    # kato taa tehtavaan 12: https://stackoverflow.com/questions/8252112/rails-caching-continue-storing-expired-value
    @ratings = Rating.all
    @top_breweries = Brewery.top 3
    @top_beers = Beer.top 3
    @top_styles = Style.top 3
    @most_ratings = User.most_ratings 3
    @latest = Rating.recent
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:beer_id, :score)
    @rating.user = current_user
    if @rating.save
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to user_path(current_user)
  end
end
