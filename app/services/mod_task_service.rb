class ModTaskService
  def self.close(tasks_ids, user)
    tasks_ids.each do |id|
      task = ModerateTask.find_by(id: id)
      next if task.nil?
      task.update(status: 1, passer: user)
      Post.find_by(id: task.model_id).update(status: 1)
    end
  end
end