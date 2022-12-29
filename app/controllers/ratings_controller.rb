class RatingsController < ApplicationController
  before_action :expire_brewery_list, except: [:index]

  def index
    # Tämän cachettaminen pitäisi ratkaista, laajemman pohdinnan kautta:
    # - jos halutaan/voidaan ottaa käyttöön redis-tietokanta, voidaan kakuttaa ajastetuilla funktioilla melko näppärästi
    # - jos redis ei ole vaihtoehto, tarjolla olevat gemit vähenee dramaattisesti
    #   - yksi vaihtoehto voisi olla DelayedJob -> https://github.com/tobi/delayed_job (näyttää kuitenkin aika kuolleelta)
    #   - toinen vaihtoehto voisi olla whenever gemi, mutta tällöin tarvitaan mahdollisuus crontabin käyttöön
    # Tähän ei ole helppoja ratkaisuja ja jokainen ratkaisu tuntuisi olevan alustariippuvainen.
    # Tästä syystä jätän tehtävän tekemättä, koska mielestäni puolivillaisen ad hoc -ratkaisun väkertäminen ei ole mielekästä
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
