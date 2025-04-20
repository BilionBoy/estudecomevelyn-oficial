SitemapGenerator::Sitemap.default_host = "https://estudecomevelyn.com.br"
SitemapGenerator::Sitemap.public_path = 'public/'
SitemapGenerator::Sitemap.create do
  # Página principal
  add root_path, changefreq: 'daily', priority: 1.0

  # Páginas públicas
  add papelaria_path, changefreq: 'weekly'
  add cursos_path, changefreq: 'weekly'
  add blog_path, changefreq: 'weekly'

  # Categorias
  GCategoria.find_each do |categoria|
    add store_categoria_path(categoria.slug), changefreq: 'weekly', priority: 0.9
  end

 
end
