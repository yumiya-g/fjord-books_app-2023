class CreateRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :relationships do |t|
      t.references :mentioning_report, null: false, foreign_key: {to_table: :reports}
      t.references :mentioned_report, null: false, foreign_key: {to_table: :reports}
      t.index [ :mentioning_report_id, :mentioned_report_id ], name: 'index_relationships_mentioning_report_mentioned_report' , unique: true
      t.timestamps
    end
  end
end
