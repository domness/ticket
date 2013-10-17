class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references  :project
      t.belongs_to  :creator
      t.belongs_to  :assignee
      t.string      :status
      t.integer     :number
      t.string      :score
      t.text        :description
      t.string      :who
      t.string      :what
      t.string      :why
      t.string      :type
      t.timestamps
    end
  end
end
