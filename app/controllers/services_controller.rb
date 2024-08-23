class ServicesController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_service, only: [ :show ]

  def index
    @q = Service.ransack(params[:q])
    @services = @q.result
  end

  def show
  end

  def new
    @service = current_user.services.build
  end

  def create
    @service = current_user.services.build(service_params)
    if @service.save
      redirect_to @service, notice: "Serviço publicado com sucesso!"
    else
      render :new
    end
  end

  private

  def set_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:title, :description, :price)
  end
end
