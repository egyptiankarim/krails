# Basic setup stuff.
application "config.app_name = \"#{ARGV[0]}\""

generate(:controller, 'static index about')
route 'root to: "static#index"'
route 'get "about", to: "static#about", as: :about'

# Do all the file copying.
def source_paths
  [File.join(
    File.expand_path(File.dirname(__FILE__)), 'krails_root'
  )] + Array(super)
end

remove_file '.gitignore'
copy_file '.gitignore'

remove_file 'Gemfile'
copy_file 'Gemfile'

inside 'config' do
  inside 'initializers' do
    remove_file 'assets.rb'
    copy_file 'assets.rb'
  end
end

inside 'lib' do
  inside 'assets' do
    inside 'stylesheets' do
      copy_file 'images.css'
      copy_file 'sticky-footer-navbar.css'
      copy_file 'typography.css'
    end
  end
end

inside 'app' do
  inside 'assets' do
    inside 'images' do
      copy_file 'android-chrome-192x192.png'
      copy_file 'android-chrome-512x512.png'
      copy_file 'apple-touch-icon.png'
      copy_file 'favicon-16x16.png'
      copy_file 'favicon-32x32.png'
      copy_file 'favicon.ico'
    end
    inside 'stylesheets' do
      remove_file 'application.css'
      copy_file 'application.css'
    end
  end
  inside 'controllers' do
    remove_file 'static_controller.rb'
    copy_file 'static_controller.rb'
  end
  inside 'helpers' do
    remove_file 'application_helper.rb'
    copy_file 'application_helper.rb'
  end
  inside 'views' do
    inside 'layouts' do
      remove_file 'application.html.erb'
      copy_file 'application.html.erb'
    end
    inside 'shared' do
      copy_file '_foot.html.erb'
      copy_file '_head.html.erb'
      copy_file '_lorem.html.erb'
      copy_file '_nav.html.erb'
      copy_file '_scripts.html.erb'
      copy_file '_short_lorem.html.erb'
    end
    inside 'static' do
      remove_file 'index.html.erb'
      copy_file 'index.html.erb'
    end
    inside 'static' do
      remove_file 'about.html.erb'
      copy_file 'about.html.erb'
    end
  end
end

run 'bundle'

# Set up a repository.
after_bundle do
  git :init
  git add: '-A .'
  git commit: '-m "Initial commit."'
end
