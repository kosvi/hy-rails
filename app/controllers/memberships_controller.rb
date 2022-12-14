class MembershipsController < ApplicationController
  before_action :set_membership, only: %i[show edit update destroy confirm_membership]
  before_action :ensure_that_signed_in, only: %i[confirm_membership]

  # GET /memberships or /memberships.json
  def index
    @memberships = Membership.all
  end

  # GET /memberships/1 or /memberships/1.json
  def show
  end

  # GET /memberships/new
  def new
    @membership = Membership.new
    # @beer_clubs = BeerClub.all
    # @beer_clubs = BeerClub.where.not(user: current_user)
    # I am not quite sure if this is enough or should be prevent
    # joining same club twice on database level
    @beer_clubs = BeerClub.where.not(id: current_user.beer_clubs.map(&:id))
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships or /memberships.json
  def create
    @exinsting = Membership.where('user_id = ? AND beer_club_id = ?', current_user, membership_params[:beer_club_id]).first
    raise "already a member" if @exinsting

    @membership = Membership.new(membership_params)
    @membership.user = current_user
    @membership.confirmed = false

    respond_to do |format|
      if @membership.save
        format.html { redirect_to beer_club_url(@membership.beer_club), notice: "Your application to #{@membership.beer_club.name} has been registered #{current_user.username}." }
        format.json { render :show, status: :created, location: @membership }
      else
        @beer_clubs = BeerClub.all
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memberships/1 or /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to membership_url(@membership), notice: "Membership was successfully updated." }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1 or /memberships/1.json
  def destroy
    @membership.destroy

    respond_to do |format|
      format.html { redirect_to user_url(current_user), notice: "Membership in #{@membership.beer_club.name} ended." }
      format.json { head :no_content }
    end
  end

  def confirm_membership
    club = @membership.beer_club
    return unless club.users.include?(current_user)

    @membership.confirmed = true
    @membership.save
    redirect_to club, notice: 'Application confirmed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_membership
    @membership = Membership.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def beer_club_params
    params.permit(:beer_club_id)
  end

  def membership_params
    params.require(:membership).permit(:beer_club_id, :user_id)
  end
end
