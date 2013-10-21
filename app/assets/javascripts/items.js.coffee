$ ->
  if $('#item-form').length > 0
    story = null;
    task = $('#task').detach()

    $('#item_item_type').change ->
      value = $("#item_item_type option:selected").val()
      if value is 'story'
        task = $('#task').detach() if $('#task').length > 0
        $('#story-container').append(story)
      else
        story = $('#story').detach() if $('#story').length > 0
        $('#task-container').append(task)
