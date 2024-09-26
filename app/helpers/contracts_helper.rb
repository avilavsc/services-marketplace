module ContractsHelper
  def status_badge(contract)
    case contract.status
    when "pending"
      content_tag(:span, "Pendente", class: "badge bg-warning")
    when "completed"
      content_tag(:span, "Concluído", class: "badge bg-success")
    when "canceled"
      content_tag(:span, "Cancelado", class: "badge bg-danger")
    end
  end

  def action_button_for_contract(contract)
    case contract.status
    when "pending"
      link_to "Cancelar", contract_path(contract), class: "btn btn-danger btn-sm", data: { turbo_method: :delete, turbo_confirm: "Tem certeza que deseja cancelar este contrato?" }
    when "completed"
      link_to "Avaliar", new_service_review_path(contract.service), class: "btn btn-primary btn-sm"
    end
  end
end
