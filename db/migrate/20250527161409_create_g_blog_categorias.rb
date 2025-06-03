# frozen_string_literal: true

class CreateGBlogCategorias < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:g_blog_categorias)
      create_table :g_blog_categorias do |t|
        t.string   :descricao
        t.string   :created_by
        t.string   :updated_by
        t.datetime :deleted_at
        t.timestamps
      end
    end
  end

  def down
    drop_table :g_blog_categorias if table_exists?(:g_blog_categorias)
  end
end
