# Defines the helpers for the Item
module ItemHelper

  def item_buttons(project, item)
    case item.status
    when 'backlog'
      link_to 'Start',  start_project_item_path(project.id, item.id),
                        method: :put, class: 'btn btn-sm btn-success'
    when 'current'
      buttons = link_to 'Complete',
                        complete_project_item_path(project.id, item.id),
                        method: :put, class: 'btn btn-sm btn-success'
      buttons << (link_to 'Stop',
                        stop_project_item_path(project.id, item.id),
                        method: :put, class: 'btn btn-sm btn-danger')
    when 'complete'
      link_to 'Reject', reject_project_item_path(project.id, item.id),
                        method: :put, class: 'btn btn-sm btn-danger'
    else
    end
  end

end
