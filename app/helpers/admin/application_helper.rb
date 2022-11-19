module Admin::ApplicationHelper
  include Pagy::Frontend

  def raicon_data_attributes
    {
      data: {
        'raicon-controller': controller_path,
        'raicon-action': action_name
      }
    }
  end
end
