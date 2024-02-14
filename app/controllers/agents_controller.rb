class AgentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :agent_not_found
  http_basic_authenticate_with name: "admin", password: "123", except: [:index, :show]
  before_action :set_agent, only: [:show, :edit, :update, :destroy]

  def index
    @agents = Agent.order(:role,:name)
  end

  def show
  end

  def new
    @agent = Agent.new
  end

  def create
    @agent = Agent.new(agent_params)

    if @agent.save
      redirect_to @agent
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @agent.update(agent_params)
      redirect_to @agent
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @agent.destroy

    redirect_to action: "index", status: :see_other
  end

  private
    def set_agent
      @agent = Agent.find(params[:id])
    end

    def agent_params
      params.require(:agent).permit(:name, :role, :description, :ability_name, :ability_description)
    end

    def agent_not_found
      flash[:alert] = "Agent not found!"
      redirect_to agents_path
    end

end
