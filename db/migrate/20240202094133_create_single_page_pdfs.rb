class CreateSinglePagePdfs < ActiveRecord::Migration[6.0]
  def change
    create_table :single_page_pdfs do |t|
      t.references :script, null: false, foreign_key: true
      t.integer :page_number

      t.timestamps
    end
  end
end
