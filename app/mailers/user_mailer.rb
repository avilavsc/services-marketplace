class UserMailer < ApplicationMailer
  default from: "noreply@marketplace.com"

  def contract_confirmation(contract)
    @contract = contract
    @service = @contract.service
    @user = contract.user
    @provider = @service.user

    mail(to: @user.email, subject: "Confirmação de contratação")
  end

  def notify_provider(contract)
    @contract = contract
    @service = contract.service
    @provider = @service.user

    mail(to: @provider.email, subject: 'Novo Serviço Contratado')
  end
end
