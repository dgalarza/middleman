module Middleman
  module Helpers
    def page_classes(*additional)
      path = request.path_info
      path << options.index_file if path.match(%r{/$})
      path.gsub!(%r{^/}, '')
  
      classes = []
      parts = path.split('.')[0].split('/')
      parts.each_with_index { |path, i| classes << parts.first(i+1).join('_') }

      classes << "index" if classes.empty?
      classes += additional unless additional.empty?
      classes.join(' ')
    end
    
    def link_to(title, url="#", params={})
      params.merge!(:href => url)
      params = params.map { |k,v| %Q{#{k}="#{v}"}}.join(' ')
      %Q{<a #{params}>#{title}</a>}
    end
    
    def asset_url(path, prefix="")
      base_url = File.join(options.http_prefix, prefix)
      path.include?("://") ? path : File.join(base_url, path)
    end

    def image_tag(path, options={})
      options[:alt] ||= ""
      params = options.merge(:src => asset_url(path, self.images_dir))
      params = params.map { |k,v| %Q{#{k}="#{v}"}}.join(' ')
      "<img #{params} />"
    end

    def javascript_include_tag(path, options={})
      params = options.merge(:src => asset_url(path, self.js_dir), :type => "text/javascript")
      params = params.map { |k,v| %Q{#{k}="#{v}"}}.join(' ')
      "<script #{params}></script>"
    end

    def stylesheet_link_tag(path, options={})
      options[:rel] ||= "stylesheet"
      params = options.merge(:href => asset_url(path, self.css_dir), :type => "text/css")
      params = params.map { |k,v| %Q{#{k}="#{v}"}}.join(' ')
      "<link #{params} />"
    end
  end
end
