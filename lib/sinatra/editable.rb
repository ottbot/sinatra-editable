require 'sinatra/base'

module Sinatra
  module Editable

    module Helpers
      def editable(item)
        path = "#{settings.root}/#{settings.editable_dir}/#{item.to_s}.html"
        if editable_exist?(item)
          File.read(path)
        end
      end

      def editable_exist?(item)
        path = "#{settings.root}/#{settings.editable_dir}/#{item.to_s}.html"
        File.exist?(path)
      end
    end

    def self.registered(app)
      app.helpers Editable::Helpers

      app.set :editable_route,     '/editable'
      app.set :editable_dir,       'editable'
      app.set :editable_templater, :html

      app.get "#{app.editable_route}/*" do
        path = "#{settings.root}/#{settings.editable_dir}/#{params[:splat].join('/')}.#{settings.editable_templater}"
        if File.exist?(path)
          File.read(path)
        else
          'new editable item..'
        end
      end

      app.put "#{app.editable_route}/*" do
        case settings.editable_templater
        when :textile
          new_template = params[:content]
          new_html = RedCloth.new(new_template).to_html
        when :html
          new_html = params[:content]
          new_template = nil
        else
          raise "Bad templater option"
        end
       
        file_basename = params[:splat].pop.gsub(/\/$/,'')
        
        dir = "#{settings.root}/#{settings.editable_dir}/#{params[:splat].join('/')}" 
        
        html_path = "#{dir}/#{file_basename}.html"
        template_path = "#{dir}/#{file_basename}.#{settings.editable_templater}"
        
        FileUtils.mkdir_p dir unless File.exist?(File.dirname(dir))
 
        if new_template
           File.open(template_path,'w') do |f|
            f.print(new_template)
            f.close
          end
        end
        
        File.open(html_path, 'w') do |f|
          f.print(new_html)
          f.close
        end

        new_html
      end
    end

  end

  register Editable
end
