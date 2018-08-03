module ApplicationHelper
  def get_param
    params[:search] || {}
  end
end
