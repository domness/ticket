# Defines the helpers for the Item
module ItemHelper

  def item_buttons(project, item)
    case item.status
    when 'backlog'
      link_to 'Start',  start_project_item_path(project.id, item.id),
                        method: :put, class: 'btn btn-xs btn-success'
    when 'current'
      buttons = link_to 'Complete',
                        complete_project_item_path(project.id, item.id),
                        method: :put, class: 'btn btn-xs btn-success'
      buttons << (link_to 'Stop',
                        stop_project_item_path(project.id, item.id),
                        method: :put, class: 'btn btn-xs btn-danger')
    when 'complete'
      link_to 'Reject', reject_project_item_path(project.id, item.id),
                        method: :put, class: 'btn btn-xs btn-danger'
    else
    end
  end

  def item_panel_class(item_type)
    case item_type
    when 'story'
      'panel-success'
    when 'test'
      'panel-info'
    when 'task'
      'panel-warning'
    when 'defect'
      'panel-danger'
    else
    end
  end

end
