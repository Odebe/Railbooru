json.extract! moderate_task, :id, :task_type, :model_type, :model_id, :creator, :passer, :created_at, :updated_at
json.url moderate_task_url(moderate_task, format: :json)
