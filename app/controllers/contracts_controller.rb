class ContractsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service, only: [ :new, :create, :success, :cancel ]
  before_action :set_contract, only: [ :destroy ]

  def index
    @contracts = current_user.contracts.includes(:service)
  end

  def new
    @contract = Contract.new
  end

  def create
    @contract = current_user.contracts.build(service: @service, status: "pending")

    payment_processor = PaymentProcessor.new(@service)
    session = payment_processor.create_checkout_session(
      success_url: success_service_contracts_url(@service),
      cancel_url: cancel_service_contracts_url(@service)
    )

    redirect_to session.url, allow_other_host: true
  end

  def destroy
    if @contract.status == "pending"
      @contract.update(status: "canceled")
      redirect_to contracts_path, notice: "Contrato cancelado com sucesso."
    else
      redirect_to contracts_path, alert: "Não é possível cancelar um contrato que já foi concluído ou cancelado."
    end
  end

  def success
    session_id = params[:session_id]
    session = Stripe::Checkout::Session.retrieve(session_id)

    if session.payment_status == "paid"
      @contract = current_user.contracts.create(service: @service, status: "pending")
      UserMailer.contract_confirmation(@contract).deliver_now
      UserMailer.notify_provider(@contract).deliver_now
      redirect_to contracts_path, notice: "Serviço contratado com sucesso!"
    else
      redirect_to @service, alert: "Falha ao contratar o serviço."
    end
  end

  def cancel
    redirect_to @service, alert: "Pagamento cancelado."
  end

  private

  def set_contract
    @contract = current_user.contracts.find(params[:id])
  end

  def set_service
    @service = Service.find(params[:service_id])
  end
end
