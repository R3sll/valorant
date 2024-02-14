class PlayersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :player_not_found
  http_basic_authenticate_with name: "admin", password: "123", except: [:index, :show]
  before_action :set_team, only: [:new, :create, :destroy]

  def index
    redirect_to teams_path
  end

  def show
    redirect_to teams_path
  end

  def new
    @player = @team.players.new
  end

  def create
    @player = @team.players.new(player_params)
    if @player.save
      redirect_to @team, notice: "Player was successfully created."
    else
      flash.now[:alert] = "Player creation failed. Check if a player with this name already exists."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @player = @team.players.find(params[:id])
    @player.destroy
    redirect_to team_path(@team), status: :see_other
  end

  private
    def set_team
      @team = Team.find(params[:team_id])
    end

    def player_params
      params.require(:player).permit(:nick, :agent_id)
    end

    def player_not_found
      flash[:alert] = "Player not found!"
      redirect_to teams_path
    end

end
