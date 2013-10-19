class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references  :project
      t.belongs_to  :creator
      t.belongs_to  :assignee
      t.string      :status, default: 'backlog'
      t.integer     :number
      t.integer     :score, default: 0
      t.text        :description
      t.string      :who
      t.string      :what
      t.string      :why
      t.string      :item_type
      t.string      :title
      t.timestamps
    end
  end
end
