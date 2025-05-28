# frozen_string_literal: true

class CreateGBlogPosts < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:g_blog_posts)
      create_table    :g_blog_posts do |t|
        t.string      :titulo, null: false
        t.string      :resumo, null: false
        t.text        :conteudo, null: false
        t.datetime    :data_publicacao, null: false
        t.references  :g_blog_categoria, null: false, foreign_key: true
        t.datetime    :deleted_at
        t.timestamps
      end
    end
  end

  def down
    drop_table :g_blog_posts, if_exists: true
  end
end
