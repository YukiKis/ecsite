module ApplicationHelper
  def full_name(customer)
    return customer.last_name + customer.first_name
  end
end
