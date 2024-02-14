class TeamsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :team_not_found
  http_basic_authenticate_with name: "admin", password: "123", except: [:index, :show]
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  def index
    @teams = Team.order(:name)
  end

  def show
    # @team = Team.find(params[:id])
    # @players = Player.find_by(team: params[:id])
    @players = @team.players
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      redirect_to @team
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @team = Team.find(params[:id])
  end

  def update
    # @team = Team.find(params[:id])

    if @team.update(team_params)
      redirect_to @team
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # @team = Team.find(params[:id])
    @team.destroy

    redirect_to action: "index", status: :see_other
  end

  private
    def set_team
      @team = Team.find(params[:id])
    end

    def team_params
      params.require(:team).permit(:name)
    end

    def team_not_found
      flash[:alert] = "Team not found!"
      redirect_to teams_path
    end

end
